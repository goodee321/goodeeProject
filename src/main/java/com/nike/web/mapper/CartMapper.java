package com.nike.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.nike.web.domain.CartDTO;

@Mapper
public interface CartMapper {

    public CartDTO selectListByMemberNo(int memberNo);

    public CartDTO existCart(CartDTO cart);

    public int insertCart(CartDTO cart);

    public int updateCart(CartDTO cart);

    public int deleteCartOne(int productNo);

    public int deleteCartAll(int memberNo);

}
