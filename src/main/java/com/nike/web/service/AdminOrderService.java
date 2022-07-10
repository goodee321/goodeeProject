package com.nike.web.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.nike.web.domain.OrderDTO;

public interface AdminOrderService {

    // 전체목록
    public void getOrders(HttpServletRequest request, Model model);

    // 검색목록
    public void findOrders(HttpServletRequest request, Model model);

    // 세부사항
    public OrderDTO findOrderByNo(HttpServletRequest request);

    // 수정
    public int change(HttpServletRequest request);

    // 삭제(선택해서삭제)
    public int removeList(HttpServletRequest request);

    // 개별삭제
    public int removeOne(HttpServletRequest request);

    public String getToken();

    public int adminCancel(HttpServletRequest request);

}