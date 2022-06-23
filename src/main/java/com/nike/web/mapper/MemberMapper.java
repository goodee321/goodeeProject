package com.nike.web.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.SignOutMemberDTO;

@Mapper
public interface MemberMapper {
	public MemberDTO selectMemberById(String id);
	public MemberDTO selectMemberByEmail(String email);
	public int insertMember(MemberDTO member);
	public int deleteMember(Long memberNo);
	public MemberDTO selectMemberByIdPw(MemberDTO member);
	public int insertMemberLog(String id);
	public SignOutMemberDTO selectSignOutMemberById(String id);
	public int reInsertMember(MemberDTO member);
	public int deleteSignOutMember(String id);

	
}
