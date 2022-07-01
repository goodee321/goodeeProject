package com.nike.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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

    @GetMapping("/product/detail")
    public String detail(@RequestParam Integer proNo, HttpServletRequest request, Model model) {
        model.addAttribute("detail", productService.getProductByNo(proNo));
        productService.findDetailReviews(request, model);
        return "product/detail";
    }

    @ResponseBody
    @GetMapping("/product/display")
    public ResponseEntity<byte[]> display(@RequestParam(value = "proimgNo", required = true) Integer ProimgNo, @RequestParam(value = "type", required = false, defaultValue = "image") String type) {
        return productService.display(ProimgNo, type);
    }
}