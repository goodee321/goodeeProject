package com.nike.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.nike.web.domain.SignOutMemberDTO;
import com.nike.web.service.MemberService;
import com.nike.web.util.SecurityUtils;

public class LoginInterceptor implements HandlerInterceptor {

	
	@Autowired
	private MemberService memberService;
	
	
	// @PostMapping("/member/login") 요청 이전에 처리
	// 탈퇴자인지 여부 확인
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		// 반환타입이 true 이면 @PostMapping("/member/login") 요청을 수행한다.
		// 반환타입이 false 이면 @PostMapping("/member/login") 요청을 수행하지 않기 때문에 작업을 직접해야 한다.
		
		// 로그인 된 정보가 있다면 기존 로그인 정보를 제거
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") != null) {
			session.removeAttribute("loginMember");
		}
		
		// 탈퇴한 회원인지 확인
		String id = SecurityUtils.xss(request.getParameter("id"));
		SignOutMemberDTO member = memberService.findSignOutMember(id);
		if(member != null) {	// 탈퇴한 회원이면 
			// 탈퇴한 회원의 정보를 가지고 재가입 페이지로 이동
			request.setAttribute("member", member);
			request.getRequestDispatcher("/member/reSignInPage").forward(request, response);
			return false;
		}
		
		return true;
		
	}
	
}
