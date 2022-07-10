package com.nike.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.web.domain.CartDTO;
import com.nike.web.mapper.CartMapper;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper cartMapper;

    @Override
    public int addCart(CartDTO cart) {

        int res = cartMapper.insertCart(cart);
        return res;

    }

    @Override
    public List<CartDTO> getCartByNo(long memberNo) {

        return cartMapper.selectListByMemberNo(memberNo);

    }

    @Override
    public int updateCart(CartDTO cart) {

        int res = cartMapper.updateCart(cart);
        return res;
    }

    @Override
    public int removeCartOne(int cartNo) {

        int res = cartMapper.deleteCartOne(cartNo);
        return res;

    }

    public int removeCartAll(long memberNo) {

        return cartMapper.deleteCartAll(memberNo);

    }

}