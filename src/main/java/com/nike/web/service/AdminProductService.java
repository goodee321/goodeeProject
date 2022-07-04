package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nike.web.domain.ProductDTO;

public interface AdminProductService {
	
	
	

	// [Admin] 얘가목록
	public void findProducts(HttpServletRequest request, Model model);
	
	//
	public void getFindProducts(HttpServletRequest request, Model model);
	
	// [Admin]
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model);
	
	
	// 삭제(선택해서삭제, Admin)
	public int removeList(HttpServletRequest request);
	
	
	// 세부사항(Admin)
	public ProductDTO findProductByNo(HttpServletRequest request);
	
	
	
	// (Admin)
	public void changeProductOption(HttpServletRequest request, HttpServletResponse response);
	
	
	
	//(Admin)
	public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	
	
	//(Admin)
	public void productDelete(HttpServletRequest request, HttpServletResponse response);
	
	
	
	//(Admin)
	public ProductDTO getProductByNo(Integer proNo);
	
	
	

	//(Admin)
	public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response);
	
	
	
	public ResponseEntity<byte[]> display(Integer proimgNo, String type);
	
	
	
	public void changeProductOptionPage(HttpServletRequest request, Model model);
	
	

}
