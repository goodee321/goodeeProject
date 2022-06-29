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
			
					<li class="item">
				
						<div class="thumb">
								<a href="${contextPath}/product/detail?proNo=${product.proNo}"><img alt="이미지${product.productImageDTO.proimgNo}" src="${contextPath}/product/display?proimgNo=${product.productImageDTO.proimgNo}" width="100%"></a>
	
						</div>
				
					<span class="title">
						${product.proName}
					</span>
						<!-- 할인가 적용 -->
					<c:if test="${product.productQtyDTO.proDiscount == 0}">
						<div class="price">
							<fmt:formatNumber value="${product.proPrice}" pattern="#,###"/>원
						</div>
					</c:if> 
					<c:if test="${product.productQtyDTO.proDiscount > 0}">
						<div class="price">
								<fmt:formatNumber value="${product.proPrice - product.proPrice * product.productQtyDTO.proDiscount}" pattern="#,###원"/>
							<span class="salePer">
								<fmt:formatNumber value="${product.productQtyDTO.proDiscount}" pattern="##% 할인"/>
							</span>
						</div>
					</c:if> 
							
					</li>
				</c:forEach>
			</ul>
		</div><br><br><br>
		
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

