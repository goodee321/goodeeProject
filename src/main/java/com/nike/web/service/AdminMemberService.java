package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;

public interface AdminMemberService {

	
	
	
	
	
	
		// 목록(Admin)
		public void getMembers(HttpServletRequest request, Model model);
		
		// 
		public void findMembers(HttpServletRequest request, Model model);
			
		
		
		
		
		
		
		// 삭제(선택해서삭제, Admin)
		public int removeList(HttpServletRequest request);
			
		// 세부사항(Admin)
		public MemberDTO findMemberByNo(HttpServletRequest request);
			
		// 수정(Admin)
		public int change(HttpServletRequest request);
		
		// 개별삭제(Admin)
		public int removeOne(HttpServletRequest request);
		
}
