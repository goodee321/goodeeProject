package com.nike.web.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.nike.web.domain.OrderDTO;
import org.springframework.ui.Model;


import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.SignOutMemberDTO;

public interface MemberService {
    public Map<String, Object> idCheck(String id);

    public Map<String, Object> emailCheck(String email);

    public Map<String, Object> sendAuthCode(String email);

    public void signIn(HttpServletRequest request, HttpServletResponse response);

    public void signOut(HttpServletRequest request, HttpServletResponse response);

    public MemberDTO login(HttpServletRequest request);

    public SignOutMemberDTO findSignOutMember(String id);

    public void reSignIn(HttpServletRequest request, HttpServletResponse response);

    public void modify(HttpServletRequest request, HttpServletResponse response);

    public void modifyPw(HttpServletRequest request, HttpServletResponse response);

    public void findId(HttpServletRequest request, HttpServletResponse response);

    public void findPw(HttpServletRequest request, HttpServletResponse response);

    public List<MemberDTO> getMemberByNo(long memberNo);

    public List<OrderDTO> getOrderByMemberNo(long memberNo);

    public void OrderDetail(String OrderId, Model model);
}