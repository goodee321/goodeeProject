package com.nike.web.service;

public interface OrderService {

    public String getTokens();

    public int paymentInfo(String impUid, String token);

    public void paymentCancle(String token, String impUid, int orderAmount, String reason);

}