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

    private List<OrderItemDTO> orders;

    private int salePrice;

    private int totalPrice;

    public void initSaleTotal() {
        this.salePrice = (int) (this.proPrice * (1 - (this.proDiscount / 10)));
        this.totalPrice = this.salePrice * this.cartQty;
    }

    @Override
    public String toString() {
        return "OrderItemDTO [" +
                "cartNo=" + cartNo +
                ", productNo=" + productNo +
                ", cartQty=" + cartQty +
                ", proName='" + proName + '\'' +
                ", proPrice=" + proPrice +
                ", proDiscount=" + proDiscount +
                ", salePrice=" + salePrice +
                ", totalPrice=" + totalPrice +
                ']';
    }
}