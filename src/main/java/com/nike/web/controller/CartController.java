package com.nike.web.controller;

import com.nike.web.domain.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.nike.web.domain.CartDTO;
import com.nike.web.service.CartService;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CartController {

    @Autowired
    private CartService cartService;

    @ResponseBody
    @PostMapping(value = "cart/add")
    public int addCart(CartDTO cart, HttpSession session) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return 0;
        }
        cart.setMemberNo(loginMember.getMemberNo());
        return cartService.addCart(cart);
    }

    @GetMapping("cart/list")
    public void cartlist(HttpSession session, Model model) {
        MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
        long MemberNo = loginMember.getMemberNo();
        cartService.getCartByNo(MemberNo, model);
    }

    @PostMapping(value = "cart/update")
    public String updateCart(CartDTO cart) {
        cartService.updateCart(cart);
        return "redirect:/cart/list";
    }

    @ResponseBody
    @PostMapping(value = "cart/remove")
    public int removeCartOne(int cartNo) {
        return cartService.removeCartOne(cartNo);
    }

    @ResponseBody
    @PostMapping(value = "cart/removeAll")
    public int removeCartAll(long memberNo) {
        return cartService.removeCartAll(memberNo);
    }

}