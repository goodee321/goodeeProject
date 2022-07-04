package com.nike.web.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class MemberDTO {
	
	private Long memberNo;
	private String id;
	private String pw;
	private String name;
	private String postcode;
	private String email;
	private String address;
	private String addrDetail;
	private String extraAddress;
	private String phone;
	private Integer agreeState;
	private Date signIn;
	private Date pwModified;
	private Date infoModified;
	private String sessionId;
	private Date sessionLimit;
	
	
	
	
}
