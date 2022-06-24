package com.nike.web.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

<<<<<<< HEAD
@Data
@NoArgsConstructor
=======

>>>>>>> 42cbe105611f332659269d2db15c72e066893d3f
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class OrderDetailDTO {

<<<<<<< HEAD

	private int odNo;
	private int oNo;
	private int pNo;
	private int oQty;
	private int oPrice;

}




=======
	private int orderDetailNo;
	private int orderNo;
	private int productNo;
	private int orderQty;
	private int orderPrice;

}
>>>>>>> 42cbe105611f332659269d2db15c72e066893d3f
