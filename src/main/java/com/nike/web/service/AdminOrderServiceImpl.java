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

import com.nike.web.domain.OrderDTO;
import com.nike.web.mapper.AdminOrderMapper;
import com.nike.web.mapper.OrderMapper;
import com.nike.web.util.PageUtils;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

	@Autowired
	private AdminOrderMapper adminOrderMapper;
	
	
	
	
				// 전체목록
				@Override
				public void getOrders(HttpServletRequest request, Model model ) {
					// TODO Auto-generated method stub
					
					Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
					int page = Integer.parseInt(opt.orElse("1"));
					
					int totalRecord = adminOrderMapper.selectOrderCount();
					
					PageUtils pageUtils = new PageUtils();
					pageUtils.setPageEntity(totalRecord, page);
					
					Map<String, Object> map = new HashMap<>();
					map.put("beginRecord", pageUtils.getBeginRecord() - 1);
					map.put("recordPerPage", pageUtils.getRecordPerPage());
					
					List<OrderDTO> orders = adminOrderMapper.selectOrderList(map);
					
					model.addAttribute("orders", orders);
					model.addAttribute("totalRecord", totalRecord);
					model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/order/list"));
					
					
//					int page = 1;
//					String strPage = request.getParameter("page");
//					if(strPage != null) {
//						page = Integer.parseInt(strPage);
//					}
					
					
				}
				
				
				// 검색목록
				@Override
				public void findOrders(HttpServletRequest request, Model model) {
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
					int findRecord = adminOrderMapper.selectFindCount(map);
					
					
					int totalRecord = adminOrderMapper.selectOrderCount();
					
					// findRecord와 page를 알면 PageEntity를 모두 계산할 수 있다.
					PageUtils pageUtils = new PageUtils();
					pageUtils.setPageEntity(findRecord, page);
					
					// beginRecord + endRecord => Map
					map.put("beginRecord", pageUtils.getBeginRecord() - 1);
					map.put("recordPerPage", pageUtils.getRecordPerPage());
					
					// beginRecord ~ endRecord 사이 검색된 목록 가져오기
					List<OrderDTO> orders = adminOrderMapper.selectFindList(map);
					
					// list.jsp로 forward할 때 가지고 갈 속성 저장하기
					model.addAttribute("orders", orders);
					model.addAttribute("findRecord", findRecord);
					model.addAttribute("totalRecord", totalRecord);
					model.addAttribute("beginNo", findRecord - pageUtils.getRecordPerPage() * (page - 1));
					
					// 검색 카테고리에 따라서 전달되는 파라미터가 다름
					switch(column) {
					case "ORDER_NO":
					case "MEMBER_NO":
						model.addAttribute("paging", pageUtils.getPaging(request.getContextPath() + "/admin/order/search?column=" + column + "&query=" + query));
						break;
					
					}
				}
				
				
				// 상세보기
				@Override
				public OrderDTO findOrderByNo(HttpServletRequest request) {
					// TODO Auto-generated method stub
					
					String requestURI = request.getRequestURI();  // "/ex09/notice/detail"
					String[] arr = requestURI.split("/");         // { "", "ex09", "notice", "detail"}
					
					Long orderNo = Long.parseLong(request.getParameter("orderNo"));
					
					return adminOrderMapper.selectOrderByNo(orderNo); 
				}
				
				
				
				// 수정
				@Override
				public int change(HttpServletRequest request) {
					OrderDTO order = new OrderDTO();
					order.setOrderNo(Integer.parseInt(request.getParameter("orderNo")));
					order.setOrderName(request.getParameter("orderName"));
					order.setOrderPhone(request.getParameter("orderPhone"));
					order.setOrderAddr(request.getParameter("orderAddr"));
					order.setAddrDetail(request.getParameter("addrDetail"));
					order.setOrderInvoice(Integer.parseInt(request.getParameter("orderInvoice")));
					order.setOrderDelivery(Integer.parseInt(request.getParameter("orderDelivery")));
					order.setOrderState(Integer.parseInt(request.getParameter("orderState")));
					return adminOrderMapper.updateOrder(order);
				}
				
				
				
				// 선택삭제
				@Override
				public int removeList(HttpServletRequest request) {
					// 한 번에 여러 개 지우기
					// DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
					String[] orderNoList = request.getParameterValues("orderNoList");  // {"1", "4"}
					List<Long> list = new ArrayList<>();
					for(int i = 0; i < orderNoList.length; i++) {
						list.add(Long.parseLong(orderNoList[i]));  // list.add(1) -> list.add(4)
					}
					return adminOrderMapper.deleteOrderList(list);
				}
				
				
				//개별삭제
				@Override
				public int removeOne(HttpServletRequest request) {
					Long orderNo = Long.parseLong(request.getParameter("orderNo"));
					return adminOrderMapper.deleteOrder(orderNo);
				}
	
}
