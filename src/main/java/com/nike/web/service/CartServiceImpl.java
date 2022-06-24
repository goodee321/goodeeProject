package com.nike.web.service;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nike.web.domain.CartDTO;
import com.nike.web.mapper.CartMapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartMapper cartMapper;

    @Override
    public void addCart(HttpServletRequest request, HttpServletResponse response) {

        int memberNo = 1;
        int productNo = 1;
        int cartQty = Integer.parseInt(request.getParameter("cartQty"));

        CartDTO cart = CartDTO.builder()
                .memberNo(memberNo)
                .productNo(productNo)
                .cartQty(cartQty)
                .build();

        int res = cartMapper.insertCart(cart);

        try {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (res > 0) {
                out.println("<script>");
                out.println("if(confirm('장바구니에 상품을 담았습니다." + "\\n" + "장바구니로 이동하시겠습니까?')){");
                out.println("location.href='" + request.getContextPath() + "/cart/list/" + memberNo + "'");
                out.println("}");
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("alert('장바구니 담기에 실패하였습니다." + "\\n" + "다시 시도해주세요.')");
                out.println("history.back()");
                out.println("</script>");
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public CartDTO getCartByNo(int memberNo) {

        return cartMapper.selectListByMemberNo(memberNo);

    }

    @Override
    public void updateCart(CartDTO cart) {

        cartMapper.updateCart(cart);

    }

    @Override
    public int removeCartOne(int cartNo) {

        return cartMapper.deleteCartOne(cartNo);

    }

    public int removeCartAll(int memberNo) {

        return cartMapper.deleteCartAll(memberNo);

    }

}
