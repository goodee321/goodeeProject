package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface QnaService {
	public void findQnas(HttpServletRequest request, Model model);
	public int saveQna(HttpServletRequest request);
	public void findQnaByNo(HttpServletRequest request, Model model);
	public int saveReply(HttpServletRequest request);
	public void change(HttpServletRequest request, HttpServletResponse response);
	public int removeQna(int qnaNo);
<<<<<<< HEAD
	
	
	
	
	
	
	
	
	
	
	
	
	
	
=======
>>>>>>> main
}
