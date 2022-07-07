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
	
	<h1><a href="${contextPath}/">로고</a></h1>
	
	
	<!-- 로그인 이전에 보여줄 링크 -->
	<c:if test="${loginMember eq null}">
		<a href="${contextPath}/member/loginPage">로그인페이지</a>
		<a href="${contextPath}/member/agreePage">회원가입페이지</a>
	</c:if>
	
	<!-- 로그인 이후에 보여줄 링크 -->
	<c:if test="${loginMember ne null}">
		<a href="${contextPath}/member/myInfoPage">${loginMember.name}</a> 님 반갑습니다.&nbsp;&nbsp;&nbsp;
		<a href="${contextPath}/member/myOrderPage">나의 주문</a>
		<a href="${contextPath}/member/logout">로그아웃</a>
	</c:if>

		
		<c:if test="${loginMember.id eq 'admin'}">
			<a href="${contextPath}/admin/member/list">관리자페이지</a>
		</c:if>
		


	
	
	<hr>
	
</body>
</html>