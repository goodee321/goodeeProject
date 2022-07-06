<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');
	
	section {
		background-color: #BDBDBD;
		text-align: center;
		font-family: Georgia, "Malgun Gothic", serif;
		}
		.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
	}
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/order/list';
		})
	})
</script>
</head>
<body>
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		</div>
	</nav>
	
	<section>
	<br>
	<h3 class="kind">Order Modify</h3>


	<form action="${contextPath}/admin/order/change" method="post">
	
	
		<strong>회원번호</strong><br>
		<input type="text" name="orderNo" id="orderNo" value="${order.orderNo}" placeholder="회원번호" readonly="readonly"><br><br>
		<strong>회원명</strong><br>
		<input type="text" name="orderName" id="orderName" value="${order.orderName}" placeholder="회원명" readonly="readonly"><br><br>
		<strong>휴대폰번호</strong><br>
		<input type="text" name="orderPhone" id="orderPhone" value="${order.orderPhone}" placeholder="휴대폰번호"><br><br>
		<strong>주소</strong><br>
		<input type="text" name="orderAddr" id="orderAddr" value="${order.orderAddr}" placeholder="주소" required><br><br>
		<strong>상세주소</strong><br>
		<input type="text" name="addrDetail" id="addrDetail" value="${order.addrDetail}" placeholder="상세주소" required><br><br>
		<strong>운송장번호</strong><br>
		<input type="text" name="orderInvoice" id="orderInvoice" value="${order.orderInvoice}" placeholder="운송장번호" required><br><br>
		<strong>배송비</strong><br>
		<input type="text" name="orderDelivery" id="orderDelivery" value="${order.orderDelivery}" placeholder="배송비" required><br><br>
		<strong>주문상태</strong><br>
		<input type="text" name="orderState" id="orderState" value="${order.orderState}" placeholder="주문상태" readonly="readonly"><br><br>
		(0:주문완료, 1:배송준비중, 2:배송중 3:배송완료, 4:주문취소)<br>
		<input type="hidden" name="orderNo" value="${order.orderNo}">
		
		
		<button class="btn btn-secondary">수정완료</button>&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" id="btnList" class="btn btn-secondary">
		
	

	</form>
		<br>
</section>


<footer id="footer">

	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>


</body>
</html>