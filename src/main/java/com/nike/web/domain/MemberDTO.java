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
public class MemberDTO {
	private Long memberNo;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String address;
	private String addrDetail;
	private String phone;
	private Integer agreeState;
	private Date signIn;
	private Date pwModified;
	private Date infoModified;
	private String sessionId;
	private Date sessionLimit;
	
	// 검색필터
	private String type;	// 검색 타입
	private String keyword;	// 검색 내용
	
	
}
