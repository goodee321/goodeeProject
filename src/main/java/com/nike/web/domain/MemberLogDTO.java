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
public class MemberLogDTO {

	private int mlMemberLogNo;
	private String mId;
	private Date mlSignUp;
}
