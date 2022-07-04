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
			location.href='${contextPath}/admin/member/list';
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
	<h3 class="kind">Member Modify</h3>


	<form action="${contextPath}/admin/member/change" method="post">
	
	
		<strong>이름</strong><br>
		<input type="text" name="name" id="name" value="${member.name}" placeholder="이름"><br><br>
		<strong>E-Mail</strong><br>
		<input type="text" name="email" id="email" value="${member.email}" placeholder="E-Mail" required><br><br>
		<strong>주소</strong><br>
		<input type="text" name="address" id="address" value="${member.address}" placeholder="주소" required><br><br>
		<strong>상세주소</strong><br>
		<input type="text" name="addrDetail" id="addrDetail" value="${member.addrDetail}" placeholder="상세주소" required><br><br>
		<strong>휴대폰번호</strong><br>
		<input type="text" name="phone" id="phone" value="${member.phone}" placeholder="휴대폰번호" required><br><br>
		<input type="hidden" name="memberNo" value="${member.memberNo}">
		
		
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