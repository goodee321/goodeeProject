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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.ProductQtyDTO;
import com.nike.web.service.AdminMemberService;
import com.nike.web.service.AdminNoticeService;
import com.nike.web.service.AdminOrderService;
import com.nike.web.service.AdminProductService;
import com.nike.web.service.AdminQnaService;
import com.nike.web.service.MemberService;
import com.nike.web.service.NoticeService;
import com.nike.web.service.OrderService;
import com.nike.web.service.ProductService;
import com.nike.web.service.QnaService;

@Controller
public class AdminController {

    @Autowired
    private AdminMemberService adminMemberService;

    @Autowired
    private AdminNoticeService adminNoticeService;

    @Autowired
    private AdminProductService adminProductService;

    @Autowired
    private AdminOrderService adminOrderService;

    @Autowired
    private AdminQnaService adminQnaService;

    // 회원목록
    @GetMapping("/admin/member/list")
    public String list(HttpServletRequest request, Model model) {
        adminMemberService.getMembers(request, model);
        return "admin/member/list";
    }

    // 회원검색
    @GetMapping("/admin/member/search")
    public String search(HttpServletRequest request, Model model) {
        adminMemberService.findMembers(request, model);
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
        redirectAttributes.addFlashAttribute("res", adminMemberService.removeList(request));
        return "redirect:/admin/member/afterDML";
    }

    // 회원개별삭제
    @GetMapping("/admin/member/removeOne")
    public String removeOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteOne");
        redirectAttributes.addFlashAttribute("res", adminMemberService.removeOne(request));
        return "redirect:/admin/member/afterDML";
    }

    // 회원상세보기
    @GetMapping("/admin/member/detail")
    public String detail(HttpServletRequest request, Model model) {
        model.addAttribute("member", adminMemberService.findMemberByNo(request));
        return "admin/member/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
    }

    // 회원수정
    @GetMapping("/admin/member/changePage")
    public String changePage(HttpServletRequest request, Model model) {
        model.addAttribute("member", adminMemberService.findMemberByNo(request));
        return "admin/member/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
    }

    // 회원수정
    @PostMapping("/admin/member/change")
    public String change(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "update");
        redirectAttributes.addFlashAttribute("res", adminMemberService.change(request));
        return "redirect:/admin/member/afterDML";
    }

    // 공지사항목록
    @GetMapping("/admin/notice/list")
    public String noticeList(HttpServletRequest request, Model model) {
        adminNoticeService.getNotices(request, model);
        return "admin/notice/list";
    }

    // 공지사항검색
    @GetMapping("/admin/notice/search")
    public String noticeSearch(HttpServletRequest request, Model model) {
        adminNoticeService.findNotices(request, model);
        return "admin/notice/list";
    }

    // 공지상세보기
    @GetMapping("/admin/notice/detail")
    public String noticeDetail(HttpServletRequest request, Model model) {
        model.addAttribute("notice", adminNoticeService.findNoticeByNo(request));
        return "admin/notice/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
    }

    // 공지사항수정
    @GetMapping("/admin/notice/changePage")
    public String noticeChangePage(HttpServletRequest request, Model model) {
        model.addAttribute("notice", adminNoticeService.findNoticeByNo(request));
        return "admin/notice/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
    }

    // 공지사항수정
    @PostMapping("/admin/notice/change")
    public String noticeChange(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("kind", "update");
		redirectAttributes.addFlashAttribute("res", adminNoticeService.change(request));
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
        redirectAttributes.addFlashAttribute("res", adminNoticeService.removeOne(request));
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
        redirectAttributes.addFlashAttribute("insRes", adminNoticeService.save(request));
        redirectAttributes.addFlashAttribute("type", "insert");
        return "redirect:/admin/notice/afterDML";
    }

    // 공지사항선택삭제
    @GetMapping("/admin/notice/removeList")
    public String noticeRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteList");
        redirectAttributes.addFlashAttribute("res", adminNoticeService.removeList(request));
        return "redirect:/admin/notice/afterDML";
    }

    // 상품목록
    @GetMapping("/admin/product/list")
    public String productList(HttpServletRequest request, Model model) {
        adminProductService.findProducts(request, model);
        return "/admin/product/list";
    }

    // 상품썸네일
    @ResponseBody
    @GetMapping("/admin/product/display")
    public ResponseEntity<byte[]> display(@RequestParam(value = "proimgNo", required = true) Integer ProimgNo, @RequestParam(value = "type", required = false, defaultValue = "image") String type) {
        return adminProductService.display(ProimgNo, type);
    }

    // 상품검색
    @GetMapping("/admin/product/find")
    public String find(HttpServletRequest request, Model model) {
        adminProductService.getFindProducts(request, model);
        return "/admin/product/list";
    }

    // 상품삽입
    @GetMapping("/admin/product/saveProductPage")
    public String saveProductPage() {
        return "/admin/product/saveProduct";
    }

    // 상품삽입
    @PostMapping("/admin/product/saveProduct")
    public void saveProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) {
        adminProductService.save(multipartRequest, response, model);
    }

    // 상품선택삭제
    @GetMapping("/admin/product/removeList")
    public String ProductRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteList");
        redirectAttributes.addFlashAttribute("res", adminProductService.removeList(request));
        return "redirect:/admin/product/afterDML";
    }

    // result 맵핑
    @GetMapping("/admin/product/afterDML")
    public String productAfterDML() {
        return "admin/product/result";   // admin 폴더 아래 member 폴더 아래 result.jsp로 이동
    }

    // 상품상세보기
    @GetMapping("/admin/product/detail")
    public String productDetail(HttpServletRequest request, Model model) {
        model.addAttribute("product", adminProductService.findProductByNo(request));
        return "admin/product/detail";  // admin 폴더 아래 member 폴더 아래 detail.jsp로 이동
    }

    // 상품수정
    @GetMapping("/admin/product/changeProductPage")
    public String changeProductPage(HttpServletRequest request, Model model) {
        adminProductService.changeProductOptionPage(request, model);
        return "admin/product/changeProduct";
    }

    // 상품수정
    @PostMapping("/admin/product/changeProduct")
    public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
        adminProductService.changeProduct(multipartRequest, response);
    }

    // 상품옵션 수정
    @GetMapping("/admin/product/changeProductOptionPage")
    public String changeProductOptionPage(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
        model.addAttribute("product", adminProductService.getProductByNo(proNo));
        return "admin/product/changeProductOption";
    }

    // 상품옵션 수정
    @PostMapping("/admin/product/changeProductOption")
    public void changeProductOption(HttpServletRequest request, HttpServletResponse response) {
        adminProductService.changeProductOption(request, response);
    }

    // 상품삭제
    @GetMapping("/admin/product/productDelete")
    public void productDelete(HttpServletRequest request, HttpServletResponse response) {
        adminProductService.productDelete(request, response);
    }
    
    
    // 상품개별삭제
    @GetMapping("/admin/product/removeOne")
    public String productRemoveOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteOne");
        redirectAttributes.addFlashAttribute("res", adminProductService.removeOne(request));
        return "redirect:/admin/product/afterDML";
    }
    

    // 상품옵션추가
    @GetMapping("/admin/product/saveProductOption")
    public String saveProductOption(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
        model.addAttribute("product", adminProductService.getProductByNo(proNo));
        return "admin/product/saveProductOption";
    }

    // 상품옵션추가
    @RequestMapping(value = "/admin/product/saveProductOptionOk", method = {RequestMethod.GET, RequestMethod.POST})
    public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response) {
        adminProductService.saveProductOptionOk(request, response);
    }
    
    // 상품이미지제거
    @GetMapping("/admin/product/removeProductImage")
	public String removeProductImage(@RequestParam Integer proNo, Integer proimgNo) {
		adminProductService.removeProductImage(proimgNo);
		return "redirect:/admin/product/detail?proNo=" + proNo;
	}
    
    
    
    // fnAjax1이 요청하는 곳
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ResponseBody
    @RequestMapping(value="/admin/product/selectProductOptionDetail", method= {RequestMethod.GET, RequestMethod.POST})  
    public ProductQtyDTO selectProductOptionDetail(HttpServletRequest request) {
       ProductQtyDTO productQty = adminProductService.changeProductOptionDetail(request);
       return productQty;
    }
    
    
    
    

    // 주문목록
    @GetMapping("/admin/order/list")
    public String orderList(HttpServletRequest request, Model model) {
        adminOrderService.getOrders(request, model);
        return "admin/order/list";    // search.jsp를 열면 list.jsp가 포함되어 있으므로 search.jsp로 간다.
    }

    // 주문검색
    @GetMapping("/admin/order/search")
    public String orderSearch(HttpServletRequest request, Model model) {
        adminOrderService.findOrders(request, model);
        return "admin/order/list";
    }

    // 주문상세보기
    @GetMapping("/admin/order/detail")
    public String orderDetail(HttpServletRequest request, Model model) {
        model.addAttribute("order", adminOrderService.findOrderByNo(request));
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
        model.addAttribute("order", adminOrderService.findOrderByNo(request));
        return "admin/order/change";  // admin 폴더 아래 member 폴더 아래 change.jsp로 이동
    }

    // 주문수정
    @PostMapping("/admin/order/change")
    public String orderChange(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "update");
        redirectAttributes.addFlashAttribute("res", adminOrderService.change(request));
        return "redirect:/admin/order/afterDML";
    }

    // 주문선택삭제
    @GetMapping("/admin/order/removeList")
    public String orderRemoveList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteList");
        redirectAttributes.addFlashAttribute("res", adminOrderService.removeList(request));
        return "redirect:/admin/order/afterDML";
    }

    // 주문개별삭제
    @GetMapping("/admin/order/removeOne")
    public String orderRemoveOne(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("kind", "deleteOne");
        redirectAttributes.addFlashAttribute("res", adminOrderService.removeOne(request));
        return "redirect:/admin/order/afterDML";
    }

    // qna목록
    @GetMapping("/admin/qna/list")
    public String qnaList(HttpServletRequest request, Model model) {
        adminQnaService.findQnas(request, model);
        return "admin/qna/list";
    }

    // qna상세보기
    @GetMapping("/admin/qna/detail")
    public String qnaDetail(HttpServletRequest request, HttpServletResponse response, Model model) {
        adminQnaService.findQnaByNo(request, model);
        return "admin/qna/detail";
    }

    // qna수정
    @GetMapping("/admin/qna/changePage")
    public String qnaChangePage(HttpServletRequest request, Model model) {
        adminQnaService.findQnaByNo(request, model);
        return "admin/qna/change";
    }

    // qna수정
    @PostMapping("/admin/qna/change")
    public void qnaChange(HttpServletRequest request, HttpServletResponse response) {
        adminQnaService.change(request, response);
    }

    // qna삭제
    @GetMapping("/admin/qna/remove")
    public void qnaRemove(HttpServletRequest request, HttpServletResponse response) {
        int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
        int res = adminQnaService.removeQna(qnaNo);
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res > 0) {
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

    // qna삽입
    @GetMapping("/admin/qna/saveQna")
    public String saveQna() {
        return "admin/qna/save";
    }

    // qna삽입
    @PostMapping("/admin/qna/save")
    public void qnaSave(HttpServletRequest request, HttpServletResponse response) {
        int res = adminQnaService.saveQna(request);
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res > 0) {
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

    // 댓글삽입
    @PostMapping("/admin/qna/saveReply")
    public void saveReply(HttpServletRequest request, HttpServletResponse response) {
        int res = adminQnaService.saveReply(request);
        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res > 0) {
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

    //  관리자 주문 취소
	@PostMapping("/admin/order/cancelOrder")
	public String orderCancel(HttpServletRequest request) {
		adminOrderService.adminCancel(request);
        return "redirect:/admin/order/list";
	}

}