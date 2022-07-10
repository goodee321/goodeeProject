package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.NoticeDTO;

@Mapper
public interface AdminNoticeMapper {

			// 전체목록
			public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
		
		
			// 상세보기
			public NoticeDTO selectNoticeByNo(Long noticeNo);
			
			
			// 수정
			public int updateNotice(NoticeDTO notice);
			
			
			// 개별삭제
			public int deleteNotice(Integer noticeNo);
			
			
			// 삽입
			public int insertNotice(NoticeDTO notice);
			
			
			// 선택삭제
			public int deleteNoticeList(List<Long> list);
			
			
			// 전체갯수
			public int selectNoticeCount();
			
			
			// 검색갯수
			public int selectFindCount(Map<String, Object> map);
			
			
			// 검색목록
			public List<NoticeDTO> selectFindList(Map<String, Object> map);
	
	
}
