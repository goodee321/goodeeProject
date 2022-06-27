package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class OrderDetailDTO {

	private int orderDetailNo;
	private int orderNo;
	private int productNo;
	private int orderQty;
	private int orderPrice;


}



