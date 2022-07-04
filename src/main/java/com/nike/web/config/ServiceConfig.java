package com.nike.web.config;

import com.nike.web.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

<<<<<<< HEAD
import com.nike.web.service.AdminMemberService;
import com.nike.web.service.AdminMemberServiceImpl;
import com.nike.web.service.AdminNoticeService;
import com.nike.web.service.AdminNoticeServiceImpl;
import com.nike.web.service.AdminOrderService;
import com.nike.web.service.AdminOrderServiceImpl;
import com.nike.web.service.AdminProductService;
import com.nike.web.service.AdminProductServiceImpl;
import com.nike.web.service.AdminQnaService;
import com.nike.web.service.AdminQnaServiceImpl;
import com.nike.web.service.CartService;
import com.nike.web.service.CartServiceImpl;
import com.nike.web.service.MemberService;
import com.nike.web.service.MemberServiceImpl;
import com.nike.web.service.NoticeService;
import com.nike.web.service.NoticeServiceImpl;
import com.nike.web.service.OrderService;
import com.nike.web.service.OrderServiceImpl;
import com.nike.web.service.ProductService;
import com.nike.web.service.ProductServiceImpl;
import com.nike.web.service.QnaService;
import com.nike.web.service.QnaServiceImpl;

=======
>>>>>>> main
@Configuration
public class ServiceConfig {

	@Bean
	public OrderService orderService() {
		return new OrderServiceImpl();
	}

	@Bean
	public CartService cartService() {
		return new CartServiceImpl();
	}

<<<<<<< HEAD
	
=======
	@Bean
	public ProductService productService() {
		return new ProductServiceImpl();
	}

>>>>>>> main
	@Bean
	public MemberService memberService() {
		return new MemberServiceImpl();
	}
<<<<<<< HEAD
	
	
=======

>>>>>>> main
	@Bean
	public NoticeService noticeService() {
		return new NoticeServiceImpl();
	}
<<<<<<< HEAD
	
	public ProductService productService() {
		return new ProductServiceImpl();
	}
	
	
=======

>>>>>>> main
	@Bean
	public QnaService qnaService() {
		return new QnaServiceImpl();
	}
	
	
<<<<<<< HEAD
	
	
	
=======
>>>>>>> main
	@Bean
	public AdminMemberService adminMemberService() {
		return new AdminMemberServiceImpl();
	}
	
	
	@Bean
	public AdminNoticeService adminNoticeService() {
		return new AdminNoticeServiceImpl();
	}
	
	
	@Bean
	public AdminProductService adminProductService() {
		return new AdminProductServiceImpl();
	}
	
	
	@Bean
	public AdminOrderService adminOrderService() {
		return new AdminOrderServiceImpl();
	}
	
	
	@Bean
	public AdminQnaService adminQnaService() {
		return new AdminQnaServiceImpl();
	}
	
	
	
<<<<<<< HEAD
	
	
=======

>>>>>>> main
}