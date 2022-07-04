package com.nike.web.service;

<<<<<<< HEAD
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
=======
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.nike.web.domain.*;
import com.nike.web.mapper.CartMapper;
import com.nike.web.mapper.OrderMapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
>>>>>>> main
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.nike.web.domain.MemberDTO;
import com.nike.web.domain.OrderDTO;

import com.nike.web.mapper.OrderMapper;
import com.nike.web.util.PageUtils;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class OrderServiceImpl implements OrderService {

<<<<<<< HEAD
	@Autowired
	private OrderMapper orderMapper;
	
	
	
	@Override
	public String getTokens() {
		// TODO Auto-generated method stub
		return null;
	}
=======
    @Autowired
    private OrderMapper orderMapper;
>>>>>>> main

    @Autowired
    private CartMapper cartMapper;

<<<<<<< HEAD
	@Override
	public void paymentCancle(String token, String impUid, int orderAmount, String reason) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
	
	
	
			
=======
    private static final String API_URL = "https://api.iamport.kr";
    private String api_key = "5322178257678425";
    private String api_secret = "7aa2cb74dbc0400f03e46b2adde201695e63abbffcc0fd948a9c78a9ec63b22e9469298f8d600532";
>>>>>>> main

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

    @Override
    public int paymentInfo(String impUid, String token) {

        HttpsURLConnection conn = null;
        JSONObject result = null;

        try {
            URL url = new URL(API_URL + "/payments/" + impUid);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", token);
            conn.setDoOutput(true);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            conn.disconnect();
            result = (JSONObject) new JSONParser().parse(sb.toString());
            JSONObject response = (JSONObject) result.get("response");
            int amount = Integer.parseInt(String.valueOf(response.get("amount")));
            return amount;
        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ResponseEntity<String> orderComplete(String impUid, OrderDTO order, HttpServletRequest request) {

        String token = getToken();

        int amount = paymentInfo(impUid, token);

        try {
            int orderAmount = order.getOrderAmount();

            if (orderAmount != amount) {
                OrderCancel(impUid, amount, "OrderCancel");
                return new ResponseEntity<String>("비정상적인 결제 금액으로 인한 주문 실패", HttpStatus.BAD_REQUEST);
            }

            int res = orderMapper.insertOrder(order);

            if (res > 0) {
                String[] cartNo = request.getParameterValues("cartNo");
                int size = cartNo.length;

                String[] orderPrice = request.getParameterValues("orderPrice");
                int price = orderPrice.length;

                OrderDetailDTO odd = new OrderDetailDTO();

                for (int i = 0; i < size; i++) {
                    for (int j = 0; j < price; j++) {
                        odd = OrderDetailDTO.builder()
                                .productNo(cartMapper.selectproductNobyCartNo(Integer.parseInt(cartNo[i])))
                                .orderId(order.getOrderId())
                                .orderQty(cartMapper.selectcartQtybyCartNo(Integer.parseInt(cartNo[i])))
                                .orderPrice(Integer.parseInt(orderPrice[i]))
                                .build();
                    }
                    res += orderMapper.insertOrderDetail(odd);
                }

                if (res > 1) {
                    for (int i = 0; i < size; i++) {
                        res += cartMapper.deleteCartOne(Integer.parseInt(cartNo[i]));
                    }
                    return new ResponseEntity<String>("주문 완료", HttpStatus.OK);
                }
            }
        } catch (Exception e) {
            OrderCancel(impUid, amount, "OrderCancel");
            return new ResponseEntity<String>("결제 에러", HttpStatus.BAD_REQUEST);
        }
        return null;
    }

    @Override
    public void OrderCancel(String impUid, int amount, String reason) {

        String token = this.getToken();
        HttpsURLConnection conn = null;
        JSONObject result = null;

        try {
            URL url = new URL(API_URL + "/payments/cancel");
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", token);
            conn.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
            conn.setRequestProperty("Accept", "application/json;charset=UTF-8");
            conn.setDoOutput(true);

            JsonObject json = new JsonObject();

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
            System.out.println(result);

            br.close();
            conn.disconnect();

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }

    }

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
            int amount = Integer.parseInt(request.getParameter("ordreAmount"));

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
                res = orderMapper.cancelOrder(impUid);
                return res;
            }

            br.close();
            conn.disconnect();

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }

        return 0;

    }

    @Override
    public List<OrderItemDTO> productInfo(List<OrderItemDTO> order) {

        List<OrderItemDTO> products = new ArrayList<>();
        for (OrderItemDTO orders : order) {
            OrderItemDTO productInfo = orderMapper.selectProductByNo(orders.getProductNo());
            productInfo.setCartNo(orders.getCartNo());
            productInfo.setProductNo(orders.getProductNo());
            productInfo.setCartQty(orders.getCartQty());
            productInfo.initSaleTotal();
            products.add(productInfo);
        }
        return products;

    }
}