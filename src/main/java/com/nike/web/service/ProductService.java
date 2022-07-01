package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductQtyDTO;

public interface ProductService {

		public void findProducts(HttpServletRequest request, Model model);
		public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model);
		public void getFindProducts(HttpServletRequest request, Model model);
		public ResponseEntity<byte[]> display(Integer proimgNo, String type);
		public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response);
		//수정
		public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
		public ProductQtyDTO changeProductOptionDetail(HttpServletRequest request);
		public void changeProductOption(HttpServletRequest request, HttpServletResponse response);
		public void removeProductImage(Integer proimgNo);
		// 상세페이지  
		public void changeProductOptionPage(HttpServletRequest request, Model model);
		public ProductDTO getProductByNo(Integer proNo );
		public void findDetailReviews(HttpServletRequest request, Model model);
		public void addDetailReview(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);

		//삭제
		public void productDelete(HttpServletRequest request, HttpServletResponse response);
		
}
