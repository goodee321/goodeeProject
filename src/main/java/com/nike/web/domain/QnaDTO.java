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
public class QnaDTO {
	private int qnaNo;
	private String id;
	private String qnaTitle;
	private String qnaContent;
	private Date qnaDate;
	private int qnaState;
	private int qnaDepth;
	private int qnaGroupNo;
	private int qnaGroupOrd;

}
