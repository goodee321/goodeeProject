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
	
	
	
	
		
		
		
		
		
		
}
