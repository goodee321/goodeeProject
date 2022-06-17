package com.nike.web.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDTO {

	private int oNo;
	private int mNo;
	private Date oDate;
	private String oName;
	private String oPhone;
	private String oAddress;
	private String oDetail;
	private int oAmount;
	private int oPayment;
	private int oInvoice;
	private int oDelivery;

}