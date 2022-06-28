package com.nike.web.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nike.web.domain.MemberDTO;
import com.nike.web.service.MemberService;
import com.nike.web.service.NoticeService;
import com.nike.web.service.QnaService;

@Controller
public class AdminController {

	
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;
		
	@Autowired
	private QnaService qnaService;
	
	
	
	@GetMapping("/admin/main")
	public String mainPage() {
		return "admin/main";
	}
	
	
	// 
	@GetMapping("/admin/member/searchPage")
	public String searchPage() {
		return "admin/member/search";
	}
	
	
	// 회원목록
	@GetMapping("/admin/member/list")
	public String list(HttpServletRequest request, Model model) {
		memberService.getMembers(request, model);
		return "admin/member/search";	// search.jsp를 열면 list.jsp가 포함되어 있으므로 search.jsp로 간다.
	}
	
	@GetMapping("/admin/member/search")
	public String search(HttpServletRequest request, Model model) {
		memberService.findMembers(request, model);
		return "admin/member/search";	
	}
	
	@ResponseBody
	@GetMapping(value="/admin/member/autoComplete", produces="application/json")
	public Map<String, Object> autoComplete(HttpServletRequest request){
		return memberService.autoComplete(request);
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
	
	
	// result 맵핑
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
				
				
				// 공지사항수정
				@GetMapping("/admin/notice/changePage")
				public String noticeChangePage(HttpServletRequest request, Model model) {
					model.addAttribute("notice", noticeService.findNoticeByNo2(request));
					return "admin/notice/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
				}
				
				
				// 공지사항수정
				@PostMapping("/admin/notice/change")
				public String noticeChange(HttpServletRequest request, RedirectAttributes redirectAttributes) {
					redirectAttributes.addFlashAttribute("kind", "update");
					redirectAttributes.addFlashAttribute("res", noticeService.change2(request));
					return "redirect:/admin/notice/afterDML";
				}
				
			
				// result 맵핑
				@GetMapping("/admin/notice/afterDML")
				public String NoticeafterDML() {
					return "admin/notice/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
				}
			
			
				
				// 공지사항개별삭제
				@GetMapping("/admin/notice/removeOne")
				public String noticeRemoveOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
					redirectAttributes.addFlashAttribute("kind", "deleteOne");
					redirectAttributes.addFlashAttribute("res", noticeService.removeOne(request));
					return "redirect:/admin/notice/afterDML";
				}
				
				
				// 공지사항삽입
				@GetMapping("/admin/notice/savePage")
				public String noticeSavePage() {
					return "admin/notice/save";
				}
				
				// 공지사항삽입
				@PostMapping("/admin/notice/save")
				public String noticeSave(HttpServletRequest request, RedirectAttributes redirectAttributes) {
					redirectAttributes.addFlashAttribute("insRes", noticeService.save2(request));
					redirectAttributes.addFlashAttribute("type", "insert");
					return "redirect:/admin/notice/afterDML";  
				}
	
		
				// 공지사항선택삭제
				@GetMapping("/admin/notice/removeList")
				public String noticeRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
					redirectAttributes.addFlashAttribute("kind", "deleteList");
					redirectAttributes.addFlashAttribute("res", noticeService.removeList(request));
					return "redirect:/admin/notice/afterDML";
				}

				
	// qna 리스트
    @GetMapping("/admin/qna/list")
	public String qnaList(HttpServletRequest request, Model model) {
		qnaService.findQnas(request, model);
		return "/admin/qna/list"; 
	}
	
    @GetMapping("/admin/qna/saveQna")
	public String saveQna() {
		return "qna/save";
	}
	
	@PostMapping("/admin/qna/save")
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
	
	
	@GetMapping("/admin/qna/detail")
	public String detail(HttpServletRequest request, HttpServletResponse response, Model model) {
		qnaService.findQnaByNo(request, response, model);
		return "qna/detail";
	}
	
	@PostMapping("/admin/qna/saveReply")
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
	
	
	// 여기까지 qna
	@GetMapping("/admin/qna/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response){
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		int res = qnaService.remove(qnaNo);
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