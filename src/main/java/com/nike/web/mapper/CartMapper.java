package com.nike.web.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.nike.web.domain.CartDTO;

import java.util.List;

@Mapper
public interface CartMapper {

    public List<CartDTO> selectListByMemberNo(long memberNo);

    public int insertCart(CartDTO cart);

    public int updateCart(CartDTO cart);

    public int deleteCartOne(int cartNo);

    public int deleteCartAll(long memberNo);

    public int selectproductNobyCartNo(int cartNo);

    public int selectcartQtybyCartNo(int cartNo);

}