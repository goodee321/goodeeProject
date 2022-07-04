package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder

public class OrderDTO {

    private int orderNo;
    private int memberNo;
    private Date orderDate;
    private String orderName;
    private String orderPhone;
    private String orderAddr;
    private String addrDetail;
    private String orderDetail;
    private int orderAmount;
    private String orderPayment;
    private int orderInvoice;
    private int orderDelivery;
    private String impUid;
    private int orderState;
    

}