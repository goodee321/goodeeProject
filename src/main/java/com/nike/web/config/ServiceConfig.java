package com.nike.web.config;

import com.nike.web.service.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

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

	@Bean
	public ProductService productService() {
		return new ProductServiceImpl();
	}

	@Bean
	public MemberService memberService() {
		return new MemberServiceImpl();
	}

	@Bean
	public NoticeService noticeService() {
		return new NoticeServiceImpl();
	}

	@Bean
	public QnaService qnaService() {
		return new QnaServiceImpl();
	}

}