package com.nike.web.domain;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data

public class ReviewImageDTO {
	private int riNo;
	private String riName;
	private String riPath;
	private String riOrigin;
	private int reviewNo;
}
