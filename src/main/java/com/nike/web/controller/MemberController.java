package com.nike.web.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.nike.web.domain.OrderDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.nike.web.domain.MemberDTO;
import com.nike.web.service.MemberService;
import com.nike.web.util.SecurityUtils;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/member/agreePage")
    public String agreePage() {
        return "member/agree";
    }

    @GetMapping("/member/signInPage")
    public String signInPage(@RequestParam(required = false) String[] agreements, Model model) {
        model.addAttribute("agreements", agreements);
        return "member/signIn";
    }

    @ResponseBody
    @GetMapping(value="/member/idCheck", produces = "application/json")
    public Map<String, Object> idCheck(@RequestParam String id) {
        return memberService.idCheck(id);
        // {"res": null}
        // {"res": {"memberNo":1, ...}}
    }

    @ResponseBody
    @GetMapping(value="/member/emailCheck", produces = "application/json")
    public Map<String, Object> emailCheck(@RequestParam String email) {
        return memberService.emailCheck(email);
        // {"res": null}
        // {"res": {"memberNo":1, ...}}
    }

    @ResponseBody
    @GetMapping(value="/member/sendAuthCode", produces = "application/json")
    public Map<String, Object> sendAuthCode(@RequestParam String email) {
        return memberService.sendAuthCode(email);
    }

    @PostMapping("/member/signIn")
    public void signIn(HttpServletRequest request, HttpServletResponse response) {
        memberService.signIn(request, response);
    }

    @GetMapping("/member/signOut")
    public void signOut(HttpServletRequest request, HttpServletResponse response) {
        memberService.signOut(request, response);
    }

    @GetMapping("/member/loginPage")
    public String loginPage(@RequestParam(required = false) String url, Model model) {
        model.addAttribute("url", url);    // member/login.jsp??? url ???????????? ????????????.
        return "member/login";
    }


    // login() ????????? ?????? ?????? LoginInterceptor??? preHandle() ???????????? ??????
    @PostMapping("/member/login")
    public void login(HttpServletRequest request, HttpServletResponse response) {

        String url = request.getParameter("url");

        // ?????????, ??????????????? ???????????? ?????? ?????? ????????????
        MemberDTO loginMember = memberService.login(request);

        // ?????????, ??????????????? ???????????? ????????? ????????? (????????? ??????) LoginIntercepter??? postHandle() ???????????? ?????? ?????? ??????
        if (loginMember != null) {
            // session??? loginMember ??????
            request.getSession().setAttribute("loginMember", loginMember);
            // ????????? ?????? ??????
            try {
                if (url.toString().isEmpty()) {    // ????????? ?????? ?????? ????????? ????????? contextPath ??????
                    response.sendRedirect("/");
                } else {    // ????????? ?????? ?????? ????????? ????????? ?????? ???????????? ??????
                    response.sendRedirect(url.toString());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('???????????? ????????? ????????????. ???????????? ??????????????? ???????????????.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ????????? ????????? ????????? ??????
        // 1) check ??????   : ???????????? keepLogin = "keep"
        // 2) uncheck ?????? : ???????????? keepLogin ????????? ??????. ????????? null.
        String keepLogin = request.getParameter("keepLogin");
        if (keepLogin != null && keepLogin.equals("keep")) {
            System.out.println("??????????????? : " + request.getSession().getId());

        }


    }
    // login() ????????? ?????? ?????? LoginInterceptor??? postHandle() ???????????? ??????

    // LoginInterceptor??? preHandle() ??????????????? ????????? ?????? ??? ???????????? ?????? ??????
    @PostMapping("/member/reSignInPage")
    public String reSignInPage() {
        return "member/reSignIn";
    }

    @PostMapping("/member/reSignIn")
    public void reSignIn(HttpServletRequest request, HttpServletResponse response) {
        memberService.reSignIn(request, response);
    }

    // ?????? ??????????????? BoardController??? ??????
    @GetMapping("/board/savePage")
    public String savePage() {
        return "board/save";
    }


    @GetMapping("/member/logout")
    public String logout(HttpSession session) {
        MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
        if (loginMember != null) {
            session.invalidate();
        }
        return "redirect:/";    // contextPath ??????

    }

    @GetMapping("/member/myInfoPage")
    public String myInfoPage() {
        return "member/myInfo";
    }

    @PostMapping("/member/modify")
    public void modify(HttpServletRequest request, HttpServletResponse response) {
        memberService.modify(request, response);
    }

    @GetMapping("/member/editPw")
    public String editPw() {
        return "member/changePw";
    }

    @ResponseBody
    @PostMapping(value="/member/checkNowPw", produces="application/json")
    public Map<String, Object> checkNowPw(HttpServletRequest request) {
        String nowPw = SecurityUtils.sha256(request.getParameter("nowPw"));
        String pw = ((MemberDTO) request.getSession().getAttribute("loginMember")).getPw();
        Map<String, Object> map = new HashMap<>();
        map.put("res", nowPw.equals(pw));
        return map;
    }

    @PostMapping("/member/modifyPw")
    public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
        memberService.modifyPw(request, response);
    }

    // ????????? ?????? ???
    @GetMapping("/member/findIdForm")
    public String findIdForm() {
        return "member/findIdForm";
    }

    @GetMapping("/member/findId")
    public void findId(HttpServletRequest request, HttpServletResponse response) {
        memberService.findId(request, response);
    }

    @GetMapping("/member/findId/result")
    public String findIdResult() {
        return "member/findId";
    }

    @GetMapping("/member/findPwForm")
    public String findPwForm() {
        return "member/findPwForm";
    }

    @GetMapping("/member/findPw")
    public void findPw(HttpServletRequest request, HttpServletResponse response) {
        memberService.findPw(request, response);
    }

    @GetMapping("/member/createNewPw")
    public String createNewPw() {
        return "member/createNewPw";
    }
    
    @PostMapping("/member/beforeReSignForm")
    public String beforeReSignForm() {
    	return "member/beforeReSignForm";
    }
    
    @PostMapping("/member/beforeReSign")
    public void beforeReSign(HttpServletRequest request, HttpServletResponse response) {
    	memberService.beforeReSign(request, response);
    }

    // nyk
    
    @GetMapping("/member/order/list")
    public String orderList(HttpSession session, Model model, HttpServletRequest request) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        long memberNo = loginMember.getMemberNo();
        memberService.orderList(memberNo, model, request);
        return "member/order/list";
    }

    @GetMapping("/member/order/detail/{orderId}")
    public String orderDetail(@PathVariable("orderId") String orderId, Model model) {
        memberService.OrderDetail(orderId, model);
        return "member/order/detail";
    }

	
}
