package com.nike.web.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.nike.web.service.CartService;
import com.nike.web.service.CartServiceImpl;
import com.nike.web.service.OrderService;
import com.nike.web.service.OrderServiceImpl;

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

}