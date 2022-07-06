<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<jsp:include page="../../layout/header.jsp"></jsp:include>
${orderList}<br>
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
            <td>${order.orderDate}<br><a href="${contextPath}/member/order/detail/${order.orderId}">${order.orderId}</a></td>
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
</table>

</body>
</html>
