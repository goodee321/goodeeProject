package com.nike.web.controller;

import java.util.HashMap;
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

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nike.web.domain.ProductQtyDTO;
import com.nike.web.domain.ProductQtyDTO.ProductQtyDTOBuilder;
import com.nike.web.domain.ReviewDTO;
import com.nike.web.service.ProductService;


@Controller
public class ProductController {

	@Autowired
	private ProductService productService;

	
	@GetMapping("/product/list")
	public String list(HttpServletRequest request, Model model) {
		productService.findProducts(request, model);
		return "product/list";
	}
	
	@GetMapping("/product/find")
	public String find(HttpServletRequest request, Model model) {
		productService.getFindProducts(request, model);
		return "product/list";
	}
	
	@GetMapping("/product/saveProductPage")
	public String saveProductPage() {
		return "product/saveProduct";
	}
	
	@PostMapping("/product/saveProduct")
	public void saveProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model) {
		productService.save(multipartRequest, response, model);
	}
	
	@ResponseBody
	@GetMapping("/product/display")
	public ResponseEntity<byte[]> display(@RequestParam(value="proimgNo", required=true) Integer ProimgNo, @RequestParam(value="type", required=false, defaultValue="image") String type) {
		return productService.display(ProimgNo, type);		
	}


	@GetMapping("/product/saveProductOption")
	public String saveProductOption(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
		model.addAttribute("detail", productService.getProductByNo(proNo));
		return "product/saveProductOption";
		
	}


	@RequestMapping(value="/product/saveProductOptionOk", method= {RequestMethod.GET, RequestMethod.POST})
	public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response) {
		productService.saveProductOptionOk(request, response);
	}
	
	@GetMapping("/product/detail")
	public String detail(@RequestParam(required=false) Integer proNo, HttpServletRequest request, Model model) {
		model.addAttribute("detail", productService.getProductByNo(proNo));
		productService.findDetailReviews(request, model);
		Map<Integer, Object> ratingOptions = new HashMap();
		ratingOptions.put(1, "???????????????");
		ratingOptions.put(2, "???????????????");
		ratingOptions.put(3, "???????????????");
		ratingOptions.put(4, "???????????????");
		ratingOptions.put(5, "???????????????");
		model.addAttribute("ratingOptions", ratingOptions);
		return "product/detail";
		
	}
	
	// fnAjax1??? ???????????? ???
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ResponseBody
	@RequestMapping(value="/product/changeProductOptionDetail", method= {RequestMethod.GET, RequestMethod.POST})  
	public ProductQtyDTO changeProductOptionDetail(HttpServletRequest request) { 
	ProductQtyDTO productQty = productService.changeProductOptionDetail(request);
		return productQty;
	}
	
	
	
	// fnAjax1??? ???????????? ???
    @JsonInclude(JsonInclude.Include.NON_NULL)
    @ResponseBody
    @RequestMapping(value="/product/selectProductOptionDetail", method= {RequestMethod.GET, RequestMethod.POST})  
    public ProductQtyDTO selectProductOptionDetail(HttpServletRequest request) { 
       ProductQtyDTO productQty = productService.changeProductOptionDetail(request);
       return productQty;
    }
	
	
	
	@PostMapping("/product/detailReviewSave")
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		productService.addDetailReview(multipartRequest, response);
	}
	
	@GetMapping("/product/changeProductPage")
	public String changeProductPage(HttpServletRequest request, Model model) {
		productService.changeProductOptionPage(request, model);
		return "product/changeProduct";
	}
	
	
	@GetMapping("/product/removeProductImage")
	public String removeProductImage(@RequestParam Integer proNo, Integer proimgNo) {
		productService.removeProductImage(proimgNo);
		return "redirect:/product/detail?proNo=" + proNo;
	}
	
	@PostMapping("/product/changeProduct")
	public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		productService.changeProduct(multipartRequest, response);
	}
	//??????????????? ?????? ??? ???
	@GetMapping("/product/changeProductOptionPage")
	public String changeProductOptionPage(@RequestParam Integer proNo,HttpServletRequest request, Model model) {
		model.addAttribute("product", productService.getProductByNo(proNo));
		return "product/changeProductOption";
	}
	
	
	@GetMapping("/product/deleteReview")
	public void deleteReview(HttpServletRequest request, HttpServletResponse response) {
		productService.deleteReview(request, response);
	}
	
	@GetMapping("/product/detailReview")
	public String findDetailReview(HttpServletRequest request, Model model) {
		productService.findDetailReviewByNo(request, model);
		return "product/detailReview";
	}
	
	@GetMapping("/product/changeReviewPage")
	public String changePage(HttpServletRequest request, Model model) {
		productService.findDetailReviewByNo(request, model);
		return "product/reviewChange";
	}
	
	@PostMapping("/product/reviewChange")
	public void changeReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		productService.changeReview(multipartRequest, response);
	}
	
	@ResponseBody
	@GetMapping("/product/reviewDisplay")
	public ResponseEntity<byte[]> displayReview(@RequestParam(value="riNo", required=true) Integer riNo, @RequestParam(value="type", required=false, defaultValue="image") String type) {
		return productService.displayReview(riNo, type);		
	}
	
	@GetMapping("/product/removeFileAttach")
	public String removeFileAttach(@RequestParam Integer riNo, @RequestParam Integer reviewNo) {
		productService.removeFileAttach(riNo);
		return "redirect:/product/detailReview?reviewNo=" + reviewNo;
	}
	
	@PostMapping("/product/changeProductOption")
	public void changeProductOption(HttpServletRequest request, HttpServletResponse response) {
			productService.changeProductOption(request, response);
	}
	
	@GetMapping("product/productDelete")
	public void productDelete(HttpServletRequest request, HttpServletResponse response) {
			productService.productDelete(request,response);
		
	}
	
	
}
