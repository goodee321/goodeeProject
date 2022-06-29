package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nike.web.domain.ProductDTO;

public interface ProductService {

	public void findProducts(HttpServletRequest request, Model model);
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model);
	public void getFindProducts(HttpServletRequest request, Model model);
	public ResponseEntity<byte[]> display(Integer proimgNo, String type);
	public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response);
	//수정
	public void change(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	
	// 상세페이지  
		public ProductDTO getProductByNo(Integer proNo);
		public void findDetailReviews(HttpServletRequest request, Model model);
		public void addDetailReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);

}
