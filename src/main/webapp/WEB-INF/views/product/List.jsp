<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	
	$(document).ready(function(){
		
		fnFind();
	});

	
	// 검색 함수
	function fnFind(){
		$('#f').submit(function(event){
			if ($('#column').val() == '') {
				alert('검색 카테고리를 선택하세요.');
				$('#column').focus();
				event.preventDefault();
				return false;
			}
			return true;
			
		});
	}
	
</script>
<style>
#f{
	text-align: center;
	align-items: center;
    justify-content: center;
     letter-spacing: 2px;
}
h3{
    font-size: 20px;
    text-align: center;
    padding: 10px 0;
    margin-top: 20px;
}
.product_list{
    width: 60%;
    margin: 0 auto;
    display: flex;
    flex-wrap: wrap;
}
.item{
    display: flex;
    flex-direction: column;
   	flex: none;
	flex-basis: 33.33%;
    margin-top: 20px;
    padding: 0 5px;
    box-sizing: border-box;
}
.thumb{
    flex: auto;
    background-color: #dcdcdf;
}
.image{
    vertical-align: top;
}
 .product_list, .title{
    flex: none;
    flex-basis: 20px;
    min-height: 0;
    margin-top: 10px;
}
.title{
	color : #666666;
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 5px;
}
.price{
	flex: none;
	 min-height: 0px;
    font-size: 	15px;
    font-weight: bold;
    color : #666666;
}

.paging {
  display: flex;
  align-items: center;
  justify-content: center;
     letter-spacing: 2px;
}

.priceX{
	color: red;
}

.salePer{
	color: #ff4040;
	font-size: 12px;

}
.stockLack{
	color: white;
	font-size: 8px;
	background-color: red;
	width 100px;
	height 10px;
	padding 10px;
	text-align: center;
	

}
</style>

</head>
<body>
	
	

	
	<br>
	
		<div class="ui_box">
			<h3>제품 목록</h3>
			<ul class="product_list">
			<c:forEach var="product" items="${products}">
			<div class="productCount">
			 </div>
				<li class="item">
			
					<div class="thumb">
							<a href="${contextPath}/product/detail?proNo=${product.proNo}"><img alt="이미지${product.productImageDTO.proimgNo}" src="${contextPath}/product/display?proimgNo=${product.productImageDTO.proimgNo}" width="100%"></a>
				 			<!--  <a href="${contextPath}/product/detail?proNo=${product.proNo}">	<img class="image"  src="../resources/gallery/s_${product.productImageDTO.proimgName}" class="productImage" width="100%" height="100%" alt="이미지${product.proNo}"></a>-->
	<!--				<a href="${contextPath}/product/detail?proNo=${product.proNo}">	<img class="image" src="data:image/jpeg;base64,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" width="100%" height="100%"></a>
			!-->
					</div>
		
					<c:if test="${product.proStock <= 3}">
						<div class="stockLack">
						품절임박
						</div>
						</c:if>
					<span class="title">
						${product.proName}
					</span>
					<!-- 할인가 적용 -->
					<c:if test="${product.proDiscount == 0}">
					<div class="price">
						<fmt:formatNumber value="${product.proPrice}" pattern="#,###"/>원
					</div>
					</c:if> 
					<c:if test="${product.proDiscount > 0}">
					<div class="price">
						<fmt:formatNumber value="${product.proPrice - product.proPrice * product.proDiscount}" pattern="#,###원"/>
					<span class="salePer">
						<fmt:formatNumber value="${product.proDiscount}" pattern="##% 할인"/>
					</span>
					</div>
						</c:if> 
						${product.proSize}
				</li>
			</c:forEach>
			</ul>
		</div>
		<br><br><br>
				<form id="f" method="get" action="${contextPath}/product/find">
				<select name="column" id="column">
					<option value="">:::선택:::</option>
					<option value="PRO_NAME" selected="selected">NAME</option>
					<option value="PRO_SIZE">SIZE</option>
				</select>
				<input type="text" name="query" id="query">
				<button>검색하기</button>
			</form>
	

		<!-- 페이지 꾸며야 함 -->
		<div class="paging">
					${paging}
	
		</div>
</body>
</html>

