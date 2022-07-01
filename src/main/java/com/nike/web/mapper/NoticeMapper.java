package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

<<<<<<< HEAD
import com.nike.web.domain.MemberDTO;
=======
>>>>>>> JeongHwaha
import com.nike.web.domain.NoticeDTO;
@Mapper
public interface NoticeMapper {

	public List<NoticeDTO> selectNoticeList(Map<String, Object> map);
	
<<<<<<< HEAD
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
		
		
=======
	public int selectFindCount(Map<String, Object> map);
	public List<NoticeDTO> selectFindList(Map<String, Object> map);
	
	public int selectNoticeCount();
	public NoticeDTO selectNoticeByNo(int noticeNo);
	public int updateHit(int noticeNo);
	
	public int insertNotice(NoticeDTO notice);
	public int updateNotice(NoticeDTO notice);
	public int deleteNotice(int noticeNo);
>>>>>>> JeongHwaha
}
