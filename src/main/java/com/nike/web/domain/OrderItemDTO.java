package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderItemDTO {

    private int productNo;

    private int cartQty;

    private int cartNo;

    private String orderId;

    private int productSize;

    private int orderNo;

    private int orderQty;

    private int orderPrice;

    private String proName;

    private int proPrice;

    private double proDiscount;

    private int proimgNo;

    private List<OrderItemDTO> orders;

    private int salePrice;

    private int totalPrice;

    private int discountPrice;

    public void initSaleTotal() {
        this.discountPrice = (int) (this.proPrice * (this.proDiscount));
        this.salePrice = (int) (this.proPrice * (1 - (this.proDiscount)));
        this.totalPrice = this.salePrice * this.cartQty;
    }

    @Override
    public String toString() {
        return "OrderItemDTO{" +
                "productNo=" + productNo +
                ", cartQty=" + cartQty +
                ", cartNo=" + cartNo +
                ", orderId='" + orderId + '\'' +
                ", productSize=" + productSize +
                ", orderNo=" + orderNo +
                ", orderQty=" + orderQty +
                ", orderPrice=" + orderPrice +
                ", proName='" + proName + '\'' +
                ", proPrice=" + proPrice +
                ", proDiscount=" + proDiscount +
                ", proimgNo=" + proimgNo +
                ", orders=" + orders +
                ", salePrice=" + salePrice +
                ", totalPrice=" + totalPrice +
                ", discountPrice=" + discountPrice +
                '}';
    }
}