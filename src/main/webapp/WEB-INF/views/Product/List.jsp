<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	
	<hr>
	
	<table border="1">
	
		<tbody>
			<c:forEach items="${products}" var="product" >
				<tr>
					<!-- 1번째 이미지 썸네일로 추가 -->
					<td><a href="${contextPath}/product/list?pNo=${product.pNo}"></a></td>
					<td><a href="${contextPath}/product/list?pNo=${product.pNo}">${product.pName}</a></td>
					<td><a href="${contextPath}/product/list?pNo=${product.pNo}">${product.pPrice}</a></td>					
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3">
					${paging}
				</td>
			</tr>
		</tfoot>
	</table>
	
</body>
</html>