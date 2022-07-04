package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder

public class OrderDTO {

    private int orderNo;
    private String orderId;
    private long memberNo;
    private Date orderDate;
    private String orderName;
    private String orderPhone;
    private String orderAddr;
    private String addrDetail;
<<<<<<< HEAD
    private String orderDetail;
=======
>>>>>>> main
    private int orderAmount;
    private String orderPayment;
    private int orderInvoice;
    private int orderDelivery;
    private String impUid;
    private int orderState;
<<<<<<< HEAD
    
=======

    //  Product
    private String proName;
    private int proPrice;

    //  Cart
    private int cartNo;
    private int cartQty;
    private int productNo;

    //  OrderDetail
    private int orderPrice;

    //  PRODUCT_QTY
    private int proSize;

    private int orderFinalSalePrice;

    private List<OrderItemDTO> orders;

    public void getOrderPriceInfo() {

        for(OrderItemDTO order : orders) {
            orderAmount += order.getTotalPrice();
        }

        if(orderAmount >= 30000) {
            orderDelivery = 0;
        } else {
            orderDelivery = 3000;
        }

        orderFinalSalePrice = orderAmount + orderDelivery;
    }
>>>>>>> main

}