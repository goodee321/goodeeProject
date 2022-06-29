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
	private int reviewNo;
	private int orderNo;
	private int proNo;
	private int memberNo;
	private String reviewTitle;
	private String reviewContent;
	private Date reviewDate;
	private int reviewStar;
	
	private ReviewImageDTO ReviewImageMap;
}