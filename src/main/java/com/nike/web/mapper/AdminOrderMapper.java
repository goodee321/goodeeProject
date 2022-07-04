package com.nike.web.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.OrderDTO;

@Mapper
public interface AdminOrderMapper {
	
	
	// 목록(Admin)
	
			public List<OrderDTO> selectOrderList(Map<String, Object> map);
				
			
			public int selectFindCount(Map<String, Object> map);
			
			public List<OrderDTO> selectFindList(Map<String, Object> map);
			
			public int selectOrderCount();
			
			
			// 상세보기(Admin)
			public OrderDTO selectOrderByNo(Long orderNo);
			
			
			
			// 수정(Admin)
			public int updateOrder(OrderDTO order);
			
			
			// 삭제(Admin)
			public int deleteOrderList(List<Long> list);
			
			
			// 개별삭제(Admin)
			public int deleteOrder(Long orderNo);

}
