package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import com.nike.web.domain.OrderDTO;
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

	public int changeMember(MemberDTO member);

	public MemberDTO selectMemberByNo(Long memberNo);

	public int changeMemberPw(MemberDTO member);

	public MemberDTO findMemberId(String email);

	public MemberDTO findMemberPw(MemberDTO member);

	public List<MemberDTO> getMemberByNo(long memberNo);

}