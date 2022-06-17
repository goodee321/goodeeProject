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
public class NoticeDTO {

	private int nNo;
	private String nTitle;
	private String nContent;
	private Date nDate;
	private int nHit;
}
