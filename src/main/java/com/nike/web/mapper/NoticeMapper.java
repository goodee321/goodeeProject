package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.NoticeDTO;
@Mapper
public interface NoticeMapper {

	public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
	
	public int selectNoticeCount();
	public NoticeDTO selectNoticeByNo(int noticeNo);
	public int updateHit(int noticeNo);
	public int insertNotice(NoticeDTO notice);
	public int updateNotice(NoticeDTO notice);
	public int deleteNotice(int noticeNo);
	
	
		// 목록(Admin)
		public List<NoticeDTO> selectNoticeList2(Map<String, Object> map);
	
	
		// 상세보기(Admin)
		public NoticeDTO selectNoticeByNo2(Long noticeNo);
		
		
		// 수정(Admin)
		public int updateNotice2(NoticeDTO notice);
		
		
		// 개별삭제(Admin)
		public int deleteNotice2(Integer noticeNo);
		
		
		// 삽입(Admin)
		public int insertNotice2(NoticeDTO notice);
		
		
		// 삭제(Admin)
		public int deleteNoticeList(List<Long> list);
		
		
		
		
		
}
