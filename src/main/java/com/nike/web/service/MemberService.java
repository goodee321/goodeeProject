package com.nike.web.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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

	
	
	
	
	// 목록(Admin)
	public void findMembers(HttpServletRequest request, Model model);
		
	//
	public void getMembers(HttpServletRequest request, Model model);
	
	
	//
	public Map<String, Object> autoComplete(HttpServletRequest request);
	
	
	
	// 삭제(선택해서삭제, Admin)
	public int removeList2(HttpServletRequest request);
		
	// 세부사항(Admin)
	public MemberDTO findMemberByNo(HttpServletRequest request);
		
	// 수정(Admin)
	public int change(HttpServletRequest request);
	
	// 개별삭제(Admin)
	public int removeOne(HttpServletRequest request);
	
	
	
	

}
