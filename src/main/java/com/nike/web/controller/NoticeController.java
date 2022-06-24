package com.nike.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nike.web.domain.NoticeDTO;
import com.nike.web.service.NoticeService;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/notice/list")
	public String list(HttpServletRequest request, Model model) {
		request.getSession().removeAttribute("notice");
		noticeService.findNotices(request, model);
		return "notice/list";
	}
	
	@GetMapping("/notice/savePage")
	public String savePage() {
		return "notice/save";
	}
	
	@PostMapping("/notice/save")
	public String save(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("insRes", noticeService.save(request));
		redirectAttributes.addFlashAttribute("type", "insert");
		return "redirect:/notice/result";  
	}
	
	@GetMapping("/notice/result")
	public String result() {
		return "notice/result";
	}
	
	
	@GetMapping("/notice/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
		noticeService.findNoticeByNo(request, response, model);
		return "notice/detail";
	}

	
	@GetMapping("/notice/changePage")
	public String changePage() {
		return "notice/change";
	}
	
	@PostMapping("/notice/change")
	public String change(NoticeDTO notice, RedirectAttributes redirectAttributes) {
		System.out.println(notice);
		redirectAttributes.addFlashAttribute("updRes", noticeService.change(notice));
		redirectAttributes.addFlashAttribute("type", "update");
		return "redirect:/notice/result";
	}
	
	@GetMapping("/notice/removeOne")
	public String remove(@RequestParam(value="noticeNo", required=false, defaultValue="0") int noticeNo, RedirectAttributes redirectAttributes){
		redirectAttributes.addFlashAttribute("delRes",noticeService.remove(noticeNo));
		redirectAttributes.addFlashAttribute("type", "delete");
		return "redirect:/notice/result";
	}
	
}
