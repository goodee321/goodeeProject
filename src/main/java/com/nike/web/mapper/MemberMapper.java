package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

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

	
	
	
	// 목록(협업)
	public List<MemberDTO> selectMemberList(Map<String, Object> map);
		
	// 전체회원수
	public int selectMemberCount();
		
		
	// 상세보기
	public MemberDTO selectMemberByNo(Long memberNo);
		
		
	// 삭제(선택해서)
	public int deleteMemberList(List<Long> list);
		
		
	// 수정
	public int updateMember(MemberDTO member);
	
	// 개별삭제
	public int deleteMember2(Long memberNo);
	
}
