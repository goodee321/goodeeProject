<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.0.js"></script>
<script>

</script>
</head>
<body>

	
	<h1>MAIN PAGE</h1>
	
	<a href="${contextPath}/notice/list">공지사항 바로가기</a>
	<a href="${contextPath}/notice/savePage">새 공지 작성하기</a>
	<a href="${contextPath}/qna/list">QNA</a>


</body>
</html>