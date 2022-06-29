package com.nike.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String detail(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
		model.addAttribute("detail", productService.getProductByNo(proNo));
		productService.findDetailReviews(request, model);
		return "product/detail";
		
	}
	

//	@GetMapping(value="product/detailReview")
//	public String detailReviewList(HttpServletRequest request, Model model) {
//		productService.findDetailReviews(request, model);
//		Integer proNo = Integer.parseInt(request.getParameter("proNo"));
//		return "product/detail?=" + proNo;
//	}
	
	@PostMapping("/product/detailReviewSave")
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		productService.addDetailReview(multipartRequest, response);
	}
	
	
	/*
	@GetMapping("/product/productChangePage")
	public String productChangePage(HttpServletRequest request, Model model) {
		productService.findProductByNo(request, model);
		return "gallery/change";
	}
	@PostMapping("/gallery/productChange")
	public void productChange(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		productService.change(multipartRequest, response);
	}
	*/
}