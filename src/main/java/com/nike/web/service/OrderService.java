package com.nike.web.service;

import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.OrderItemDTO;
import org.json.simple.parser.ParseException;
import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;


public interface OrderService {

    public String getToken();

    public int paymentInfo(String impUid, String token);

    public ResponseEntity<String> orderComplete(String impUid, OrderDTO order, HttpServletRequest request);

    public void OrderCancel(String impUid, int amount, String reason);

    public int adminCancel(HttpServletRequest request);

    public List<OrderItemDTO> productInfo(List<OrderItemDTO> orders);

}