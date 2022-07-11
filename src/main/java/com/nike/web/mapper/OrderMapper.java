package com.nike.web.mapper;

import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.OrderDetailDTO;
import com.nike.web.domain.OrderItemDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    public int insertOrder(OrderDTO order);

    public int insertOrderDetail(OrderDetailDTO orderDetailDTO);

    public OrderItemDTO selectProductsByNo(Map<String, Object> map);

    public OrderItemDTO selectProductByNo(int productNo);

    public List<OrderDTO> selectOrderByMemberNo(Map<String, Object> map);

    public List<OrderDTO> selectProductDetailByOrderId(String orderId);

    public List<OrderDTO> selectInfoByOrderId(String orderId);

    public int selectCountByOrderId(String orderId);

    public int selectOrderCntByMemberNo(long memberNo);

}