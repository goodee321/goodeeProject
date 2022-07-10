package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nike.web.domain.ProductDTO;
import com.nike.web.domain.ProductQtyDTO;

public interface AdminProductService {
	
	
	

	// 전체목록(상품관리는 반대입니다.)
	public void findProducts(HttpServletRequest request, Model model);
	
	// 검색목록
	public void getFindProducts(HttpServletRequest request, Model model);
	
	// 삽입
	public void save(MultipartHttpServletRequest multipartRequest, HttpServletResponse response, Model model);
	
	
	// 삭제(선택해서삭제)
	public int removeList(HttpServletRequest request);
	
	
	// 상세보기
	public ProductDTO findProductByNo(HttpServletRequest request);
	
	
	
	// 상품변경
	public void changeProduct(MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
	
	
	// 삭제
	public void productDelete(HttpServletRequest request, HttpServletResponse response);
	
	
	// 개별삭제
	public int removeOne(HttpServletRequest request);
	
	
	// 제품상세보기
	public ProductDTO getProductByNo(Integer proNo);
	
	
	
	// 옵션추가
	public void saveProductOptionOk(HttpServletRequest request, HttpServletResponse response);
	
	
	// 썸네일
	public ResponseEntity<byte[]> display(Integer proimgNo, String type);
	
	
	
	// 상품옵션변경
	public void changeProductOptionPage(HttpServletRequest request, Model model);
	
	
	// 상품옵션변경
	public void changeProductOption(HttpServletRequest request, HttpServletResponse response);
	
	
	// 상품옵션변경시 사이즈 할인율 알려줌
	public ProductQtyDTO changeProductOptionDetail(HttpServletRequest request);
	
	
	public void removeProductImage(Integer proimgNo);
	
	
	
	

}
