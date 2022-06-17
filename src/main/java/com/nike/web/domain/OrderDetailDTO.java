package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data

public class OrderDetailDTO {
	private int odNo;
	private int oNo;
	private int pNo;
	private int oQty;
	private int oPrice;
}
