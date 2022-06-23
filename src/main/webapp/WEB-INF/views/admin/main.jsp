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
</head>
<body>
	
	<h1>관리자페이지</h1>
	
	<a href="${contextPath}/admin/member/list">회원관리메뉴</a>
	
	<a href="${contextPath}/">홈으로</a>
</body>
</html>