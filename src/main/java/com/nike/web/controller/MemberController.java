package com.nike.web.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String signInPage(@RequestParam(required=false) String[] agreements, Model model) {
		model.addAttribute("agreements", agreements);
		return "member/signIn";
	}
	
	@ResponseBody
	@GetMapping(value="/member/idCheck", produces="application/json")
	public Map<String, Object> idCheck(@RequestParam String id) {
		return memberService.idCheck(id);
		// {"res": null}
		// {"res": {"memberNo":1, ...}}
	}
	
	@ResponseBody
	@GetMapping(value="/member/emailCheck", produces="application/json")
	public Map<String, Object> emailCheck(@RequestParam String email) {
		return memberService.emailCheck(email);
		// {"res": null}
		// {"res": {"memberNo":1, ...}}
	}
	
	@ResponseBody
	@GetMapping(value="/member/sendAuthCode", produces="application/json")
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
	public String loginPage(@RequestParam(required=false) String url, Model model) {
		model.addAttribute("url", url);	// member/login.jsp로 url 속성값을 전달한다.
		return "member/login";
	}
	
	
	// login() 메소드 수행 전에 LoginInterceptor의 preHandle() 메소드가 호출
	@PostMapping("/member/login")
	public void login(HttpServletRequest request, HttpServletResponse response) {
		
		String url = request.getParameter("url");
		
		// 아이디, 비밀번호가 일치하는 회원 정보 가져오기
		MemberDTO loginMember = memberService.login(request);
		
		// 아이디, 비밀번호가 일치하는 회원이 있으면 (로그인 성공) LoginIntercepter의 postHandle() 메소드에 회원 정보 전달
		if(loginMember != null) {
			// session에 loginMember 저장
			request.getSession().setAttribute("loginMember", loginMember);		
			// 로그인 이후 이동
			try {
				if(url.toString().isEmpty()) {	// 로그인 이전 화면 정보가 없으면 contextPath 이동
					response.sendRedirect(request.getContextPath());
				} else {	// 로그인 이전 화면 정보가 있으면 해당 화면으로 이동
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
				out.println("alert('일치하는 정보가 없습니다. 아이디와 비밀번호를 확인하세요.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// 로그인 유지를 체크한 경우
		// 1) check 상태   : 파라미터 keepLogin = "keep"
		// 2) uncheck 상태 : 파라미터 keepLogin 자체가 없다. 따라서 null.
		String keepLogin = request.getParameter("keepLogin");
		if(keepLogin != null && keepLogin.equals("keep")) {
			System.out.println("세션아이디 : " + request.getSession().getId());
			
		}
		
		
	}
	// login() 메소드 수행 후에 LoginInterceptor의 postHandle() 메소드가 호출
	
	// LoginInterceptor의 preHandle() 메소드에서 탈퇴자 조회 후 탈퇴자인 경우 처리
	@PostMapping("/member/reSignInPage")
	public String reSignInPage() {
		return "member/reSignIn";
	}
	
	@PostMapping("/member/reSignIn")
	public void reSignIn(HttpServletRequest request, HttpServletResponse response) {
		memberService.reSignIn(request, response);
	}
	
	// 실제 구현에서는 BoardController에 있음
	@GetMapping("/board/savePage")
	public String savePage() {
		return "board/save";
	}
	
	
	
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
		if(loginMember != null) {
			session.invalidate();  // session에 있는 정보 무효화
		}
		return "redirect:/";	// contextPath 이동  
		
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
	public Map<String, Object> checkNowPw(HttpServletRequest request){
		String nowPw = SecurityUtils.sha256(request.getParameter("nowPw"));
		String pw = ((MemberDTO)request.getSession().getAttribute("loginMember")).getPw();
		Map<String, Object> map = new HashMap<>();
		map.put("res", nowPw.equals(pw));
		return map;
	}
	
	@PostMapping("/member/modifyPw")
	public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
		memberService.modifyPw(request, response);
	}
	
	// 아이디 찾기 폼
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
	
	@GetMapping("/member/myOrderPage")
	public String myOrder() {
		return "member/myOrder";
	}
}
