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
public class MemberDTO {
	private int mNo;
	private String mId;
	private String mPw;
	private String mName;
	private String mEmail;
	private String mAddress;
	private String mAddDetail;
	private String mPhone;
	private Date mDate;
	private Date pwModified;
	private Date infoModified;
	private String sessionId;
	private Date sessionLimit;
	private int power;
	
	
}
