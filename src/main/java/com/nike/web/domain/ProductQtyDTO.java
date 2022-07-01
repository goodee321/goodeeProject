package com.nike.web.domain;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data

public class ProductQtyDTO {

    private Integer proNo;
    private int proSize;
    private int proQty;
    private Double proDiscount;

}