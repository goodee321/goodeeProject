package com.nike.web.domain;


import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@JsonInclude
public class ProductQtyDTO {

	private Integer	proNo;				
	private Integer proSize;
	private Integer proQty;
	private Double	proDiscount;
}