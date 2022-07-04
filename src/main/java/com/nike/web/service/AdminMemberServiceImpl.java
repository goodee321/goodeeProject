package com.nike.web.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.mapper.AdminMemberMapper;
import com.nike.web.mapper.MemberMapper;
import com.nike.web.util.PageUtils;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	
	@Autowired
	private AdminMemberMapper AdminMemberMapper;
	
	// 얘가목록(Admin)
			@Override
			public void getMembers(HttpServletRequest request, Model model ) {
				// TODO Auto-generated method stub
				
				Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
				int page = Integer.parseInt(opt.orElse("1"));
				
				int totalRecord = AdminMemberMapper.selectMemberCount();
				
				PageUtils pageUtils = new PageUtils();
				pageUtils.setPageEntity(totalRecord, page);
				
				Map<String, Object> map = new HashMap<>();
				map.put("beginRecord", pageUtils.getBeginRecord() - 1);
				map.put("recordPerPage", pageUtils.getRecordPerPage());
				
				List<MemberDTO> members = AdminMemberMapper.selectMemberList(map);
				
				model.addAttribute("members", members);
				model.addAttribute("totalRecord", totalRecord);
				model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/member/list"));
				
				
//				int page = 1;
//				String strPage = request.getParameter("page");
//				if(strPage != null) {
//					page = Integer.parseInt(strPage);
//				}
				
				
			}
			
			
			// 검색햇을때
			@Override
			public void findMembers(HttpServletRequest request, Model model) {
				// TODO Auto-generated method stub
				// request에서 page 파라미터 꺼내기
				// page 파라미터는 전달되지 않는 경우 page = 1을 사용
				Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
				int page = Integer.parseInt(opt.orElse("1"));
				
				
				// column, query, begin, end 파라미터 꺼내기
				String column = request.getParameter("column");
				String query = request.getParameter("query");
				
				
				// column + query + begin + end => Map
				Map<String, Object> map = new HashMap<>();
				map.put("column", column);
				map.put("query", query);
				
				
				// 검색된 레코드 갯수 가져오기
				int findRecord = AdminMemberMapper.selectFindCount(map);
				
				
				int totalRecord = AdminMemberMapper.selectMemberCount();
				
				
				// findRecord와 page를 알면 PageEntity를 모두 계산할 수 있다.
				PageUtils pageUtils = new PageUtils();
				pageUtils.setPageEntity(findRecord, page);
				pageUtils.setPageEntity(totalRecord, page);
				
				// beginRecord + endRecord => Map
				map.put("beginRecord", pageUtils.getBeginRecord() - 1);
				map.put("recordPerPage", pageUtils.getRecordPerPage());
				
				// beginRecord ~ endRecord 사이 검색된 목록 가져오기
				List<MemberDTO> members = AdminMemberMapper.selectFindList(map);
				
				// list.jsp로 forward할 때 가지고 갈 속성 저장하기
				model.addAttribute("members", members);
				model.addAttribute("findRecord", findRecord);
				model.addAttribute("totalRecord", totalRecord);
				model.addAttribute("beginNo", findRecord - pageUtils.getRecordPerPage() * (page - 1));
				
				
				// 검색 카테고리에 따라서 전달되는 파라미터가 다름
				switch(column) {
				case "ID":
				case "NAME":
					model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/member/search?column=" + column + "&query=" + query));
					break;
				
				}
			}
			
			
			
			
			
			// 선택삭제(Admin)
			@Override
			public int removeList(HttpServletRequest request) {
				// 한 번에 여러 개 지우기
				// DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
				String[] memberNoList = request.getParameterValues("memberNoList");  // {"1", "4"}
				List<Long> list = new ArrayList<>();
				for(int i = 0; i < memberNoList.length; i++) {
					list.add(Long.parseLong(memberNoList[i]));  // list.add(1) -> list.add(4)
				}
				return AdminMemberMapper.deleteMemberList(list);
			}
			
			
			// 상세보기(Admin)
			@Override
			public MemberDTO findMemberByNo(HttpServletRequest request) {
				// TODO Auto-generated method stub
				
				String requestURI = request.getRequestURI();  // "/ex09/notice/detail"
				String[] arr = requestURI.split("/");         // { "", "ex09", "notice", "detail"}
				
				Long memberNo = Long.parseLong(request.getParameter("memberNo"));
				
				return AdminMemberMapper.selectMemberByNo(memberNo); 
			}
			
			// 수정(Admin)
			@Override
			public int change(HttpServletRequest request) {
				MemberDTO member = new MemberDTO();
				member.setMemberNo(Long.parseLong(request.getParameter("memberNo")));
				member.setName(request.getParameter("name"));
				member.setEmail(request.getParameter("email"));
				member.setAddress(request.getParameter("address"));
				member.setAddrDetail(request.getParameter("addrDetail"));
				member.setPhone(request.getParameter("phone"));
				return AdminMemberMapper.updateMember(member);
			}
		
			
			//개별삭제(Admin)
			@Override
			public int removeOne(HttpServletRequest request) {
				Long memberNo = Long.parseLong(request.getParameter("memberNo"));
				return AdminMemberMapper.deleteMember(memberNo);
			}


			
}
