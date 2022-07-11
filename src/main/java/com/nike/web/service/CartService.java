package com.nike.web.service;


import com.nike.web.domain.CartDTO;
import org.springframework.ui.Model;

import java.util.List;

public interface CartService {

    public void getCartByNo(long memberNo, Model model);

    public int addCart(CartDTO cart);

    public int updateCart(CartDTO cart);

    public int removeCartOne(int cartNo);

    public int removeCartAll(long memberNo);

}