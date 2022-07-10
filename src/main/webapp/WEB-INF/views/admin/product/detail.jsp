<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script>
	
	$(function(){
		
		fnData();
		fnRemove();
	})
	
	
	function fnRemove(){
	// 삭제
		// 폼의 서브밋을 활용
		$('#btnRemove').on('click', function(){
			if(confirm('정말 삭제하시겠습니까?')){
				$('#f').attr('action', '${contextPath}/admin/product/removeOne');
				$('#f').submit();
			}
		})
	
	}
	
	
	
	function numCheck(){
		
		var sizeOption = "${product.productQtyDTO.proSize}";
		var qtyOption = "${product.productQtyDTO.proQty}";
		
		if(qtyOption == "0"){
			$("#proSize").not("option[value*= '0']").prop('disabled',true);
			/* $("select option[value*='1']").prop('disabled',true);
			$("select option[value*='2']").prop('disabled',true);
			$("select option[value*='3']").prop('disabled',true);
			$("select option[value*='4']").prop('disabled',true);
			$("select option[value*='5']").prop('disabled',true);
			
			$("select[name=selectedQty]").val(); */
		}
		
	
	}
	
	function fnData(){
		   
		$("#proSize").change(function (e) {
		   var proNo= $("#proNo").val();
		   var proSize= $("#proSize").val();
		   
		   
		   
		     $.ajax({
		          
		          url: '${contextPath}/admin/product/selectProductOptionDetail/',
		          type: 'get',
		          data:"proNo="+proNo+'&proSize='+proSize,
		         dataType: 'json',
		         header: {
		            "Content-Type" : "application/json"
		         },
		         contentType : "application/json",
		          success: function (data) {
		        	 
		        	 let Price = "${product.proPrice}";
		             $('#proQty').text(data.proQty);
		             $('#proDiscount').text(data.proDiscount);
		             // $(".finalPrice").text(Price);
		          },
		          error: function () {
		        	 
		             $('#proQty').text('0'); alert('재고가 없습니다.');
		             // $("select[name=proSize]").attr('selected',true);
		             $('#proDiscount').text('0');
		          }
		     });
		   });

	}
	
	function totalCheck(e2){
		
		let Price = "${product.proPrice}";	// 총 가격
		let Qty = "${product.productQtyDTO.proQty}"; 	
		
		// 가격(총 가격 + 배송비)
		$(".finalPrice").text(Price);
		console.log(Qty);
		
	}
	
	
	
</script>
<style>

@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');

	* {
		box-sizing: border-box;
	} 
		
	.unlink, .link {
		display: inline-block;  /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;  /* 링크 밑줄 없애기 */
		color: gray;
	}
	.link:hover {
		border: 1px solid orange;
		color: limegreen;
	}
	
	 textarea {
	   width: 100%;
	   height: 12em;
	   border: 1px solid #D3D3D3;
	   resize: none;
	   border-radius: 4px;
	 }
	 
	 
	 
	section {
		background-color: #BDBDBD;
		text-align: center;
		font-family: Georgia, "Malgun Gothic", serif;
		
	}
	 
	 
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 2px 2px 2px 2px gray;
	border-radius: 5px;
	border-collapse: collapse;
		margin-left:auto;
    	margin-right:auto;
    	text-align: left;
    	font-size: 20px;
	}
	
	 tr:nth-of-type(1) td:nth-of-type(2) { 
		width: 500px;
		height: 100px;
		text-align: center;
	}
	
	tr:nth-of-type(3) td:nth-of-type(2) { 
		width: 300px;
		height: 100px;
	}
        
      .kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
			text-shadow: 1px 1px 1px gray;
			text-align: center;
	}
	
	
	
</style>

</head>

<body>

	
	<%-- <h5>테스트</h5>
	proNo: ${detail.productQtyDTO.proNo}<br>
	
	proSize: ${detail.productQtyDTO.proSize == '240'}<br>
	proSize: ${detail.productQtyDTO.proSize == '250'}<br>
	proSize: ${detail.productQtyDTO.proSize == '270'}<br>
	
	proSize: ${detail.productQtyDTO.proSize}<br>
	proQty: ${detail.productQtyDTO.proQty}<br>
	proDiscount: ${detail.productQtyDTO.proDiscount}<br>
	${detail.proNo}<br>
	${detail.proName}<br>
	${detail.proPrice}<br>
	imgno: ${detail.productImageDTO.proimgNo} --%>
	
	
	
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		</div>
	</nav>
	
	
	
	<section>
	<br>
	<h3 class="kind">Product Detail</h3><br>
	
	
	
	<form id="f">
	<input type="hidden" value="${product.proNo}" id="proNo" name="proNo" class="proNo"> <!-- 삭제에 이용 -->
	<table border="1">
	<tr>
		<td class="table-dark">썸네일</td>
		<td class="table-secondary"><img alt="이미지${product.productImageDTO.proimgNo}" src="${contextPath}/admin/product/display?proimgNo=${product.productImageDTO.proimgNo}" width="50%"></td>
	</tr>
	<tr>
		<td class="table-dark">상품명</td>
		<td class="table-secondary">${product.proName}</td>
	</tr>
	<tr>
		<td class="table-dark">내용</td>
		<td class="table-secondary">${product.proDetail}</td>
	</tr>
	<tr>
		<td class="table-dark">가격</td>
		<td class="table-secondary"><fmt:formatNumber value="${product.proPrice}" type="number"/>원</td>
		<input type="hidden" value="${product.proPrice}" id="price">
	</tr>
	<tr>
		<td class="table-dark">사이즈선택</td>
		<td ><select class="form-control opt_select proSize" name="proSize" id="proSize">
						<option selected disabled>SIZE를 선택해 주세요</option>
						<option value="240">240</option>
						<option value="250">250</option>
						<option value="260">260</option>
						<option value="270">270</option>
						<option value="280">280</option>
					</select></td>
	</tr>
	
	<tr>
		<td class="table-dark">수량</td>
		<td id="proQty" class="table-secondary"></td>
	</tr>
	<tr>
		<td class="table-dark">할인율</td>
		<td id="proDiscount" class="table-secondary"></td>
	</tr>
	</table>
		<br>
	</form>
	
<div>
	<input type="button" value="제품 수정" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/changeProductPage?proNo=${product.proNo}'"/>
	  &nbsp;&nbsp;&nbsp;
      <input type="button" value="옵션 추가" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/saveProductOption?proNo=${product.proNo}'"/>
       &nbsp;&nbsp;&nbsp;
      <input type="button" value="옵션 수정" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/changeProductOptionPage?proNo=${product.proNo}'"/>
       &nbsp;&nbsp;&nbsp;
     <input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">
     <a href="${contextPath}/admin/product/list">목록으로가기</a>
     
	<br>
	</div>
	<br>
	</section>
	
	
	
	<footer id="footer">
	
		<div id="footer_box">
		
			<%@ include file="../layout/footer.jsp" %>
		</div>
	</footer>


	</body>
	</html>
		
	