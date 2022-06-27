package com.nike.web.service;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.NoticeDTO;
import com.nike.web.mapper.NoticeMapper;
import com.nike.web.util.PageUtils;
@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper noticeMapper;

	
	@Override
	public void findNotices(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = noticeMapper.selectNoticeCount();
		
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());
		
		List<NoticeDTO> notices = noticeMapper.selectNoticeList(map);
		
		model.addAttribute("notices", notices);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/notice/list"));
		
	}
	
	@Override
	public NoticeDTO findNoticeByNo(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("noticeNo"));
		int noticeNo = Integer.parseInt(opt.orElse("0"));
		
		String requestURI = request.getRequestURI();
		if(requestURI.endsWith("detail")) {
			noticeMapper.updateHit(noticeNo);
		}
		
		NoticeDTO notice = noticeMapper.selectNoticeByNo(noticeNo);
		
		if(notice != null) {
			request.getSession().setAttribute("notice", notice);
		} else {
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('일치하는 게시글이 없습니다.')");
				out.println("history.back()");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}
	
	@Transactional
	@Override
	public int save(HttpServletRequest request) {
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		NoticeDTO notice = new NoticeDTO();
		notice.setNoticeTitle(title);
		notice.setNoticeContent(content);
		
		return noticeMapper.insertNotice(notice);
	}
	
	
	@Override
	public int change(NoticeDTO notice) {
		return noticeMapper.updateNotice(notice);
	}
	
	@Override
	public int remove(int noticeNo) {
		return noticeMapper.deleteNotice(noticeNo);
	}
	
	
		// 목록(Admin)
		@Override
		public void findNotices2(HttpServletRequest request, Model model) {
			// TODO Auto-generated method stub
			Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
			int page = Integer.parseInt(opt.orElse("1"));
			
			int totalRecord = noticeMapper.selectNoticeCount();
			
			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(totalRecord, page);
			
			Map<String, Object> map = new HashMap<>();
			map.put("beginRecord", pageUtils.getBeginRecord());
			map.put("endRecord", pageUtils.getEndRecord());
			
			List<NoticeDTO> notices = noticeMapper.selectNoticeList(map);
			
			model.addAttribute("notices", notices);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/notice/list"));
		}
		
		
		// 상세보기(Admin)
		@Override
		public NoticeDTO findNoticeByNo2(HttpServletRequest request) {
			String requestURI = request.getRequestURI();  // "/ex09/notice/detail"
			String[] arr = requestURI.split("/");         // { "", "ex09", "notice", "detail"}
			
			Long noticeNo = Long.parseLong(request.getParameter("noticeNo"));
			
			return noticeMapper.selectNoticeByNo2(noticeNo); 
		}
		
		// 수정(Admin)
		@Override
		public int change2(HttpServletRequest request) {
			NoticeDTO notice = new NoticeDTO();
			notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
			notice.setNoticeTitle(request.getParameter("noticeTitle"));
			notice.setNoticeContent(request.getParameter("noticeContent"));
			
			return noticeMapper.updateNotice2(notice);
		}
		
		// 개별삭제(Admin)
		@Override
		public int removeOne(HttpServletRequest request) {
			Integer noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
			return noticeMapper.deleteNotice2(noticeNo);
		}
		
		
		// 삽입(Admin)
		@Override
		public int save2(HttpServletRequest request) {
			
			NoticeDTO notice = new NoticeDTO();
			notice.setNoticeTitle(request.getParameter("noticeTitle"));
			notice.setNoticeContent(request.getParameter("noticeContent"));
			
			return noticeMapper.insertNotice2(notice);
		}
		
		
		// 선택삭제(Admin)
		@Override
		public int removeList(HttpServletRequest request) {
			// 한 번에 여러 개 지우기
			// DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
			String[] noticeNoList = request.getParameterValues("noticeNoList");  // {"1", "4"}
			List<Long> list = new ArrayList<>();
			for(int i = 0; i < noticeNoList.length; i++) {
				list.add(Long.parseLong(noticeNoList[i]));  // list.add(1) -> list.add(4)
			}
			return noticeMapper.deleteNoticeList(list);
		}
		
		
}
