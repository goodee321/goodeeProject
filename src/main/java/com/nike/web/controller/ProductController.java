package com.nike.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}
