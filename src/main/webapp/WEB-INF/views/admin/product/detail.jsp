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
			location.href='${contextPath}/admin/product/changePage?proNo=${product.proNo}';
		})
		
		// 삭제
		// 폼의 서브밋을 활용
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/product/removeOne');
				$('#f').submit();
			}
		})
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/product/list';
		})
	})
</script>
</head>
<body>

	<h2>상품 상세정보</h2>

	<form id="f">
	
		<input type="hidden" name="proNo" value="${product.proNo}"> <!-- 삭제에서 활용 -->
	
		<strong>상품번호:</strong> ${product.proNo}<br><hr>
		<strong>상품명:</strong> ${product.proName}<br><hr>
		<strong>가격:</strong> ${product.proPrice}<br><hr>
		<strong>내용:</strong> ${product.proDetail}<br><hr>
		<strong>할인가:</strong> ${product.productQtyDTO.proDiscount}<br><hr>
		<strong>사이즈</strong> ${product.productQtyDTO.proSize}<br><hr>
		<strong>수량</strong> ${product.productQtyDTO.proQty}<br><hr>
		<c:forEach var="productImage" items="${productImages}">
			
				${productImage.proimgOrigin}<a href="${contextPath}/admin/product/removeProductImage?proimgNo=${productImage.proimgNo}&proNo=${productImage.proNo}"><i class="fa-solid fa-circle-xmark"></i></a>
				<img alt="${productImage.proimgOrigin}" src="${contextPath}/admin/product/display?proimgNo=${productImage.proimgNo}" width="90px">
			
		</c:forEach>
		
		
		
		
		<input type="button" value="목록" id="btnList"><br><br>
		
		
		
	<a href="${contextPath}/admin/product/changeProductPage?proNo=${product.proNo}">제품 수정 </a>
	<a href="${contextPath}/admin/product/saveProductOption?proNo=${product.proNo}">옵션 추가 </a>
	<a href="${contextPath}/admin/product/changeProductOptionPage?proNo=${product.proNo}">옵션 수정 </a> 
	<a href="${contextPath}/admin/product/productDelete?proNo=${product.proNo}">삭제 </a> 
		
	
	</form>
	
	
	
	
	

</body>
</html>