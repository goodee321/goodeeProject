package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.NoticeDTO;

@Mapper
public interface AdminNoticeMapper {

	// 목록(Admin)
			public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
		
		
			// 상세보기(Admin)
			public NoticeDTO selectNoticeByNo(Long noticeNo);
			
			
			// 수정(Admin)
			public int updateNotice(NoticeDTO notice);
			
			
			// 개별삭제(Admin)
			public int deleteNotice(Integer noticeNo);
			
			
			// 삽입(Admin)
			public int insertNotice(NoticeDTO notice);
			
			
			// 선택삭제(Admin)
			public int deleteNoticeList(List<Long> list);
			
			
			
			public int selectNoticeCount();
			
			
			
			public int selectFindCount(Map<String, Object> map);
			
			public List<NoticeDTO> selectFindList(Map<String, Object> map);
	
	
}
