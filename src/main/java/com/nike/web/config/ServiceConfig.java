package com.nike.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.nike.web.service.CartService;
import com.nike.web.service.CartServiceImpl;
import com.nike.web.service.NoticeService;
import com.nike.web.service.NoticeServiceImpl;
import com.nike.web.service.OrderService;
import com.nike.web.service.OrderServiceImpl;
<<<<<<< HEAD
import com.nike.web.service.ProductService;
import com.nike.web.service.ProductServiceImpl;
=======
import com.nike.web.service.QnaService;
import com.nike.web.service.QnaServiceImpl;
>>>>>>> JeongHwaha

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

	@Bean
	public ProductService productService() {
		return new ProductServiceImpl();
	}
=======
	
	@Bean
	public NoticeService noticeService() {
		return new NoticeServiceImpl();
	}
	
	@Bean
	public QnaService qnaService() {
		return new QnaServiceImpl();
	}
	
	
>>>>>>> JeongHwaha
}