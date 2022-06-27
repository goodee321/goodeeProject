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

	private Integer	proNo;				//ProductNo   상품 번호	==galleryNo
	private String	proName;			//productName 상품 이름 
	private int proPrice;				
	private int proStock;
	private String	proDetail;
	private Date proDate;
	private int	proSize;
	private Double	proDiscount;
	
	
	private ProductImageDTO productImageDTO;
}