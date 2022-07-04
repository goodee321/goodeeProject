package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.MemberDTO;

@Mapper
public interface AdminMemberMapper {

	
	// 목록(Admin)
	
		public List<MemberDTO> selectMemberList(Map<String, Object> map);
			
		// 전체회원수(Admin)
		public int selectMemberCount();
		
		public int selectFindCount(Map<String, Object> map);
		
		public List<MemberDTO> selectFindList(Map<String, Object> map);
		
		
		
		
		
		
			
		// 상세보기(Admin)
		public MemberDTO selectMemberByNo(Long memberNo);
			
		// 삭제(Admin)
		public int deleteMemberList(List<Long> list);
			
		// 수정(Admin)
		public int updateMember(MemberDTO member);
		
		// 개별삭제(Admin)
		public int deleteMember(Long memberNo);
		
}
