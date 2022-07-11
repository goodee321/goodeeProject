<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="../../resources/js/jquery-3.6.0.js"></script>
    <link href="../../resources/css/member.css" rel="stylesheet">
    <style>
        .link {
            display: inline-block; /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
            margin: 5px;
            border: 1px solid white;
            text-align: center;
            text-decoration: none; /* 링크 밑줄 없애기 */
            color: gray;
            font-weight: bold;
        }

        .unlink {
            display: inline-block; /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
            margin: 5px;
            border: 1px solid white;
            text-align: center;
            text-decoration: none; /* 링크 밑줄 없애기 */
            color: #ed8699;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../../layout/header.jsp"></jsp:include>
<div>
    <div id="wrap">
        <div class="content">
            <div class="mypage_cont">
                <div class="mypage_lately_info">
                    <div class="mypage_zone_tit" style="margin-left: 290px; padding-bottom: 0px;">
                        <h3>주문목록/배송조회</h3>
                    </div>
                    <div class="mypage_lately_info_cont">
                <span class="pick_list_num" style="margin-left: 290px;">
                    주문목록 / 배송조회 내역 총 <strong>${orderCount}</strong> 건
                </span>
                        <div class="mypage_table_type" style="margin-left: 290px; margin-right: 290px; margin-top: 10px;">
                            <table>
                                <colgroup>
                                    <col style="width:10%">
                                    <col style="width:20%">
                                    <col style="width:10%">
                                    <col style="width:10%">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>날짜/주문번호</th>
                                    <th>상품정보</th>
                                    <th>상품금액</th>
                                    <th>주문상태</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${orderList}" var="list">
                                    <tr class="" data-order-no="" data-order-goodsno="116755"
                                        data-order-status="o1"
                                        data-order-userhandlesno="0">
                                        <td rowspan="" class="order_day_num">
                                            <a href="${contextPath}/member/order/detail/${list.orderId}"
                                               class="order_num_link"><span style="font-size : 16px">${list.orderId}</span></a>
                                            <div class="btn_claim">
                                                <em style="font-size : 14px">${fn:substring(list.orderDate,0,10)}</em><br>
                                                <span class="btn_gray_list" style="margin-top: 0px">
                                        <a href="${contextPath}/member/order/detail/${list.orderId}"
                                           class="btn_gray_small js_btn_order_cancel"><span>주문상세</span></a></span>
                                            </div>
                                        </td>
                                        <td class="td_left">
                                            <div class="pick_add_cont">
                                    <span class="pick_add_img">
                                            <img src="${contextPath}/product/display?proimgNo=${list.proimgNo}"
                                                 width="50" class="middle"/>
                                        </span>
                                                <c:if test="${list.orderCnt == 1}">
                                                <div class="pick_add_info">
                                                    <em>${list.proName}</em>
                                                </div>
                                                </c:if>
                                                <c:if test="${list.orderCnt > 1}">
                                                    <div class="pick_add_info">
                                                        <em>${list.proName} 외 ${list.orderCnt - 1}건</em>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td><strong>
                                            <fmt:formatNumber pattern="#,##0" value="${list.orderAmount}"/>
                                        </strong>원
                                        </td>
                                        <td>
                                            <em>
                                                <c:if test="${list.orderState eq '0'}">
                                                    결제완료
                                                </c:if>
                                                <c:if test="${list.orderState eq '1'}">
                                                    배송준비중
                                                </c:if>
                                                <c:if test="${list.orderState eq '2'}">
                                                    배송중
                                                </c:if>
                                                <c:if test="${list.orderState eq '3'}">
                                                    배송완료
                                                </c:if>
                                                <c:if test="${list.orderState eq '4'}">
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
                    <div class="pagination" style="margin-left: 850px;">
                        <ul>
                            <%--<li class="on">--%><span>${paging}</span><%--</li>--%>
                        </ul>
                </div>
            </div>
        </div>
    </div>
</div>


<%--<div class="orderTitle">
    <h1>주문내역</h1>
</div>

<table>
    <thead>
    <tr>
        <td>주문일자<br>주문번호</td>
        <td>이미지</td>
        <td>상품명</td>
        <td>옵션</td>
        <td>수량</td>
        <td>상품구매금액</td>
        <td>주문상태</td>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${orderList}" var="order">
        <tr>
            <td>${order.orderDate}<br><a href="${contextPath}/member/order/detail/${order.orderId}">${order.orderId}</a>
            </td>
            <td>${order.proimgNo}</td>
            <td>${order.proName}</td>
            <td>${order.productSize}</td>
            <td>${order.orderQty}</td>
            <td>${order.orderPrice}</td>
            <td>
                <c:if test="${order.orderState == 0}">주문완료</c:if>
                <c:if test="${order.orderState == 1}">배송준비중</c:if>
                <c:if test="${order.orderState == 2}">배송중</c:if>
                <c:if test="${order.orderState == 3}">배송완료</c:if>
                <c:if test="${order.orderState == 4}">주문취소</c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="7">
            ${paging}
        </td>
    </tr>
    </tfoot>
</table>--%>

</body>
</html>

<%--            <div class="date_check_box">
                <form method="get" name="frmDateSearch">
                    <div class="date_check_list" data-target-name="wDate[]">
                        <button type="button" data-value="30">1개월</button>
                        <button type="button" data-value="90">3개월</button>
                        <button type="button" data-value="180">6개월</button>
                        <button type="button" data-value="270">9개월</button>
                        <button type="button" data-value="365">12개월</button>
                    </div>
                    <div class="date_check_calendar">
                        <input type="text" id="picker2" name="wDate[]" class="anniversary js_datepicker"
                               value="2022-07-04"> ~ <input type="text" name="wDate[]" class="anniversary js_datepicker"
                                                            value="2022-07-11">
                    </div>
                    <button type="submit" class="btn_date_check"><em>조회</em></button>
                </form>
            </div>--%>