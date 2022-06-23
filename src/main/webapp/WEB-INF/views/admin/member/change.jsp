<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		background-color: #BDBDBD;
		text-align: center;
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
	
	<h1>수정페이지</h1>


	<form action="${contextPath}/admin/member/change" method="post">
	
	
		<strong>이름</strong><br>
		<input type="text" name="name" id="name" value="${member.name}" placeholder="이름" required><br><br>
		<strong>이메일</strong><br>
		<input type="text" name="email" id="email" value="${member.email}" placeholder="이메일" required><br><br>
		<strong>주소</strong><br>
		<input type="text" name="address" id="address" value="${member.address}" placeholder="주소" required><br><br>
		<strong>상세주소</strong><br>
		<input type="text" name="addrDetail" id="addrDetail" value="${member.addrDetail}" placeholder="상세주소" required><br><br>
		<strong>휴대폰번호</strong><br>
		<input type="text" name="phone" id="phone" value="${member.phone}" placeholder="휴대폰번호" required><br><br>
		<input type="hidden" name="memberNo" value="${member.memberNo}">
		
		
		<button>수정완료</button>
		<input type="button" value="목록" id="btnList">
		
	
	
	</form>



</body>
</html>