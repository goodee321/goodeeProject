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

import com.nike.web.domain.NoticeDTO;
import com.nike.web.mapper.AdminNoticeMapper;
import com.nike.web.mapper.NoticeMapper;
import com.nike.web.util.PageUtils;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {

	
	@Autowired
	private AdminNoticeMapper adminNoticeMapper;
	
	
				// Admin
				@Override
				public void findNotices(HttpServletRequest request, Model model) {
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
					int findRecord = adminNoticeMapper.selectFindCount(map);
					
					int totalRecord = adminNoticeMapper.selectNoticeCount();
					
					// findRecord와 page를 알면 PageEntity를 모두 계산할 수 있다.
					PageUtils pageUtils = new PageUtils();
					pageUtils.setPageEntity(findRecord, page);
					
					// beginRecord + endRecord => Map
					map.put("beginRecord", pageUtils.getBeginRecord() - 1);
					map.put("endRecord", pageUtils.getEndRecord());
					
					// beginRecord ~ endRecord 사이 검색된 목록 가져오기
					List<NoticeDTO> notices = adminNoticeMapper.selectFindList(map);
					
					// list.jsp로 forward할 때 가지고 갈 속성 저장하기
					model.addAttribute("notices", notices);
					model.addAttribute("findRecord", findRecord);
					model.addAttribute("totalRecord", totalRecord);
					model.addAttribute("beginNo", findRecord - pageUtils.getRecordPerPage() * (page - 1));
					
					// 검색 카테고리에 따라서 전달되는 파라미터가 다름
					switch(column) {
					case "NOTICE_TITLE":
					case "NOTICE_CONTENT":
						model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/notice/search?column=" + column + "&query=" + query));
						break;
					
					}
				}
		
		
		
		
		
			// 목록(Admin)
			@Override
			public void getNotices(HttpServletRequest request, Model model) {
				// TODO Auto-generated method stub
				Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
				int page = Integer.parseInt(opt.orElse("1"));
				
				int totalRecord = adminNoticeMapper.selectNoticeCount();
				
				PageUtils pageUtils = new PageUtils();
				pageUtils.setPageEntity(totalRecord, page);
				
				Map<String, Object> map = new HashMap<>();
				map.put("beginRecord", pageUtils.getBeginRecord() - 1);
				map.put("endRecord", pageUtils.getEndRecord());
				
				List<NoticeDTO> notices = adminNoticeMapper.selectNoticeList(map);
				
				model.addAttribute("notices", notices);
				model.addAttribute("totalRecord", totalRecord);
				model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/notice/list"));
			}
			
			
			// 상세보기(Admin)
			@Override
			public NoticeDTO findNoticeByNo(HttpServletRequest request) {
				String requestURI = request.getRequestURI();  // "/ex09/notice/detail"
				String[] arr = requestURI.split("/");         // { "", "ex09", "notice", "detail"}
				
				Long noticeNo = Long.parseLong(request.getParameter("noticeNo"));
				
				return adminNoticeMapper.selectNoticeByNo(noticeNo); 
			}
			
			// 수정(Admin)
			@Override
			public int change(HttpServletRequest request) {
				NoticeDTO notice = new NoticeDTO();
				notice.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
				notice.setNoticeTitle(request.getParameter("noticeTitle"));
				notice.setNoticeContent(request.getParameter("noticeContent"));
				
				return adminNoticeMapper.updateNotice(notice);
			}
			
			// 개별삭제(Admin)
			@Override
			public int removeOne(HttpServletRequest request) {
				Integer noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
				return adminNoticeMapper.deleteNotice(noticeNo);
			}
			
			
			// 삽입(Admin)
			@Override
			public int save(HttpServletRequest request) {
				
				NoticeDTO notice = new NoticeDTO();
				notice.setNoticeTitle(request.getParameter("noticeTitle"));
				notice.setNoticeContent(request.getParameter("noticeContent"));
				
				return adminNoticeMapper.insertNotice(notice);
			}
			
			
			// 선택삭제(Admin)
			@Override
			public int removeList(HttpServletRequest request) {
				// 한 번에 여러 개 지우기
				// DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
				String[] noticeNoList = request.getParameterValues("noticeNoList");  // {"1", "4"}
				List<Long> list = new ArrayList<>();
				for(int i = 0; i < noticeNoList.length; i++) {
					list.add(Long.parseLong(noticeNoList[i]));  // list.add(1) -> list.add(4)
				}
				return adminNoticeMapper.deleteNoticeList(list);
			}
	
	
}
