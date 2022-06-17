<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="..resources/js/jquery-3.6.0.js"></script>
</head>
<body>



	<div class="productList">
	      <c:if test="${listcheck != 'empty'}">
	                    	<table class="goods_table" border="1">
	                    		<thead>
	                    			<tr>
	                    				<td class="th_column_5">썸네일</td>
										<td class="th_column_1">상품 번호</td>
	                    				<td class="th_column_2">상품명</td>
	                    				<td class="th_column_3">가격</td>
	                    				<td class="th_column_4">카테고리</td>
	                    	
	                    			</tr>
	                    		</thead>	
	                    		<c:forEach items="${list}" var="list">
	                    		<tr>
	                    			<td><c:out value="${list.bookId}"></c:out></td>
	                    			<td><c:out value="${list.bookName}"></c:out></td>
	                    			<td><c:out value="${list.authorName}"></c:out></td>
	                    			<td><c:out value="${list.cateName}"></c:out></td>
	                    			<td><c:out value="${list.bookStock}"></c:out></td>
	                    			
	                    		</tr>
	                    		</c:forEach>
	                    	</table>
	                    </c:if>
	
	</div>





</body>
</html>