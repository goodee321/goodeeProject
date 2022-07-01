package com.nike.web.service;

import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.OrderItemDTO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


public interface OrderService {

    public String getToken();

    public int paymentInfo(String impUid, String token);

    public int orderComplete(String impUid, OrderDTO order, HttpServletRequest request);

    public void OrderCancel(String impUid, int amount, String reason);

    public List<OrderItemDTO> productInfo(List<OrderItemDTO> orders);

}