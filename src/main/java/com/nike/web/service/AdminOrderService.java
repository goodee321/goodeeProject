package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.OrderDTO;

public interface AdminOrderService {

	
	
	
	// admin
    
    
    // 목록(Admin)
 	public void getOrders(HttpServletRequest request, Model model);
    
    
    // 
 	public void findOrders(HttpServletRequest request, Model model);
 	
 	
 	
 	// 세부사항(Admin)
 	public OrderDTO findOrderByNo(HttpServletRequest request);
 	
 	
 	// 수정(Admin)
 	public int change(HttpServletRequest request);
 		
 	
 	// 삭제(선택해서삭제, Admin)
 	public int removeList(HttpServletRequest request);
 	
 	// 개별삭제(Admin)
 	public int removeOne(HttpServletRequest request);
 	
 	
 	
 	
}
