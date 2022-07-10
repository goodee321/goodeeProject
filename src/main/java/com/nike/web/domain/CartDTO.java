package com.nike.web.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CartDTO {

	//  Cart
	private int cartNo;
	private Long memberNo;
	private int productNo;
	private int cartQty;
	private Date cartRegdate;

	//	Product
	private String proName;
	private int productSize;
	private int proPrice;
	private double proDiscount;

	//	Product Image
	private int proimgNo;

	private int salePrice;
	private int totalPrice;

}