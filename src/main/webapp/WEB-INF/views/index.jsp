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
	
	<a href="${contextPath}/board/savePage">상품보러가기</a>

	<a href="${contextPath}/cart/list">카트</a>
	<a href="${contextPath}/member/order/list">주문</a>

	<h1>MAIN PAGE</h1>
	
	<a href="${contextPath}/notice/list">공지사항 바로가기</a>
	<a href="${contextPath}/notice/savePage">새 공지 작성하기</a>
	<a href="${contextPath}/qna/list">QNA</a>

	<a href="${contextPath}/product/list">상품 리스트</a>
	<a href="${contextPath}/product/saveProductPage">데이터 저장</a>
	
	
</body>
</html>