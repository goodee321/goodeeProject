package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.OrderDTO;

@Mapper
public interface AdminOrderMapper {

    // 전체목록
    public List<OrderDTO> selectOrderList(Map<String, Object> map);

    // 검색주문수
    public int selectFindCount(Map<String, Object> map);

    // 검색목록
    public List<OrderDTO> selectFindList(Map<String, Object> map);

    // 전체주문수
    public int selectOrderCount();

    // 상세보기
    public OrderDTO selectOrderByNo(Long orderNo);

    // 수정
    public int updateOrder(OrderDTO order);

    // 삭제
    public int deleteOrderList(List<Long> list);

    // 개별삭제
    public int deleteOrder(Long orderNo);

    //  관리자 주문 취소
	public int cancelOrder(String impUid);

}
