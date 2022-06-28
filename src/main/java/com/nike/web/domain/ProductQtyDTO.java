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

	private Integer	proNo;				//ProductNo   상품 번호	==galleryNo
	private int proSize240;
	private int proSize250;
	private int proSize260;
	private int proSize270;
}