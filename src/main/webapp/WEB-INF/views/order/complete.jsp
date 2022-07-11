<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="../../resources/js/jquery-3.6.0.js"></script>
    <script src="https://kit.fontawesome.com/6d7aa13a31.js" crossorigin="anonymous"></script>
    <link href="../../resources/css/order.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../layout/header.jsp"></jsp:include>
<div id="container">
    <div id="contents">
        <div class="sub_content">
            <div class="content_box">
                <div class="order_wrap">
                    <div class="order_cont">
                        <div class="order_end">
                            <div class="order_end_completion">
                                <img src="../../resources/images/order/orderComplete.png" width="90px">
                                <p><strong>주문이 정상적으로 접수 되었습니다.</strong><br/><em>감사합니다.<br></em></p>
                            </div>
                            <div class="order_table_type" style="margin-left: 280px;">
                                <table class="table_left">
                                    <colgroup>
                                        <col style="width:15%;">
                                        <col style="width:85%;">
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th>결제수단</th>
                                        <td>
                                            <div class="pay_with_list">
                                                <strong>
                                                    <c:if test="${orderList[0].orderPayment eq 'kakaopay'}">
                                                        카카오페이
                                                    </c:if>
                                                    <c:if test="${orderList[0].orderPayment eq 'tosspay'}">
                                                        토스
                                                    </c:if>
                                                    <c:if test="${orderList[0].orderPayment eq 'html5_inicis'}">
                                                        신용카드
                                                    </c:if>
                                                    <c:if test="${orderList[0].orderPayment eq 'settle'}">
                                                        세틀뱅크
                                                    </c:if>
                                                </strong>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>주문번호</th>
                                        <td>${orderList[0].orderId}</td>
                                    </tr>
                                    <tr>
                                        <th>주문일자</th>
                                        <td>${orderList[0].orderDate}</td>
                                    </tr>
                                    <tr>
                                        <th>주문자명</th>
                                        <td>${orderList[0].orderName}</td>
                                    </tr>
                                    <tr>
                                        <th>배송정보</th>
                                        <td>
                                            [${orderList[0].orderPostcode}] ${orderList[0].orderAddr}, ${orderList[0].addrDetail}<br/>
                                            ${orderList[0].orderPhone}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>요청사항</th>
                                        <td>
                                            ${orderList[0].orderMessage}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>배송비</th>
                                        <td>
                                            <c:if test="${orderList[0].orderDelivery == 0}">
                                                없음
                                            </c:if>
                                            <c:if test="${orderList[0].orderDelivery != 0}">
                                                <fmt:formatNumber value="${orderList[0].orderDelivery}"
                                                                  pattern="#,##0"></fmt:formatNumber>원
                                            </c:if>
                                            <span class="add_currency"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>총 결제금액</th>
                                        <td><strong class="order_payment_sum">19,000원</strong>
                                            <span class="add_currency"></span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="btn_center_box" style="margin-bottom: 80px;">
                            <a href="/" class="btn_order_end_ok"><em>확인</em></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>