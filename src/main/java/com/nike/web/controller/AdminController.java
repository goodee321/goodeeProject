package com.nike.web.controller;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nike.web.domain.MemberDTO;
import com.nike.web.service.MemberService;
import com.nike.web.service.NoticeService;
import com.nike.web.service.OrderService;
import com.nike.web.service.ProductService;
import com.nike.web.service.QnaService;

@Controller
public class AdminController {

	
	
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NoticeService noticeService;
		
	@Autowired
	private ProductService productService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private QnaService qnaService;
	
	
//	
//	// 메인
//	@GetMapping("/admin/main")
//	public String mainPage() {
//		return "admin/main";
//	}
	
	
	
	// 회원목록
	@GetMapping("/admin/member/list")
	public String list(HttpServletRequest request, Model model) {
		memberService.getMembers(request, model);
		return "admin/member/list";	// search.jsp를 열면 list.jsp가 포함되어 있으므로 search.jsp로 간다.
	}
	
	
	//
	@GetMapping("/admin/member/searchPage")
	public String searchPage() {
		return "admin/member/list";
	}
	
	//
	@GetMapping("/admin/member/search")
	public String search(HttpServletRequest request, Model model) {
		memberService.findMembers(request, model);
		return "admin/member/list";	
	}
	
	
	// result 맵핑
	@GetMapping("/admin/member/afterDML")
	public String afterDML() {
		return "admin/member/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
	}
	
	
	// 회원선택삭제
	@GetMapping("/admin/member/removeList")
	public String removeList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "deleteList");
		redirectAttributes.addFlashAttribute("res", memberService.removeList2(request));
		return "redirect:/admin/member/afterDML";
	}
	
	
	// 회원개별삭제
	@GetMapping("/admin/member/removeOne")
	public String removeOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "deleteOne");
		redirectAttributes.addFlashAttribute("res", memberService.removeOne(request));
		return "redirect:/admin/member/afterDML";
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
	
	
	// 
	@PostMapping("/admin/member/change")
	public String change(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "update");
		redirectAttributes.addFlashAttribute("res", memberService.change(request));
		return "redirect:/admin/member/afterDML";
	}
	
	
	
	
	
	
				// 공지사항목록
				@GetMapping("/admin/notice/list")
				public String noticeList(HttpServletRequest request, Model model) {
					noticeService.getNotices2(request, model);
					return "admin/notice/list";
				}
				
				
				// 
				@GetMapping("/admin/notice/searchPage")
				public String noticeSearchPage() {
					return "admin/notice/list";
				}
				
				
				// 
				@GetMapping("/admin/notice/search")
				public String noticeSearch(HttpServletRequest request, Model model) {
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
				
				
				// 
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

				
	
		
	
	// 상품 목록
	@GetMapping("/admin/product/list")
	public String productList(HttpServletRequest request, Model model) {
		productService.findProducts2(request, model);
		return "/admin/product/list";
	}
	
	// 썸네일 보여주기
	@ResponseBody
	@GetMapping("/admin/product/display")
	public ResponseEntity<byte[]> display(@RequestParam(value="proimgNo", required=true) Integer ProimgNo, @RequestParam(value="type", required=false, defaultValue="image") String type) {
		return productService.display(ProimgNo, type);		
	}
	
	
	
	// 검색기능
	@GetMapping("/admin/product/find")
	public String find(HttpServletRequest request, Model model) {
		productService.getFindProducts2(request, model);
		return "/admin/product/list";
	}
	
	
	// 삽입
	@GetMapping("/admin/product/saveProductPage")
	public String saveProductPage() {
		return "/admin/product/saveProduct";
	}
	
	// 
	@PostMapping("/admin/product/saveProduct")
	public void saveProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) {
		productService.save2(multipartRequest, response, model);
	}
	
	
	// 상품선택삭제
	@GetMapping("/admin/product/removeList")
	public String ProductRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "deleteList");
		redirectAttributes.addFlashAttribute("res", productService.removeList(request));
		return "redirect:/admin/product/afterDML";
	}
	
	
	// result 맵핑
	@GetMapping("/admin/product/afterDML")
	public String productAfterDML() {
		return "admin/product/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
	}
	
	
	
	// 상품 상세보기
	@GetMapping("/admin/product/detail")
	public String productDetail(HttpServletRequest request, Model model) {
		model.addAttribute("product", productService.findProductByNo2(request));
		return "admin/product/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
	}
		
		
		
	// 제품 수정
	@GetMapping("/admin/product/changeProductPage")
	public String changeProductPage(HttpServletRequest request, Model model) {
		productService.changeProductOptionPage(request, model);
		return "admin/product/changeProduct";
	}
		
		
		
		// 
		@PostMapping("/admin/product/changeProduct")
		public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
			productService.changeProduct2(multipartRequest, response);
		}
		
		
		
		
		
		// 상품 옵션 수정
		@GetMapping("/admin/product/changeProductOptionPage")
		public String changeProductOptionPage(@RequestParam Integer proNo,HttpServletRequest request, Model model) {
			model.addAttribute("product", productService.getProductByNo(proNo));
			return "admin/product/changeProductOption";
		}
		
		
		// 
		@PostMapping("/admin/product/changeProductOption")
		public void changeProductOption(HttpServletRequest request, HttpServletResponse response) {
				productService.changeProductOption2(request, response);
		}
		
		
		
		// 상품삭제
		@GetMapping("/admin/product/productDelete")
		public void productDelete(HttpServletRequest request, HttpServletResponse response) {
				productService.productDelete2(request,response);
		}
		
		
		
		
		// 옵션추가
		@GetMapping("/admin/product/saveProductOption")
		public String saveProductOption(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
			model.addAttribute("product", productService.getProductByNo2(proNo));
			return "admin/product/saveProductOption";
			
		}

		// 
		@RequestMapping(value="/admin/product/saveProductOptionOk", method= {RequestMethod.GET, RequestMethod.POST})
		public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response) {
			productService.saveProductOptionOk2(request, response);
		}
		
		
		
		// [주문]
		// 주문목록
		@GetMapping("/admin/order/list")
		public String orderList(HttpServletRequest request, Model model) {
			orderService.getOrders2(request, model);
			return "admin/order/list";	// search.jsp를 열면 list.jsp가 포함되어 있으므로 search.jsp로 간다.
		}
		
		
		//
		@GetMapping("/admin/order/searchPage")
		public String orderSearchPage() {
			return "admin/order/list";
		}
		
		
		//
		@GetMapping("/admin/order/search")
		public String orderSearch(HttpServletRequest request, Model model) {
			orderService.findOrders2(request, model);
			return "admin/order/list";	
		}
		
		
		// 주문상세보기
		@GetMapping("/admin/order/detail")
		public String orderDetail(HttpServletRequest request, Model model) {
			model.addAttribute("order", orderService.findOrderByNo2(request));
			return "admin/order/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
		}
		
		
		// result 맵핑
		@GetMapping("/admin/order/afterDML")
		public String orderAfterDML() {
			return "admin/order/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
		}
		
		
		
		// 주문수정
		@GetMapping("/admin/order/changePage")
		public String orderChangePage(HttpServletRequest request, Model model) {
			model.addAttribute("order", orderService.findOrderByNo2(request));
			return "admin/order/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
		}
		
		
		// 
		@PostMapping("/admin/order/change")
		public String orderChange(HttpServletRequest request, RedirectAttributes redirectAttributes) {
			redirectAttributes.addFlashAttribute("kind", "update");
			redirectAttributes.addFlashAttribute("res", orderService.change2(request));
			return "redirect:/admin/order/afterDML";
		}
		
		
		
		// 주문선택삭제
		@GetMapping("/admin/order/removeList")
		public String orderRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
			redirectAttributes.addFlashAttribute("kind", "deleteList");
			redirectAttributes.addFlashAttribute("res", orderService.removeList2(request));
			return "redirect:/admin/order/afterDML";
		}
		
		
		// 주문개별삭제
		@GetMapping("/admin/order/removeOne")
		public String orderRemoveOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
			redirectAttributes.addFlashAttribute("kind", "deleteOne");
			redirectAttributes.addFlashAttribute("res", orderService.removeOne2(request));
			return "redirect:/admin/order/afterDML";
		}
		
		
		
		
		// [qna]
		@GetMapping("/admin/qna/list")
		public String qnaList(HttpServletRequest request, Model model) {
			qnaService.findQnas2(request, model);
			return "admin/qna/list"; 
		}
		
		
		// qna
		@GetMapping("/admin/qna/detail")
		public String qnaDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
			qnaService.findQnaByNo2(request, model);
			return "admin/qna/detail";
		}
		
		
		// qna
		@GetMapping("/admin/qna/changePage")
		public String qnaChangePage(HttpServletRequest request, Model model) {
			qnaService.findQnaByNo2(request, model);
			return "admin/qna/change";
		}
		
		
		// qna
		@PostMapping("/admin/qna/change")
		public void qnaChange(HttpServletRequest request, HttpServletResponse response) {
			qnaService.change2(request, response);
		}
		
		
		// qna
		@GetMapping("/admin/qna/remove")
		public void qnaRemove(HttpServletRequest request, HttpServletResponse response){
			int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
			int res = qnaService.removeQna2(qnaNo);
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(res > 0) {
					out.println("<script>");
					out.println("alert('게시글이 삭제되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/admin/qna/list'");
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
		
		
		
		//
		@GetMapping("/admin/qna/saveQna")
		public String saveQna2() {
			return "admin/qna/save";
		}
		
		
		//
		@PostMapping("/admin/qna/save")
		public void qnaSave(HttpServletRequest request, HttpServletResponse response) {
			int res = qnaService.saveQna2(request);
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(res > 0) {
					out.println("<script>");
					out.println("alert('게시글이 등록되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/admin/qna/list'");
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
		
		
		//
		@PostMapping("/admin/qna/saveReply")
		public void saveReply(HttpServletRequest request, HttpServletResponse response) {
			int res = qnaService.saveReply2(request);
			try {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				if(res > 0) {
					out.println("<script>");
					out.println("alert('답변이 등록되었습니다.')");
					out.println("location.href='" + request.getContextPath() + "/admin/qna/list'");
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
		
		
		
	
	
	
	
	
	
	
}