package com.nike.web.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

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
	
	// @PostMapping("/member/login") 요청 이후에 처리
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		
		// ModelAndView를 Map으로 변환하고 loginMember를 추출
		Map<String, Object> map = modelAndView.getModel();
		Object loginMember =  map.get("loginMember");
		Object url = map.get("url");
		
		
		
		
		// loginMember가 있다면(로그인 성공) session에 저장
		if(loginMember != null) {
			// session에 loginMember 저장
			request.getSession().setAttribute("loginMember", loginMember);
			
			// 로그인 이후 이동
			if(url.toString().isEmpty()) {	// 로그인 이전 화면 정보가 없으면 contextPath 이동
				response.sendRedirect(request.getContextPath());
			} else {	// 로그인 이전 화면 정보가 있으면 해당 화면으로 이동
				response.sendRedirect(url.toString());	
			}
			
		}
		// loginMember가 없다면 로그인 실패(로그인 페이지로 돌려 보내기)
		else {
			if(url.toString().isEmpty()) {
				response.sendRedirect(request.getContentType() + "/member/loginPage");
			} else {
				response.sendRedirect(request.getContentType() + "/member/loginPage?url=" + url.toString());
				
			}
		}
			
		}
	
}
