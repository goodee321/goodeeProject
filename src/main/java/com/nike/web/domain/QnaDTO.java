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
	private int qNo;
	private int mNo;
	private String qTitle;
	private String qContent;
	private Date qDate;
	private int qState;
	private int qDepth;
	private int qGroupNo;
	private int qGroupOrd;

}
