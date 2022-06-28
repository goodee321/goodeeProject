package com.nike.web.service;

import java.io.PrintWriter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import java.util.HashMap;

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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.ui.Model;


import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.SignOutMemberDTO;
import com.nike.web.mapper.MemberMapper;

import com.nike.web.util.PageUtils;

import com.nike.web.util.SecurityUtils;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;
	
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
		String authCode = SecurityUtils.authCode(6);    // 6자리 인증코드
		System.out.println(authCode);
		
		// 필수 속성
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");  // 구글 메일로 보냅니다.
		props.put("mail.smtp.port", "587");             // 구글 메일 보내는 포트.
		props.put("mail.smtp.auth", "true");            // 인증되었다.
		props.put("mail.smtp.starttls.enable", "true"); // TLS 허용한다.
		
		// 메일을 보내는 사용자 정보
		final String USERNAME = "forspringlec@gmail.com";
		final String PASSWORD = "ukpiajijxfirdgcz";     // 발급 받은 앱 비밀번호
		
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
		String id = SecurityUtils.xss(request.getParameter("id"));        // 크로스 사이트 스크립팅
		String pw = SecurityUtils.sha256(request.getParameter("pw"));     // SHA-256 암호화
		String name = SecurityUtils.xss(request.getParameter("name"));    // 크로스 사이트 스크립팅
		String email = SecurityUtils.xss(request.getParameter("email"));  // 크로스 사이트 스크립팅
		String address = request.getParameter("address");
		String addrDetail = request.getParameter("addrDetail");
		String phone = request.getParameter("phone");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
		int agreeState = 1;  // 필수 동의
		if(location.equals("location") && promotion.equals("promotion")) {
			agreeState = 4;  // 필수 + 위치 + 프로모션 동의
		} else if(location.equals("location") && promotion.isEmpty()) {
			agreeState = 2;  // 필수 + 위치 동의
		} else if(location.isEmpty() && promotion.equals("promotion")) {
			agreeState = 3;  // 필수 + 프로모션 동의
		}
		
		// MemberDTO
		MemberDTO member = MemberDTO.builder()
				.id(id)
				.pw(pw)
				.name(name)
				.email(email)
				.address(address)
				.addrDetail(addrDetail)
				.phone(phone)
				.agreeState(agreeState)
				.build();
		
		// MEMBER 테이블에 member 저장
		int res = memberMapper.insertMember(member);
		
		// 응답
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res == 1) {
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
					if(res == 1) {
						request.getSession().invalidate();	// session 초기화
						out.println("<script>");
						out.println("alert('Good Bye!')");
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
		if(loginMember != null) {
			memberMapper.insertMemberLog(id);
			
		}
				
		return loginMember;
		
	}
	
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
		String address = request.getParameter("address");
		String addrDetail = request.getParameter("addrDetail");
		String phone = request.getParameter("phone");
		Integer agreeState = Integer.parseInt(request.getParameter("agreeState"));
		
		// MemberDTO
		MemberDTO member = MemberDTO.builder()
				.memberNo(memberNo)
				.id(id)
				.pw(pw)
				.name(name)
				.email(email)
				.address(address)
				.addrDetail(addrDetail)
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
			if(res1 == 1 && res2 == 1) {
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
	
	

	
		// 목록(Admin)
		@Override
		public void getMembers(HttpServletRequest request, Model model ) {
			// TODO Auto-generated method stub
			
			Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
			int page = Integer.parseInt(opt.orElse("1"));
			
			int totalRecord = memberMapper.selectMemberCount();
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(totalRecord, page);
			
			Map<String, Object> map = new HashMap<>();
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("endRecord", pageUtils.getEndRecord());
			
			List<MemberDTO> members = memberMapper.selectMemberList(map);
			
			model.addAttribute("members", members);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/member/list"));
			
			
//			int page = 1;
//			String strPage = request.getParameter("page");
//			if(strPage != null) {
//				page = Integer.parseInt(strPage);
//			}
			
			
		}
		
		
		@Override
		public void findMembers(HttpServletRequest request, Model model) {
			// TODO Auto-generated method stub
			// request에서 page 파라미터 꺼내기
			// page 파라미터는 전달되지 않는 경우 page = 1을 사용
			Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
			int page = Integer.parseInt(opt.orElse("1"));
			
			
			// column, query, begin, end 파라미터 꺼내기
			String column = request.getParameter("column");
			String query = request.getParameter("query");
			
			
			// column + query + begin + end => Map
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			
			// 검색된 레코드 갯수 가져오기
			int findRecord = memberMapper.selectFindCount(map);
			
			// findRecord와 page를 알면 PageEntity를 모두 계산할 수 있다.
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(findRecord, page);
			
			// beginRecord + endRecord => Map
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("endRecord", pageUtils.getEndRecord());
			
			// beginRecord ~ endRecord 사이 검색된 목록 가져오기
			List<MemberDTO> members = memberMapper.selectFindList(map);
			
			// list.jsp로 forward할 때 가지고 갈 속성 저장하기
			model.addAttribute("members", members);
			model.addAttribute("beginNo", findRecord - pageUtils.getRecordPerPage() * (page - 1));
			
			// 검색 카테고리에 따라서 전달되는 파라미터가 다름
			switch(column) {
			case "ID":
			case "NAME":
				model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/member/search?column=" + column + "&query=" + query));
				break;
			
			}
		}
		
		
		@Override
		public Map<String, Object> autoComplete(HttpServletRequest request) {
			
			String column = request.getParameter("column");
			String query = request.getParameter("query");
			
			Map<String, Object> map = new HashMap<>();
			map.put("column", column);
			map.put("query", query);
			
			List<MemberDTO> list = memberMapper.autoComplete(map);
			
			Map<String, Object> result = new HashMap<>();
			if(list.size() == 0) {
				result.put("status", 400);
				result.put("list", null);
			} else {
				result.put("status", 200);
				result.put("list", list);
			}
			if(column.equals("ID")) {
				result.put("column", "ID");
			} else if(column.equals("NAME")) {
				result.put("column", "NAME");
			}
			
			return result;
			
			/*  
			    Map result는 jackson에 의해서 아래 JSON으로 변환된다.
				{
					"status": 200,
					"list": [ {}, {}, {} ],
					"column": "firstName"
				}
			*/
			
		}
		
		
		// 선택삭제(Admin)
		@Override
		public int removeList2(HttpServletRequest request) {
			// 한 번에 여러 개 지우기
			// DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
			String[] memberNoList = request.getParameterValues("memberNoList");  // {"1", "4"}
			List<Long> list = new ArrayList<>();
			for(int i = 0; i < memberNoList.length; i++) {
				list.add(Long.parseLong(memberNoList[i]));  // list.add(1) -> list.add(4)
			}
			return memberMapper.deleteMemberList(list);
		}
		
		
		// 상세보기(Admin)
		@Override
		public MemberDTO findMemberByNo(HttpServletRequest request) {
			// TODO Auto-generated method stub
			
			String requestURI = request.getRequestURI();  // "/ex09/notice/detail"
			String[] arr = requestURI.split("/");         // { "", "ex09", "notice", "detail"}
			
			Long memberNo = Long.parseLong(request.getParameter("memberNo"));
			
			return memberMapper.selectMemberByNo(memberNo); 
		}
		
		// 수정(Admin)
		@Override
		public int change(HttpServletRequest request) {
			MemberDTO member = new MemberDTO();
			member.setMemberNo(Long.parseLong(request.getParameter("memberNo")));
			member.setName(request.getParameter("name"));
			member.setEmail(request.getParameter("email"));
			member.setAddress(request.getParameter("address"));
			member.setAddrDetail(request.getParameter("addrDetail"));
			member.setPhone(request.getParameter("phone"));
			return memberMapper.updateMember(member);
		}
	
		
		//개별삭제(Admin)
		@Override
		public int removeOne(HttpServletRequest request) {
			Long memberNo = Long.parseLong(request.getParameter("memberNo"));
			return memberMapper.deleteMember2(memberNo);
		}
		

}
