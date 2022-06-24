package com.nike.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nike.web.domain.CartDTO;
import com.nike.web.service.CartService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("list/{memberNo}")
    public String list(@PathVariable("memberNo") int memberNo, Model model) {
        model.addAttribute("cart", cartService.getCartByNo(memberNo));
        return "cart/list";
    }

    @PostMapping(value = "/add")
    public void addCart(HttpServletRequest request, HttpServletResponse response) {
        cartService.addCart(request, response);
    }

    @ResponseBody
    @PutMapping(value = "/update", produces = "application/json")
    public String updateCart(@RequestBody CartDTO cart) {
        cartService.updateCart(cart);
        return "redirect:/cart/list" + cart.getMemberNo();
    }

    @ResponseBody
    @PostMapping(value = "/remove/{productNo}", produces = "application/json")
    public void removeCartOne(@PathVariable int cartNo) {
        cartService.removeCartOne(cartNo);
    }

    @ResponseBody
    @PostMapping(value = "/remove/{memberNo}", produces = "application/json")
    public void removeCartAll(@PathVariable int memberNo) {
        cartService.removeCartAll(memberNo);
    }

}