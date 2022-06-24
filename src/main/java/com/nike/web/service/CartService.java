package com.nike.web.service;

import java.util.List;
import java.util.Map;

import com.nike.web.domain.CartDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.ObjectView;

public interface CartService {

    public CartDTO getCartByNo(int memberNo);

    public void addCart(HttpServletRequest request, HttpServletResponse response);

    public void updateCart(CartDTO cart);

    public int removeCartOne(int cartNo);

    public int removeCartAll(int memberNo);

}