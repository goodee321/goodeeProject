package com.nike.web.controller;

import com.nike.web.domain.*;
import com.nike.web.service.MemberService;
import com.nike.web.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private MemberService memberService;

    @GetMapping(value = "order/detailPage/{memberNo}", produces = "application/json; charset=UTF-8")
    public String orderDetail(@PathVariable("memberNo") long memberNo, OrderItemDTO order, Model model) {
        model.addAttribute("memberInfo", memberService.getMemberByNo(memberNo));
        model.addAttribute("orderList", orderService.productInfo(order.getOrders()));
        return "order/detail";
    }

    @GetMapping(value = "order/orderPage/{memberNo}", produces = "application/json; charset=UTF-8")
    public String orderPage(@PathVariable("memberNo") long memberNo, HttpServletRequest request, Model model) {
        model.addAttribute("memberInfo", memberService.getMemberByNo(memberNo));
        model.addAttribute("orderList", orderService.product(request));
        return "order/detail";
    }

    @GetMapping(value = "order/orderPages/{memberNo}", produces = "application/json; charset=UTF-8")
    public String orderPages(@PathVariable("memberNo") long memberNo, HttpServletRequest request, Model model) {
        model.addAttribute("memberInfo", memberService.getMemberByNo(memberNo));
        model.addAttribute("orderList", orderService.product(request));
        return "order/detail2";
    }

    @ResponseBody
    @PostMapping(value = "order/result")
    public int orderComplete(String impUid, OrderDTO order, HttpServletRequest request) {
        return orderService.orderComplete(impUid, order, request);
    }

    @GetMapping("order/completePage/{orderId}")
    public String completePage(@PathVariable("orderId") String orderId, Model model) {
        orderService.getOrderByOrderId(orderId, model);
        return "order/complete";
    }

    @GetMapping("order/errorPage")
    public String errorPage() {
        return "order/error";
    }

}