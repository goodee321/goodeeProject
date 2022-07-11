package com.nike.web.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nike.web.util.PageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.SignOutMemberDTO;
import com.nike.web.mapper.MemberMapper;
import com.nike.web.mapper.OrderMapper;
import com.nike.web.util.SecurityUtils;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private OrderMapper orderMapper;

    @Override
    public Map<String, Object> idCheck(String id) {
        Map<String, Object> map = new HashMap<>();
        map.put("res", memberMapper.selectMemberById(id));
        return map;
    }

    @Override
    public Map<String, Object> emailCheck(String email) {
        Map<String, Object> map = new HashMap<>();
        map.put("res", memberMapper.selectMemberByEmail(email));
        return map;
    }

    @Override
    public Map<String, Object> sendAuthCode(String email) {

        // 인증코드
        String authCode = SecurityUtils.authCode(6); // 6자리 인증코드
        System.out.println(authCode);

        // 필수 속성
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // 구글 메일로 보냅니다.
        props.put("mail.smtp.port", "587"); // 구글 메일 보내는 포트.
        props.put("mail.smtp.auth", "true"); // 인증되었다.
        props.put("mail.smtp.starttls.enable", "true"); // TLS 허용한다.

        // 메일을 보내는 사용자 정보
        final String USERNAME = "ejrrn7437@gmail.com";
        final String PASSWORD = "jgktzrribdatykjw"; // 발급 받은 앱 비밀번호

        // 사용자 정보를 javax.mail.Session에 저장
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(USERNAME, PASSWORD);
            }
        });

        /*
		이메일 보내기
		1. 사용자 정보는 구글 메일만 가능합니다.
		2. 가급적 구글 부계정을 만들어서 사용하세요.
		3. 구글 로그인 - Google 계정 - 보안
		    1) 2단계 인증 - 사용
		    2) 앱 비밀번호
		        (1) 앱 선택 - 기타 (앱 이름은 마음대로)
		        (2) 기기 선택 - Windows 컴퓨터
		        (3) 생성 버튼 - 16자리 비밀번호를 생성해 줌
         */

        // 이메일 전송하기
        try {

            Message message = new MimeMessage(session);

            message.setHeader("Content-Type", "text/plain; charset=UTF-8");
            message.setFrom(new InternetAddress(USERNAME, "인증코드관리자"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("인증 요청 메일입니다.");
            message.setText("인증번호는 " + authCode + "입니다.");

            Transport.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> map = new HashMap<>();
        map.put("authCode", authCode);
        return map;

    }

    @Override
    public void signIn(HttpServletRequest request, HttpServletResponse response) {

        // 파라미터
        String id = SecurityUtils.xss(request.getParameter("id")); // 크로스 사이트 스크립팅
        String pw = SecurityUtils.sha256(request.getParameter("pw")); // SHA-256 암호화
        String name = SecurityUtils.xss(request.getParameter("name")); // 크로스 사이트 스크립팅
        String email = SecurityUtils.xss(request.getParameter("email")); // 크로스 사이트 스크립팅
        String postcode = request.getParameter("postcode");
        String address = request.getParameter("address");
        String addrDetail = request.getParameter("addrDetail");
        String extraAddress = request.getParameter("extraAddress");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String promotion = request.getParameter("promotion");
        int agreeState = 1; // 필수 동의
        if (location.equals("location") && promotion.equals("promotion")) {
            agreeState = 4; // 필수 + 위치 + 프로모션 동의
        } else if (location.equals("location") && promotion.isEmpty()) {
            agreeState = 2; // 필수 + 위치 동의
        } else if (location.isEmpty() && promotion.equals("promotion")) {
            agreeState = 3; // 필수 + 프로모션 동의
        }

        // MemberDTO
        MemberDTO member = MemberDTO.builder()
                .id(id)
                .pw(pw)
                .name(name)
                .email(email)
                .postcode(postcode)
                .address(address)
                .addrDetail(addrDetail)
                .extraAddress(extraAddress)
                .phone(phone)
                .agreeState(agreeState)
                .build();

        // MEMBER 테이블에 member 저장
        int res = memberMapper.insertMember(member);

        // 응답
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == 1) {
                out.println("<script>");
                out.println("alert('회원 가입되었습니다.')");
                out.println("location.href='" + request.getContextPath() + "'");
                out.println("</script>");
                out.close();
            } else {
                out.println("<script>");
                out.println("alert('회원 가입에 실패했습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void signOut(HttpServletRequest request, HttpServletResponse response) {
        // TODO Auto-generated method stub

        // 파라미터
        Optional<String> opt = Optional.ofNullable(request.getParameter("memberNo"));
        Long memberNo = Long.parseLong(opt.orElse("0"));

        // MEMBER 테이블 에서 member 삭제
        int res = memberMapper.deleteMember(memberNo);

        // 응답
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == 1) {
                request.getSession().invalidate(); // session 초기화
                out.println("<script>");
                out.println("alert('회원 탈퇴 하였습니다.')");
                out.println("location.href='" + request.getContextPath() + "'");
                out.println("</script>");
                out.close();
            } else {
                out.println("<script>");
                out.println("alert('회원 탈퇴가 실패했습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public MemberDTO login(HttpServletRequest request) {
        // TODO Auto-generated method stub

        // 파라미터
        String id = SecurityUtils.xss(request.getParameter("id"));
        String pw = SecurityUtils.sha256(request.getParameter("pw"));

        // MemberDTO
        MemberDTO member = MemberDTO.builder()
                .id(id)
                .pw(pw)
                .build();

        // ID/Password가 일치하는 회원 조회
        MemberDTO loginMember = memberMapper.selectMemberByIdPw(member);

        // 로그인 기록 남기기
        if (loginMember != null) {
            memberMapper.insertMemberLog(id);

        }

        return loginMember;

    }

    // 탈퇴한 회원인지 체크
    @Override
    public SignOutMemberDTO findSignOutMember(String id) {
        // TODO Auto-generated method stub
        return memberMapper.selectSignOutMemberById(id);
    }

    @Transactional
    @Override
    public void reSignIn(HttpServletRequest request, HttpServletResponse response) {
        // TODO Auto-generated method stub

        // 파라미터
        Long memberNo = Long.parseLong(request.getParameter("memberNo"));
        String id = request.getParameter("id");
        String pw = SecurityUtils.sha256(request.getParameter("pw"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String postcode = request.getParameter("postcode");
        String address = request.getParameter("address");
        String addrDetail = request.getParameter("addrDetail");
        String extraAddress = request.getParameter("extraAddress");
        String phone = request.getParameter("phone");
        Integer agreeState = Integer.parseInt(request.getParameter("agreeState"));

        // MemberDTO
        MemberDTO member = MemberDTO.builder()
                .memberNo(memberNo)
                .id(id)
                .pw(pw)
                .name(name)
                .email(email)
                .postcode(postcode)
                .address(address)
                .addrDetail(addrDetail)
                .extraAddress(extraAddress)
                .phone(phone)
                .agreeState(agreeState)
                .build();

        // MEMBER 테이블에 member 저장
        int res1 = memberMapper.reInsertMember(member);
        int res2 = memberMapper.deleteSignOutMember(id);

        // 응답
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res1 == 1 && res2 == 1) {
                out.println("<script>");
                out.println("alert('다시 모든 서비스를 이용할 수 있습니다.')");
                out.println("location.href='" + request.getContextPath() + "'");
                out.println("</script>");
                out.close();
            } else {
                out.println("<script>");
                out.println("alert('회원 재가입에 실패했습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void modify(HttpServletRequest request, HttpServletResponse response) {

        // 파라미터
        Long memberNo = Long.parseLong(request.getParameter("memberNo"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String postcode = request.getParameter("postcode");
        String address = request.getParameter("address");
        String addrDetail = request.getParameter("addrDetail");
        String extraAddress = request.getParameter("extraAddress");
        String phone = request.getParameter("phone");
        // agreeState 만듬
        String location = request.getParameter("location");
        String promotion = request.getParameter("promotion");
        Integer agreeState;
        if (location.equals("off") && promotion.equals("off")) {
            agreeState = 1;
        } else if (location.equals("on") && promotion.equals("off")) {
            agreeState = 2;
        } else if (location.equals("off") && promotion.equals("on")) {
            agreeState = 3;
        } else {
            agreeState = 4;
        }

        // MemberDTO
        MemberDTO member = MemberDTO.builder()
                .memberNo(memberNo)
                .name(name)
                .email(email)
                .postcode(postcode)
                .address(address)
                .addrDetail(addrDetail)
                .extraAddress(extraAddress)
                .phone(phone)
                .agreeState(agreeState)
                .build();

        // MEMBER 테이블에 member 저장
        int res = memberMapper.changeMember(member);

        // 응답
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == 1) {
                out.println("<script>");
                out.println("alert('정보를 변경했습니다.')");
                out.println("location.href='" + request.getContextPath() + "'");
                out.println("</script>");
                out.close();
                MemberDTO loginMember = memberMapper.selectMemberByNo(memberNo);
                request.getSession().setAttribute("loginMember", loginMember);
            } else {
                out.println("<script>");
                out.println("alert('정보 변경에 실패했습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void modifyPw(HttpServletRequest request, HttpServletResponse response) {

        // 파라미터
        Long memberNo = Long.parseLong(request.getParameter("memberNo"));
        String pw = SecurityUtils.sha256(request.getParameter("pw"));

        // MemberDTO
        MemberDTO member = MemberDTO.builder()
                .memberNo(memberNo)
                .pw(pw)
                .build();

        // MEMBER 테이블에 member 저장
        int res = memberMapper.changeMemberPw(member);

        // 응답
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == 1) {
                out.println("<script>");
                out.println("alert('비밀번호를 변경했습니다.')");
                out.println("location.href='" + request.getContextPath() + "'");
                out.println("</script>");
                out.close();
                HttpSession session = request.getSession();
                if (session.getAttribute("loginMember") != null) {
                    // 마이페이지에서 비밀번호 수정한 경우
                    MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
                    loginMember.setPw(pw);
                } else {
                    // 비밀번호 찾기한 경우
                }
            } else {
                out.println("<script>");
                out.println("alert('비밀번호가 변경되지 않았습니다.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void findId(HttpServletRequest request, HttpServletResponse response) {

        String email = request.getParameter("email");
        MemberDTO member = memberMapper.findMemberId(email);

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (member == null) {
                out.println("<script>");
                out.println("alert('가입된 아이디가 없습니다.')");
                out.println("history.back();");
                out.println("</script>");
                out.close();
            } else {
                request.setAttribute("id", member.getId());
                request.getRequestDispatcher("/member/findId/result").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // 비밀번호 찾기 과정
    @Override
    public void findPw(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        MemberDTO member = MemberDTO.builder()
                .id(id)
                .email(email)
                .phone(phone)
                .build();

        MemberDTO res = memberMapper.findMemberPw(member);

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == null) {
                out.println("<script>");
                out.println("alert('일치하는 회원 정보를 찾을 수 없습니다.')");
                out.println("history.back();");
                out.println("</script>");
                out.close();
            } else {
                request.setAttribute("memberNo", res.getMemberNo());
                request.getRequestDispatcher("/member/createNewPw").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    // 재가입 중간 과정
    @Override
    public void beforeReSign(HttpServletRequest request, HttpServletResponse response) {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        SignOutMemberDTO member = SignOutMemberDTO.builder()
                .name(name)
                .email(email)
                .phone(phone)
                .build();

        SignOutMemberDTO res = memberMapper.beforeMemberReSign(member);
        System.out.println(res);

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res == null) {
                out.println("<script>");
                out.println("alert('일치하는 회원 정보를 찾을 수 없습니다.')");
                out.println("history.back();");
                out.println("</script>");
                out.close();
            } else {
                request.setAttribute("member", res);
                request.getRequestDispatcher("/member/reSignInPage").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<MemberDTO> getMemberByNo(long memberNo) {
        return memberMapper.getMemberByNo(memberNo);
    }

    @Override
    public void orderList(long memberNo, Model model, HttpServletRequest request) {

        int totalRecord = orderMapper.selectOrderCntByMemberNo(memberNo);

        PageUtils pageUtils = new PageUtils();
        Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
        int page = Integer.parseInt(opt.orElse("1"));

        pageUtils.setPageEntity(totalRecord, page);

        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("beginRecord", pageUtils.getBeginRecord() - 1);
        map.put("recordPerPage", pageUtils.getRecordPerPage());

        model.addAttribute("orderCount", orderMapper.selectOrderCntByMemberNo(memberNo));
        model.addAttribute("orderList", orderMapper.selectOrderByMemberNo(map));
        model.addAttribute("totalRecord", totalRecord);
        model.addAttribute("paging", pageUtils.getPagings(request.getContextPath() + "/member/order/list"));
    }

    @Override
    public void OrderDetail(String orderId, Model model) {
        model.addAttribute("products", orderMapper.selectProductDetailByOrderId(orderId));
        model.addAttribute("memberInfo", orderMapper.selectInfoByOrderId(orderId));
        model.addAttribute("orderCnt", orderMapper.selectCountByOrderId(orderId));
    }

}