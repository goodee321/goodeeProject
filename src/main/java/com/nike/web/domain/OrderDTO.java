package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class OrderDTO {

    private int orderNo;
    private String orderId;
    private long memberNo;
    private String orderDate;
    private String orderName;
    private String orderPhone;
    private String orderAddr;
    private String addrDetail;
    private int orderAmount;
    private String orderPayment;
    private int orderInvoice;
    private int orderDelivery;
    private String impUid;
    private int orderState;
    private int orderPostcode;
    private String orderMessage;

    //  Product
    private String proName;
    private int proPrice;

    //  Cart
    private int cartNo;
    private int cartQty;
    private int productNo;

    //  OrderDetail
    private int orderPrice;
    private int orderQty;

    //  PRODUCT_QTY
    private int productSize;
    private double proDiscount;
    private int proimgNo;

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

    @Override
    public String toString() {
        return "OrderDTO{" +
                "orderNo=" + orderNo +
                ", orderId='" + orderId + '\'' +
                ", memberNo=" + memberNo +
                ", orderDate=" + orderDate +
                ", orderName='" + orderName + '\'' +
                ", orderPhone='" + orderPhone + '\'' +
                ", orderAddr='" + orderAddr + '\'' +
                ", addrDetail='" + addrDetail + '\'' +
                ", orderAmount=" + orderAmount +
                ", orderPayment='" + orderPayment + '\'' +
                ", orderInvoice=" + orderInvoice +
                ", orderDelivery=" + orderDelivery +
                ", impUid='" + impUid + '\'' +
                ", orderState=" + orderState +
                ", proName='" + proName + '\'' +
                ", proPrice=" + proPrice +
                ", cartNo=" + cartNo +
                ", cartQty=" + cartQty +
                ", productNo=" + productNo +
                ", orderPrice=" + orderPrice +
                ", orderQty=" + orderQty +
                ", productSize=" + productSize +
                ", proimgNo=" + proimgNo +
                ", orderFinalSalePrice=" + orderFinalSalePrice +
                ", orders=" + orders +
                '}';
    }
}