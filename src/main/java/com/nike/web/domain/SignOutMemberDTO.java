package com.nike.web.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignOutMemberDTO {
	private Long signOutNo;
	private Long memberNo;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String postcode;
	private String address;
	private String addrDetail;
	private String extraAddress;
	private String phone;
	private Integer agreeState;
	private Date signIn;
	private Date signOutDate;
}
