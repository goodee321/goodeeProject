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

	private int	pNo;				//ProductNo   상품 번호	==galleryNo
	private String	pName;			//productName 상품 이름 
	private int pPrice;				
	private int pStock;
	private String	pDetail;
	private String	pDelivery;
	private Date pDate;
	private int	pSize;
	private double	pDiscount;
}
