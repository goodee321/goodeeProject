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
			text-shadow: 2px 4px 2px gray;
	}
	
	#f {
		font-size: 18px;
	}
	
	
	table {
		border-collapse: collapse;
		margin: auto;
		text-align: center;
	}
	
	table td {
		padding: 10px;
		border-top: 1px solid #848484;
	}
	
	form {
		padding-top: 10px;
	}
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 5px 5px 5px 3px gray;
	border-radius: 5px;
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
	
		
	
		<table border="1">
			<tbody>
			<tr>
				<td class="table-dark">주문번호</td>
				<td class="table-secondary">${order.orderNo}</td>
			</tr>
			<tr>
				<td class="table-dark">회원번호</td>
				<td class="table-secondary">${order.memberNo}</td>
			</tr>
			<tr>
				<td class="table-dark">회원명</td>
				<td class="table-secondary">${order.orderName}</td>
			</tr>
			
			<tr>
				<td class="table-dark">주문일</td>
				<td class="table-secondary">${order.orderDate}</td>
			</tr>
			<tr>
				<td class="table-dark">주소</td>
				<td class="table-secondary">${order.orderAddr}, ${order.addrDetail}</td>
			</tr>
			<tr>
				<td class="table-dark">총주문금액</td>
				<td class="table-secondary">${order.orderAmount}</td>
			</tr>
			<tr>
				<td class="table-dark">운송장번호</td>
				<td class="table-secondary">${order.orderInvoice}</td>
			</tr>
			<tr>
				<td class="table-dark">배송비</td>
				<td class="table-secondary">${order.orderDelivery}</td>
				<input type="hidden" name="orderNo" value="${order.orderNo}"> <!-- 삭제에서 활용 -->
			</tr>
			<tr>
				<td class="table-dark">주문번호</td>
				<td class="table-secondary"><c:if test="${order.orderState == 0}">주문완료</c:if>
		<c:if test="${order.orderState == 1}">배송준비중</c:if>
		<c:if test="${order.orderState == 2}">배송중</c:if>
		<c:if test="${order.orderState == 3}">배송완료</c:if>
		<c:if test="${order.orderState == 4}">주문취소</c:if></td>
			</tr>
			</tbody>
			
			
		</table>
		
		<br>
		<div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="수정" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" id="btnList" class="btn btn-secondary"><br><br>
		</div>
	
	</form>
	</section>
	
	<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
	
	

</body>
</html>