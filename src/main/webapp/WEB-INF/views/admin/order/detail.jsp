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

	form {
			padding: 50px;
			text-align: center;
	}

	section {
			background-color: #BDBDBD;
			text-align: center;
			font-family: Georgia, "Malgun Gothic", serif;
	}
	
	strong {
		font-size: 20px;
	}
	
	
	.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
	}
	
	#f {
		font-size: 18px;
	}
		
</style>

<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 수정하러가기
		// location과 파라미터 noticeNo를 활용
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/admin/order/changePage?orderNo=${order.orderNo}';
		})
		
		// 삭제
		// 폼의 서브밋을 활용
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/order/removeOne');
				$('#f').submit();
			}
		})
		
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
	<h3 class="kind">Order Detail</h3>

	<form id="f">
	
		<input type="hidden" name="orderNo" value="${order.orderNo}"> <!-- 삭제에서 활용 -->
	
		<strong>주문번호:</strong>&nbsp;&nbsp;&nbsp;${order.orderNo}<br><hr>
		<strong>회원번호:</strong>&nbsp;&nbsp;&nbsp;${order.memberNo}<br><hr>
		<strong>회원명:</strong>&nbsp;&nbsp;&nbsp;${order.orderName}<br><hr>
		<strong>주문일:</strong>&nbsp;&nbsp;&nbsp;${order.orderDate}<br><hr>
		<strong>휴대폰번호:</strong>&nbsp;&nbsp;&nbsp;${order.orderPhone}<br><hr>
		<strong>주소:</strong>&nbsp;&nbsp;&nbsp;${order.orderAddr}, ${order.addrDetail}<br><hr>
		<strong>총주문금액:</strong>&nbsp;&nbsp;&nbsp;${order.orderAmount}<br><hr>
		<strong>결제수단:</strong>&nbsp;&nbsp;&nbsp;${order.orderPayment}<br><hr>
		<strong>운송장번호:</strong>&nbsp;&nbsp;&nbsp;${order.orderInvoice}<br><hr>
		<strong>배송비:</strong>&nbsp;&nbsp;&nbsp;${order.orderDelivery}<br><hr>
		<strong>주문상태:</strong>&nbsp;&nbsp;&nbsp;
		<c:if test="${order.orderState == 0}">주문완료</c:if>
		<c:if test="${order.orderState == 1}">배송준비중</c:if>
		<c:if test="${order.orderState == 2}">배송중</c:if>
		<c:if test="${order.orderState == 3}">배송완료</c:if>
		<c:if test="${order.orderState == 4}">주문취소</c:if>
		<br><hr>
		
		
		
		
		<input type="button" value="수정" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" id="btnList" class="btn btn-secondary"><br><br>
		
	
	</form>
	</section>
	
	<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
	
	

</body>
</html>