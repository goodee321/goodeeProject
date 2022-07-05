<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script>
	
	$(function(){
		
		
		
	})
	
	
	
	
</script>
<style>
	

</style>

</head>
<body>

	<h2>수정 페이지</h2>
	
	
	<form id="f" action="${contextPath}/product/reviewChange" method="post" enctype="multipart/form-data">
	
		${reviewbyno.reviewTitle}<br>
		${reviewbyno.reviewContent}<br>
		${loginMember.memberNo}<br>
		<hr>
		<input type="hidden" name="reviewNo" value="${reviewbyno.reviewNo}">
		<input type="hidden" name="memberNo" value="${loginMember.memberNo}"><br>
		제목 <input type="text" name="title" id="title" value="${reviewbyno.reviewTitle}"><br>
		내용 <input type="text" name="content" id="content" value="${reviewbyno.reviewContent}"><br>
		별점 <input type="text" name="star" id="star" value="${reviewbyno.reviewStar}"><br>
		
		<input type="file" name="files" id="files" multiple="multiple"><br><br>
		<button>수정완료</button>
		
	</form>
	
	<c:forEach var="fileAttach" items="${fileAttaches}">
		<div><img alt="${fileAttach.riOrigin}" src="${contextPath}/product/reviewDisplay?riNo=${fileAttach.riNo}" width="80%"></div>
	</c:forEach>
	
</body>
</html>

