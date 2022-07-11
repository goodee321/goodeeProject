package com.nike.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.web.domain.CartDTO;
import com.nike.web.mapper.CartMapper;
import org.springframework.ui.Model;

import java.util.List;
import java.util.Map;

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
    public void getCartByNo(long memberNo, Model model) {
        model.addAttribute("cartList", cartMapper.selectListByMemberNo(memberNo));
        model.addAttribute("cartCnt", cartMapper.selectCartCntByMemberNo(memberNo));
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