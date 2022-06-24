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
	
	<jsp:include page="./layout/header.jsp"></jsp:include>
	
	<h1>MAIN PAGE</h1>
	
	<a href="${contextPath}/notice/list">공지사항</a>
	<a href="${contextPath}/qna/list">QNA</a>
	
	
	
</body>
</html>