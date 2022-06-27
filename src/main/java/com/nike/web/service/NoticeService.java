package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.NoticeDTO;

public interface NoticeService {

	public void findNotices(HttpServletRequest request, Model model);
	
	public NoticeDTO findNoticeByNo(HttpServletRequest request, HttpServletResponse response, Model model);
	public int save(HttpServletRequest request);
	public int change(NoticeDTO notice);
	public int remove(int noticeNo);
	
	
	
		// 목록(Admin)
		public void findNotices2(HttpServletRequest request, Model model);
		
		// 세부사항(Admin)
		public NoticeDTO findNoticeByNo2(HttpServletRequest request);
	
		// 수정(Admin)
		public int change2(HttpServletRequest request);
		
		
		// 개별삭제(Admin)
		public int removeOne(HttpServletRequest request);
		
		public int save2(HttpServletRequest request);
	
	
}
