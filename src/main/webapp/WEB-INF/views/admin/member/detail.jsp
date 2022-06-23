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

	form {
			padding: 50px;
			text-align: center;
	}

	body {
			background-color: #BDBDBD;
			text-align: center;
	}
		
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 수정하러가기
		// location과 파라미터 noticeNo를 활용
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/admin/member/changePage?memberNo=${member.memberNo}';
		})
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/member/list';
		})
	})
</script>
</head>
<body>

	<h2>회원상세보기</h2>

	<form id="f">
	
		<input type="hidden" name="memberNo" value="${member.memberNo}"> <!-- 삭제에서 활용 -->
	
		<strong>회원번호:</strong> ${member.memberNo}<br>
		<strong>ID:</strong> ${member.id}<br>
		<strong>이름:</strong> ${member.name}<br>
		<strong>email:</strong> ${member.email}<br>
		<strong>주소:</strong> ${member.address}<br>
		<strong>상세주소:</strong> ${member.addrDetail}<br>
		<strong>휴대폰번호:</strong> ${member.phone}<br>
		
		
		<input type="button" value="수정페이지" id="btnChangePage">
		<input type="button" value="목록" id="btnList"><br><br>
	
	</form>
	
	
	
	
	

</body>
</html>