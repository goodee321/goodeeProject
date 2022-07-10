package com.nike.web.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.nike.web.domain.MemberDTO;

public class AdminInterceptor implements HandlerInterceptor {

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		
		
	
		
		MemberDTO loginMember = (MemberDTO) request.getSession().getAttribute("loginMember");
		
	
		if(loginMember == null || loginMember.getMemberNo() != 5) {
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('해당 페이지는 관리자 권한이 필요합니다.')");
			out.println("location.href='" + request.getContextPath() + "'");
			out.println("</script>");
			out.close();
			return false;	
		}
		
		return true;
		
		
	}
	
}
