package com.nike.web.service;

import java.io.Console;
import java.io.PrintWriter;
import java.util.Date;
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

import com.nike.web.domain.QnaDTO;
import com.nike.web.mapper.QnaMapper;
import com.nike.web.util.PageUtils;

@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaMapper qnaMapper;
	
	@Override
	public void findQnas(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = qnaMapper.selectQnaCount();

		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, page);

		Map<String, Object> map = new HashMap<>();
		map.put("beginRecord", pageUtils.getBeginRecord());
		map.put("endRecord", pageUtils.getEndRecord());

		List<QnaDTO> qnas = qnaMapper.selectQnaList(map);
				
		model.addAttribute("qnas", qnas);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/qna/list"));
	}
	
	@Override
		public void findQnaByNo(HttpServletRequest request, HttpServletResponse response, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("qnaNo"));
		Integer qnaNo = Integer.parseInt(opt.orElse("0"));
		
		// 게시글 
		QnaDTO qna = qnaMapper.selectQnaByNo(qnaNo);
		
		if(qna != null) {	
			request.getSession().setAttribute("qna", qna);
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
			
		}
	
	@Override
	public int saveQna(HttpServletRequest request) {

		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		QnaDTO qna = new QnaDTO();
		qna.setId(id);
		qna.setQnaTitle(title);
		qna.setQnaContent(content);
				
		return qnaMapper.insertQna(qna);
	}
	
	@Override
	public int save(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		
		QnaDTO qna = QnaDTO.builder()
				.id(id)
				.qnaTitle(title)
				.qnaContent(content)
				.build();
		
		return qnaMapper.insertQna(qna);
	}
	
	@Transactional
	@Override
	public int saveReply(HttpServletRequest request) {

		String id = request.getParameter("id");
		String qnaContent = request.getParameter("qnaContent");

		int qnaDepth = Integer.parseInt(request.getParameter("qnaDepth"));
		int qnaGroupNo = Integer.parseInt(request.getParameter("qnaGroupNo"));
		int qnaGroupOrd = Integer.parseInt(request.getParameter("qnaGroupOrd"));
	
		// 원글 DTO
		QnaDTO qna = new QnaDTO();
		qna.setQnaDepth(qnaDepth);
		qna.setQnaGroupNo(qnaGroupNo);
		qna.setQnaGroupOrd(qnaGroupOrd);
		qnaMapper.updatePreviousReply(qna);
		
		// 댓글
		QnaDTO reply = new QnaDTO();
		reply.setId(id);
		reply.setQnaContent(qnaContent);
		reply.setQnaDepth(qnaDepth + 1);
		reply.setQnaGroupNo(qnaGroupNo);
		reply.setQnaGroupOrd(qnaGroupOrd + 1);
			
		return qnaMapper.insertReply(reply);
	}
	
	@Override
	public int remove(int qnaNo) {
		return qnaMapper.deleteQna(qnaNo);
	}
}
