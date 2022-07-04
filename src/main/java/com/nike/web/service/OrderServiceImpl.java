package com.nike.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.OrderDTO;

import com.nike.web.mapper.OrderMapper;
import com.nike.web.util.PageUtils;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	
	
	
	@Override
	public String getTokens() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int paymentInfo(String impUid, String token) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void paymentCancle(String token, String impUid, int orderAmount, String reason) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	
	
			

}