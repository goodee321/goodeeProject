package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface AdminQnaService {

	
	
		// admin
		public void findQnas(HttpServletRequest request, Model model);
		
		
		// admin
		public void findQnaByNo(HttpServletRequest request, Model model);
		
		
		// admin
		public void change(HttpServletRequest request, HttpServletResponse response);
		
		
		// admin
		public int removeQna(int qnaNo);
		
		// 
		public int saveQna(HttpServletRequest request);
		
		
		//
		public int saveReply(HttpServletRequest request);
}
