package com.nike.web.mapper;

import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.OrderDetailDTO;
import com.nike.web.domain.OrderItemDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {

    public int insertOrder(OrderDTO order);

    public int insertOrderDetail(OrderDetailDTO orderDetailDTO);

    public OrderItemDTO selectProductByNo(int productNo);

    public int cancelOrder(String impUid);

}