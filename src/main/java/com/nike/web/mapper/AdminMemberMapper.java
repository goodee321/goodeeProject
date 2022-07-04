package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.MemberDTO;

@Mapper
public interface AdminMemberMapper {

	
		// 전체목록
		public List<MemberDTO> selectMemberList(Map<String, Object> map);
			
		// 전체회원수
		public int selectMemberCount();
		
		// 검색회원수
		public int selectFindCount(Map<String, Object> map);
		
		// 검색목록
		public List<MemberDTO> selectFindList(Map<String, Object> map);
		
		// 상세보기
		public MemberDTO selectMemberByNo(Long memberNo);
			
		// 삭제
		public int deleteMemberList(List<Long> list);
			
		// 수정
		public int updateMember(MemberDTO member);
		
		// 개별삭제
		public int deleteMember(Long memberNo);
		
}
