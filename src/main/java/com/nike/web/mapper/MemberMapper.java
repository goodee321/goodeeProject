package com.nike.web.mapper;

<<<<<<< HEAD
import java.util.List;
import java.util.Map;

=======
>>>>>>> 42cbe105611f332659269d2db15c72e066893d3f
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

	
<<<<<<< HEAD
	
	
	// 목록(Admin)
	public List<MemberDTO> selectMemberList(Map<String, Object> map);
		
	// 전체회원수(Admin)
	public int selectMemberCount();
		
	// 상세보기(Admin)
	public MemberDTO selectMemberByNo(Long memberNo);
		
	// 삭제(Admin)
	public int deleteMemberList(List<Long> list);
		
	// 수정(Admin)
	public int updateMember(MemberDTO member);
	
	// 개별삭제(Admin)
	public int deleteMember2(Long memberNo);
	
=======
>>>>>>> 42cbe105611f332659269d2db15c72e066893d3f
}
