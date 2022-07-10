package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.QnaDTO;

@Mapper
public interface AdminQnaMapper {

	
		// 전체qna갯수
		public int selectQnaCount();
		
		// 전체목록
		public List<QnaDTO> selectQnaList(Map<String, Object> map);
		
		// 상세보기
		public QnaDTO selectQnaByNo(int qnaNo);
		
		// 수정
		public int updateQna(QnaDTO qna);
		
		// 삭제
		public int deleteQna(int qnaNo);
		
		
		// 삽입
		public int insertQna(QnaDTO qna);
		
		
		// 댓글삽입
		public int insertReply(QnaDTO qna);
		
		
		
		public int updatePreviousReply(QnaDTO qna);
	
	
}
