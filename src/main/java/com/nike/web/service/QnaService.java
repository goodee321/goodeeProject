package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

public interface QnaService {
	
	public void findQnas(HttpServletRequest request, Model model);
	public int saveQna(HttpServletRequest request);
	public void findQnaByNo(HttpServletRequest request, HttpServletResponse response, Model model);
	public int save(HttpServletRequest request);
	public int saveReply(HttpServletRequest request);
	public int remove(int qnaNo);
}
