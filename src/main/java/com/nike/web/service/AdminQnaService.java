package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface AdminQnaService {

	
	
		// 전체목록
		public void findQnas(HttpServletRequest request, Model model);
		
		
		// 상세보기
		public void findQnaByNo(HttpServletRequest request, Model model);
		
		
		// 수정
		public void change(HttpServletRequest request, HttpServletResponse response);
		
		
		// 삭제
		public int removeQna(int qnaNo);
		
		// 삽입
		public int saveQna(HttpServletRequest request);
		
		
		// 댓글삽입
		public int saveReply(HttpServletRequest request);
}
