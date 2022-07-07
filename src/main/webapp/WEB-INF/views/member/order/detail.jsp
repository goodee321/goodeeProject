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
    ${detailList}
주문정보
<table>
    <tr>
        <td>주문번호</td>
        <td></td>
    </tr>
    <tr>
        <td>주문일자</td>
        <td></td>
    </tr>
    <tr>
        <td>주문자</td>
        <td></td>
    </tr>
    <tr>
        <td>주문상태</td>
        <td></td>
    </tr>
</table>

결제정보
<table>
    <tr>
        <td>총 주문금액</td>
        <td></td>
    </tr>
    <tr>
        <td>총 할인금액</td>
        <td></td>
    </tr>
    <tr>
        <td>총 결제금액</td>
        <td></td>
    </tr>
    <tr>
        <td>결제수단</td>
        <td></td>
    </tr>
</table>

주문 상품 정보
<table>
    <tr>
        <td>이미지</td>
        <td>상품명</td>
        <td>옵션</td>
        <td>수량</td>
        <td>상품구매금액</td>
    </tr>
    <c:forEach items="${detailList}" var="detail">
    <tr>
        <td>${detail.proimgNo}</td>
        <td><a href="${contextPath}/product/detail?proNo=${detail.productNo}">${detail.proName}</a></td>
        <td>${detail.productSize}</td>
        <td>${detail.orderQty}</td>
        <td>${detail.proPrice}</td>
    </tr>
    </c:forEach>
</table>

배송지정보

<table>
    <tr>
        <td>받으시는 분</td>
        <td></td>
    </tr>
    <tr>
        <td>우편번호</td>
        <td></td>
    </tr>
    <tr>
        <td>주소</td>
        <td></td>
    </tr>
    <tr>
        <td>휴대전화</td>
        <td></td>
    </tr>
    <tr>
        <td>배송메시지</td>
        <td></td>
    </tr>
</table>

<a href="${contextPath}/member/order/list">주문목록보기</a>

</body>
</html>
