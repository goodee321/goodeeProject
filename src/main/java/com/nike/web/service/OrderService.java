package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.OrderDTO;

public interface OrderService {

    public String getTokens();

    public int paymentInfo(String impUid, String token);

    public void paymentCancle(String token, String impUid, int orderAmount, String reason);
    
    
    
   
 	
 	
 	

}