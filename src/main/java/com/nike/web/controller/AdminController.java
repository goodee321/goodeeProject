package com.nike.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nike.web.service.MemberService;
import com.nike.web.service.NoticeService;

@Controller
public class AdminController {

	
	
	
	@Autowired
	private MemberService memberService;
	
		@Autowired
		private NoticeService noticeService;
	
	
	
	@GetMapping("/admin/main")
	public String mainPage() {
		return "admin/main";
	}
	
	
	// 회원관리
	@GetMapping("/admin/member/list")
	public String list(HttpServletRequest request, Model model) {
		memberService.findMembers(request, model);
		return "admin/member/list";
	}
	
	
	// 회원개별삭제
	@GetMapping("/admin/member/removeOne")
	public String removeOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "deleteOne");
		redirectAttributes.addFlashAttribute("res", memberService.removeOne(request));
		return "redirect:/admin/member/afterDML";
	}
	
	
	// 회원선택삭제
	@GetMapping("/admin/member/removeList")
	public String removeList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "deleteList");
		redirectAttributes.addFlashAttribute("res", memberService.removeList2(request));
		return "redirect:/admin/member/afterDML";
	}
	
	
	// 
	@GetMapping("/admin/member/afterDML")
	public String afterDML() {
		return "admin/member/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
	}
	
	// 회원상세보기
	@GetMapping("/admin/member/detail")
	public String detail(HttpServletRequest request, Model model) {
		model.addAttribute("member", memberService.findMemberByNo(request));
		return "admin/member/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
	}
	
	// 회원수정
	@GetMapping("/admin/member/changePage")
	public String changePage(HttpServletRequest request, Model model) {
		model.addAttribute("member", memberService.findMemberByNo(request));
		return "admin/member/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
	}
	
	
	// 여기까지 회원관리
	@PostMapping("/admin/member/change")
	public String change(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "update");
		redirectAttributes.addFlashAttribute("res", memberService.change(request));
		return "redirect:/admin/member/afterDML";
	}
	
	
	
		// 공지사항관리
		@GetMapping("/admin/notice/list")
		public String noticeList(HttpServletRequest request, Model model) {
			noticeService.findNotices2(request, model);
			return "admin/notice/list";
		}
		
		
		// 공지상세보기
		@GetMapping("/admin/notice/detail")
		public String noticeDetail(HttpServletRequest request, Model model) {
			model.addAttribute("notice", noticeService.findNoticeByNo2(request));
			return "admin/notice/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
		}
		
		
		
		
	
	
	
	
	

	
	
	
	
}
