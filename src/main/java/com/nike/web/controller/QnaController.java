package com.nike.web.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.nike.web.service.QnaService;

@Controller
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	@GetMapping("/qna/list")
	public String list(HttpServletRequest request, Model model) {
		qnaService.findQnas(request, model);
		return "qna/list"; 
	}
	
	@GetMapping("/qna/saveQna")
	public String saveQna() {
		return "qna/save";
	}
	
	@PostMapping("/qna/save")
	public void save(HttpServletRequest request, HttpServletResponse response) {
		int res = qnaService.saveQna(request);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res > 0) {
				out.println("<script>");
				out.println("alert('게시글이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/list'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('게시글이 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@GetMapping("/qna/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
		qnaService.findQnaByNo(request, model);
		return "qna/detail";
	}
	
	@PostMapping("/qna/saveReply")
	public void saveReply(HttpServletRequest request, HttpServletResponse response) {
		int res = qnaService.saveReply(request);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res > 0) {
				out.println("<script>");
				out.println("alert('답변이 등록되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/list'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('답변이 등록되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/qna/changePage")
	public String changePage(HttpServletRequest request, Model model) {
		qnaService.findQnaByNo(request, model);
		return "qna/change";
	}
	
	@PostMapping("/qna/change")
	public void change(HttpServletRequest request, HttpServletResponse response) {
		qnaService.change(request, response);
	}
	
	@GetMapping("/qna/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response){
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		int res = qnaService.removeQna(qnaNo);
		try {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			if(res > 0) {
				out.println("<script>");
				out.println("alert('게시글이 삭제되었습니다.')");
				out.println("location.href='" + request.getContextPath() + "/qna/list'");
				out.println("</script>");
				out.close();
			} else {
				out.println("<script>");
				out.println("alert('게시글이 삭제되지 않았습니다.')");
				out.println("history.back()");
				out.println("</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
			
	}
}
