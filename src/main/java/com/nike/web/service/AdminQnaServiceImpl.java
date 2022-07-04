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

import com.nike.web.domain.QnaDTO;
import com.nike.web.mapper.AdminQnaMapper;
import com.nike.web.mapper.QnaMapper;
import com.nike.web.util.PageUtils;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {

	@Autowired
	private AdminQnaMapper adminQnaMapper;
	
	
	
	// [admin]
	
		@Override
		public void findQnas(HttpServletRequest request, Model model) {
			
			Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
			int page = Integer.parseInt(opt.orElse("1"));
			
			int totalRecord = adminQnaMapper.selectQnaCount();

			PageUtils pageUtils = new PageUtils();
			pageUtils.setPageEntity(totalRecord, page);

			Map<String, Object> map = new HashMap<>();
			map.put("beginRecord", pageUtils.getBeginRecord() - 1);
			map.put("endRecord", pageUtils.getEndRecord());

			List<QnaDTO> qnas = adminQnaMapper.selectQnaList(map);
					
			model.addAttribute("qnas", qnas);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/qna/list"));
		}
		
		//
		@Override
		public void findQnaByNo(HttpServletRequest request, Model model) {
			
			Optional<String> opt = Optional.ofNullable(request.getParameter("qnaNo"));
			Integer qnaNo = Integer.parseInt(opt.orElse("0"));
			
			// 게시글 
			QnaDTO qna = adminQnaMapper.selectQnaByNo(qnaNo);
			
			model.addAttribute("qna", adminQnaMapper.selectQnaByNo(qnaNo));
		
			}
		
		//
		@Override
		public void change(HttpServletRequest request, HttpServletResponse response) {
			
			int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
			String qnaTitle = request.getParameter("qnaTitle");
			String qnaContent = request.getParameter("qnaContent");
			
			QnaDTO qna = QnaDTO.builder()
					.qnaNo(qnaNo)
					.qnaTitle(qnaTitle)
					.qnaContent(qnaContent)
					.build();
			int qnaResult = adminQnaMapper.updateQna(qna);
			
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(qnaResult == 1) {
					out.println("<script>");
					out.println("alert('질문이 수정되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/admin/qna/list?qnaNo=" + qnaNo + "'");
					out.println("</script>");
					out.close();
				} else {
					out.println("<script>");
					out.println("alert('질문이 수정되지 않았습니다.')");
					out.println("history.back()");
					out.println("</script>");
					out.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		@Override
		public int removeQna(int qnaNo) {
			return adminQnaMapper.deleteQna(qnaNo);
		}
		
		
		
		
		@Override
		public int saveQna(HttpServletRequest request) {

			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			
			QnaDTO qna = QnaDTO.builder()
					.id(id)
					.qnaTitle(title)
					.qnaContent(content)
					.build();
			
			return adminQnaMapper.insertQna(qna);
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
			adminQnaMapper.updatePreviousReply(qna);
			
			// 댓글
			QnaDTO reply = new QnaDTO();
			reply.setId(id);
			reply.setQnaContent(qnaContent);
			reply.setQnaDepth(qnaDepth + 1);
			reply.setQnaGroupNo(qnaGroupNo);
			reply.setQnaGroupOrd(qnaGroupOrd + 1);
				
			return adminQnaMapper.insertReply(reply);
		}
	
	
}
