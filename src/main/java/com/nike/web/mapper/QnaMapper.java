package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.QnaDTO;

@Mapper
public interface QnaMapper {

	public int selectQnaCount();
	public List<QnaDTO> selectQnaList(Map<String, Object> map);
	
	public QnaDTO selectQnaByNo(int qnaNo);
	public int insertQna(QnaDTO qna);
	
	public int updatePreviousReply(QnaDTO qna);
	public int insertReply(QnaDTO qna);
	
	public int updateQna(QnaDTO qna);
	
	public int deleteQna(int qnaNo);
	
	
	
	
	
	
	
	
	
	
	
}
