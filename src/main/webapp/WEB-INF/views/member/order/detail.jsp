<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .content {
            padding: 20px 0 0 0;
            position: relative;
            width: 1308px;
            margin-left: 300px;
            margin-right: 135px;
        }
    </style>
    <link href="../../../resources/css/member.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../../layout/header.jsp"></jsp:include>
<div>
    <div id="wrap">
        <div class="content">
            <div class="mypage_main">
                <div class="mypage_lately_info">
                    <div class="mypage_zone_tit">
                        <h3>주문/배송상세</h3>
                    </div>
                    <div class="mypage_lately_info_cont">
                        <div class="mypage_table_type">
                            <table>
                                <colgroup>
                                    <col style="width:15%">
                                    <col>
                                    <col style="width:15%">
                                    <col style="width:15%">
                                    <col style="width:15%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>날짜/주문번호</th>
                                    <th>상품명/옵션</th>
                                    <th>상품금액</th>
                                    <th>수량</th>
                                    <th>
                                        주문상태
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="row_line" data-order-no="${detail.orderId}"
                                    data-order-goodsno="${detail.productNo}">
                                    <td rowspan="${orderCnt}" class="order_day_num">
                                        <span class="order_num_link">${memberInfo[0].orderId}</span><br>
                                        <em style="font-size: 13px">(${memberInfo[0].orderDate})</em>
                                        <div class="btn_claim">
                                        </div>
                                    </td>
                                    <c:forEach items="${products}" var="detail">
                                    <td class="td_left">
                                        <div class="pick_add_cont">
                    <span class="pick_add_img">
                        <a href="${contextPath}/product/detail?proNo=${detail.productNo}"><img
                                src="${contextPath}/product/display?proimgNo=${detail.proimgNo}"
                                width="70" class="middle"/></a>
                    </span>
                                            <div class="pick_add_info">
                                                <a href="${contextPath}/product/detail?proNo=${detail.productNo}"><em>${detail.proName} / ${detail.productSize}</em></a>
                                            </div>

                                        </div>
                                    </td>
                                    <td><strong><fmt:formatNumber value="${detail.proPrice}" pattern="#,##0"/>원</strong>
                                    </td>
                                    <td>${detail.orderQty}개</td>
                                    <td>
                                        <em>
                                            <c:if test="${memberInfo[0].orderState eq '0'}">
                                                결제완료
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderState eq '1'}">
                                                배송준비중
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderState eq '2'}">
                                                배송중
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderState eq '3'}">
                                                배송완료
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderState eq '4'}">
                                                주문취소
                                            </c:if>
                                        </em>
                                    </td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="order_view_info">
                    <div class="orderer_info">
                        <div class="mypage_zone_tit">
                            <h4>주문자 정보</h4>
                        </div>
                        <div class="mypage_table_type">
                            <table class="table_left">
                                <colgroup>
                                    <col style="width:15%;">
                                    <col style="width:85%;">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th scope="row">주문자 정보</th>
                                    <td>${memberInfo[0].orderName}</td>
                                </tr>
                                <tr>
                                    <th scope="row">주소</th>
                                    <td>
                                        (${memberInfo[0].orderPostcode}) ${memberInfo[0].orderAddr}, ${memberInfo[0].addrDetail}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">휴대폰 번호</th>
                                    <td>
                                        ${memberInfo[0].orderPhone}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">이메일</th>
                                    <td>${loginMember.email}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="delivery_info">
                        <div class="mypage_zone_tit">
                            <h4>배송지 정보</h4>
                        </div>
                        <div class="mypage_table_type">
                            <table class="table_left">
                                <colgroup>
                                    <col style="width:15%;">
                                    <col style="width:85%;">
                                </colgroup>
                                <tbody>
                                <tr>
                                    <th scope="row">수령인</th>
                                    <td>${memberInfo[0].orderName}</td>
                                </tr>
                                <tr>
                                    <th scope="row">주소</th>
                                    <td>
                                        (${memberInfo[0].orderPostcode}) ${memberInfo[0].orderAddr}, ${memberInfo[0].addrDetail}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">휴대폰 번호</th>
                                    <td>
                                        ${memberInfo[0].orderPhone}
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">요청사항</th>
                                    <td>${memberInfo[0].orderMessage}</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="mypage_zone_tit">
                        <h4>결제정보</h4>
                    </div>
                    <div class="mypage_table_type">
                        <table class="table_left">
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:85%;">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row">상품 합계 금액</th>
                                <td>
                                    <fmt:formatNumber value="${memberInfo[0].orderAmount - memberInfo[0].orderDelivery}"
                                                      pattern="#,##0"/>원
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">배송비</th>
                                <td>
                                    <fmt:formatNumber value="${memberInfo[0].orderDelivery}" pattern="#,##0"/>원
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">총 결제 금액</th>
                                <td><strong class="total_pay_money">
                                    <fmt:formatNumber value="${memberInfo[0].orderAmount}" pattern="#,##0"/>원
                                </strong></td>
                            </tr>
                            <tr>
                                <th scope="row">결제수단</th>
                                <td>
                                    <div class="pay_with_list">
                                        <strong>
                                            <c:if test="${memberInfo[0].orderPayment eq 'kakaopay'}">
                                                카카오페이
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderPayment eq 'tosspay'}">
                                                토스
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderPayment eq 'html5_inicis'}">
                                                신용카드
                                            </c:if>
                                            <c:if test="${memberInfo[0].orderPayment eq 'settle'}">
                                                세틀뱅크
                                            </c:if>
                                        </strong>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="btn_center_box" style="margin-bottom: 80px;">
                        <a href="${contextPath}/member/order/list" class="btn_order_end_ok"><em>목록보기</em></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="scroll_right">
    <div class="right_banner">
            <span class="btn_scroll_top">
                <a href="#TOP">
                    <i class="fa-solid fa-angle-up fa-lg"></i>
                </a>
            </span>
    </div>
</div>
<jsp:include page="../../layout/Footer.jsp"></jsp:include>
</body>
</html>