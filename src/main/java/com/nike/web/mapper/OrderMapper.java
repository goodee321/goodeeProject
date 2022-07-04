package com.nike.web.mapper;

<<<<<<< HEAD
import java.util.List;
import java.util.Map;

=======
import com.nike.web.domain.OrderDTO;
import com.nike.web.domain.OrderDetailDTO;
import com.nike.web.domain.OrderItemDTO;
>>>>>>> main
import org.apache.ibatis.annotations.Mapper;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.OrderDTO;

@Mapper
public interface OrderMapper {

<<<<<<< HEAD
	
	
	
	
=======
    public int insertOrder(OrderDTO order);

    public int insertOrderDetail(OrderDetailDTO orderDetailDTO);

    public OrderItemDTO selectProductByNo(int productNo);

    public int cancelOrder(String impUid);

>>>>>>> main
}