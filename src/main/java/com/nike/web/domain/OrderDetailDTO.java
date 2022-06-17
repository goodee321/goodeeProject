package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDTO {

	private int odNo;
	private int oNo;
	private int pNo;
	private int oQty;
	private int oPrice;

}