package com.nike.web.service;

import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
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

    private static final String API_URL = "https://api.iamport.kr";
    private String api_key = "5322178257678425";
    private String api_secret = "7aa2cb74dbc0400f03e46b2adde201695e63abbffcc0fd948a9c78a9ec63b22e9469298f8d600532";

    // 전체목록
    @Override
    public void getOrders(HttpServletRequest request, Model model) {
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
        switch (column) {
            case "ORDER_NO":
            case "MEMBER_NO":
            case "ORDER_NAME":
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
        return adminOrderMapper.updateOrder(order);
    }

    // 선택삭제
    @Override
    public int removeList(HttpServletRequest request) {
        // 한 번에 여러 개 지우기
        // DELETE FROM NOTICE WHERE NOTICE_NO IN(1, 4)
        String[] orderNoList = request.getParameterValues("orderNoList");  // {"1", "4"}
        List<Long> list = new ArrayList<>();
        for (int i = 0; i < orderNoList.length; i++) {
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

    @Override
    public String getToken() {

        HttpsURLConnection conn = null;

        try {
            URL url = new URL(API_URL + "/users/getToken");

            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            JsonObject json = new JsonObject();

            json.addProperty("imp_key", api_key);
            json.addProperty("imp_secret", api_secret);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            bw.write(json.toString());
            bw.flush();
            bw.close();

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            Gson gson = new Gson();
            String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
            String token = gson.fromJson(response, Map.class).get("access_token").toString();
            br.close();
            return token;
        } catch (IOException e) {
            throw new RuntimeException("요청 실패", e);
        } finally {
            conn.disconnect();
        }
    }

    //  관리자 주문 취소
    @Override
    public int adminCancel(HttpServletRequest request) {

        String token = getToken();
        HttpsURLConnection conn = null;
        JSONObject result = null;
        int res;

        try {
            URL url = new URL(API_URL + "/payments/cancel");
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", token);
            conn.setRequestProperty("Content-type", "application/json");
            conn.setRequestProperty("Accept", "application/json");
            conn.setDoOutput(true);

            JsonObject json = new JsonObject();

            String reason = request.getParameter("orderReason");
            String impUid = request.getParameter("orderImpUid");
            int amount = Integer.parseInt(request.getParameter("orderAmount"));

            json.addProperty("reason", reason);
            json.addProperty("imp_uid", impUid);
            json.addProperty("amount", amount);
            json.addProperty("checksum", amount);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream(), "UTF-8"));
            bw.write(json.toString());
            bw.flush();
            bw.close();

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            result = (JSONObject) new JSONParser().parse(sb.toString());
            int code = Integer.parseInt(String.valueOf(result.get("code")));

            if (code == 0) {
                res = adminOrderMapper.cancelOrder(impUid);
                return res;
            }

            br.close();
            conn.disconnect();

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }

        return 0;

    }

}
