package com.nike.web.service;


import com.nike.web.domain.CartDTO;

import java.util.List;

public interface CartService {

    public List<CartDTO> getCartByNo(long memberNo);

    public int addCart(CartDTO cart);

    public int updateCart(CartDTO cart);

    public int removeCartOne(int cartNo);

    public int removeCartAll(long memberNo);

}