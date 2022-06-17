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
public class ReviewDTO {
	private int rNo;
	private int oNo;
	private int pNo;
	private int mNo;
	private String rTitle;
	private String rContent;
	private Date rDate;
	private int rStar;
}
