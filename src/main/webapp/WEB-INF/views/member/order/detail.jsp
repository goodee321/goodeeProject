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
</head>
<body>
    <jsp:include page="../../layout/header.jsp"></jsp:include>

    주문정보
    <c:forEach items="${memberInfo}" var="member">
        <table>
            <tr>
                <td>주문번호</td>
                <td>${member.orderId}</td>
            </tr>
            <tr>
                <td>주문일자</td>
                <td>${member.orderDate}</td>
            </tr>
            <tr>
                <td>주문자</td>
                <td>${member.orderName}</td>
            </tr>
            <tr>
                <td>주문상태</td>
                <td>${member.orderState}</td>
            </tr>
        </table>
        <hr>

        결제정보
        <table>
            <tr>
                <td>총 주문금액</td>
                <c:set var="total" value="0"/>
                <c:forEach var="detail" items="${products}" varStatus="status">
                    <c:set var="total" value="${total + (detail.proPrice * detail.orderQty)}"/>
                </c:forEach>
                <td><fmt:formatNumber value="${total}" pattern="#,##0"/>원</td>
            </tr>
            <tr>
                <td>총 할인금액</td>
                <c:set var="total" value="0"/>
                <c:forEach var="detail" items="${products}" varStatus="status">
                    <c:set var="total" value="${total + (detail.proPrice * (detail.proDiscount) * detail.orderQty)}"/>
                </c:forEach>
                <td><fmt:formatNumber value="${total}" pattern="#,##0"/>원</td>
            </tr>
            <tr>
                <td>총 결제금액</td>
                <td><fmt:formatNumber value="${member.orderAmount}" pattern="#,##0"/>원</td>
            </tr>
            <tr>
                <td>결제수단</td>
                <td>${member.orderPayment}</td>
            </tr>
        </table>
    </c:forEach>
    <hr>

    주문 상품 정보
    <table>
        <tr>
            <td>이미지</td>
            <td>상품명</td>
            <td>옵션</td>
            <td>수량</td>
            <td>상품구매금액</td>
        </tr>
        <c:forEach items="${products}" var="detail">
            <tr>
                <td>
                    <a href="${contextPath}/product/detail?proNo=${detail.productNo}">
                        <img
                                alt="이미지${detail.proimgNo}"
                                src="${contextPath}/product/display?proimgNo=${detail.proimgNo}"
                                width="100px" height="100px"
                        >
                    </a>
                </td>
                <td><a href="${contextPath}/product/detail?proNo=${detail.productNo}">${detail.proName}</a></td>
                <td>${detail.productSize}</td>
                <td>${detail.orderQty}</td>
                <td><fmt:formatNumber value="${detail.proPrice}" pattern="#,##0"/>원</td>
            </tr>
        </c:forEach>
    </table>
    <hr>

    배송지정보
    <c:forEach items="${memberInfo}" var="member">
        <table>
            <tr>
                <td>받으시는 분</td>
                <td>${member.orderName}</td>
            </tr>
            <tr>
                <td>우편번호</td>
                <td>${member.postcode}</td>
            </tr>
            <tr>
                <td>주소</td>
                <td>${member.orderAddr}, ${member.addrDetail}</td>
            </tr>
            <tr>
                <td>휴대전화</td>
                <td>${member.orderPhone}</td>
            </tr>
            <tr>
                <td>배송메시지</td>
                <td>${member.orderMessage}</td>
            </tr>
        </table>
    </c:forEach>
    <hr>

    <a href="${contextPath}/member/order/list">주문목록보기</a>

</body>
</html>
