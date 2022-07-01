package com.nike.web.domain;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data

public class ProductDTO {

    private Integer proNo;
    private String proName;
    private int proPrice;
    private String proDetail;
    private Date proDate;


    private ProductImageDTO productImageDTO;
    private ProductQtyDTO productQtyDTO;
}