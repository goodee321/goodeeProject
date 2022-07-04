package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;

public interface AdminMemberService {

	
	
	
	
	
	
		// 전체목록
		public void getMembers(HttpServletRequest request, Model model);
		
		// 검색목록
		public void findMembers(HttpServletRequest request, Model model);
			
		
		
		
		
		
		
		// 삭제(선택해서삭제)
		public int removeList(HttpServletRequest request);
			
		// 세부사항
		public MemberDTO findMemberByNo(HttpServletRequest request);
			
		// 수정
		public int change(HttpServletRequest request);
		
		// 개별삭제
		public int removeOne(HttpServletRequest request);
		
}
