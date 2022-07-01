package com.nike.web.controller;

import com.nike.web.domain.*;
import com.nike.web.service.MemberService;
import com.nike.web.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private MemberService memberService;

    @GetMapping("order/detailPage/{memberNo}")
    public String orderdetail(@PathVariable("memberNo") long memberNo, OrderItemDTO order, Model model) {
        model.addAttribute("memberInfo", memberService.getMemberByNo(memberNo));
        model.addAttribute("orderList", orderService.productInfo(order.getOrders()));
        return "order/detail";
    }

    @ResponseBody
    @PostMapping("order/result")
    public int orderComplete(String impUid, OrderDTO order, HttpServletRequest request) {
        return orderService.orderComplete(impUid, order, request);
    }

    @GetMapping("order/completePage")
    public String completePage() {
        return "order/complete";
    }

}