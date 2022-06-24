package com.nike.web.service;

import java.io.PrintWriter;
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
}
