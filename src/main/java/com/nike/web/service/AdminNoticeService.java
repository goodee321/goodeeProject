package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.NoticeDTO;

public interface AdminNoticeService {

	
	
	
			// 목록(Admin)
			public void findNotices(HttpServletRequest request, Model model);
			
			
			public void getNotices(HttpServletRequest request, Model model);
			
			
			
			
			// 세부사항(Admin)
			public NoticeDTO findNoticeByNo(HttpServletRequest request);
		
			// 수정(Admin)
			public int change(HttpServletRequest request);
			
			
			// 개별삭제(Admin)
			public int removeOne(HttpServletRequest request);
			
			// 삽입(Admin)
			public int save(HttpServletRequest request);
			
			// 삭제(선택해서삭제, Admin)
			public int removeList(HttpServletRequest request);
			
}
