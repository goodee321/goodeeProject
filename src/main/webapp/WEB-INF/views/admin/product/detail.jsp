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
<script>
	
	$(function(){
		
		fnData();
	})
	
	
	
	
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
	<div class="container" style="width: 70%; margin-bottom:100px;">
		<div class="row"><h1 class="page-header" style="text-align: center; margin-bottom: 50px;"></h1>
			<input type="hidden" value="${product.proNo}" id="proNo" name="proNo" class="proNo">	<!-- 삭제에 이용 -->
			
		</div>
		
		<div class="row" style="float: left; text-align: center; width:50%; position:absolute;">
		<p>
		<br>
		<br>
	  <img alt="이미지${product.productImageDTO.proimgNo}" src="${contextPath}/admin/product/display?proimgNo=${product.productImageDTO.proimgNo}" width="60%" width="200px"><p>
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	  <input type="button" value="제품 수정" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/changeProductPage?proNo=${product.proNo}'"/>
	  &nbsp;&nbsp;&nbsp;
      <input type="button" value="옵션 추가" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/saveProductOption?proNo=${product.proNo}'"/>
       &nbsp;&nbsp;&nbsp;
      <input type="button" value="옵션 수정" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/changeProductOptionPage?proNo=${product.proNo}'"/>
       &nbsp;&nbsp;&nbsp;
      <input type="button" value="제품 삭제" class="btn btn-secondary" onclick="location.href='${contextPath}/admin/product/productDelete?proNo=${product.proNo}'"/>
			<br>
			<br>
			<a href="${contextPath}/admin/product/list">목록으로가기</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</div>

		
		<div class="row productInfo" style="width: 40%; float: right; margin-bottom: 30px; margin-left: 150px; padding-left: 150px;">
			<div class="form-group">
				
				<h5><strong>상품명:</strong> ${product.proName}</h5>
				
				
			</div>
			
			
			<div class="form-group" style="text-align: left;">
			<strong>내용:</strong><p> <textarea rows="20" cols="100" readonly>${product.proDetail}</textarea><p>
				<strong><label>가격 : </label></strong><span>&nbsp;<fmt:formatNumber value="${product.proPrice}" type="number"/></span><span>&nbsp;원</span>
				<input type="hidden" value="${product.proPrice}" id="price"><p>		
			</div>
		
		
			<div class="form-horizontal" style="text-align: left;">
					<strong><label>SIZE</label></strong> :
					<select class="form-control opt_select proSize" name="proSize" id="proSize">
						<option selected disabled>SIZE를 선택해 주세요</option>
						<option value="240">240</option>
						<option value="250">250</option>
						<option value="260">260</option>
						<option value="270">270</option>
						<option value="280">280</option>
					</select>
					<br>
					<strong>수량 :</strong> <span id="proQty" class="proQty"></span><p><br>
				<strong>할인 :</strong> <span id="proDiscount" class="proDiscount" ></span>
				</div>
				</div>
		</div>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</section>
		
		<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
	
</footer>
				
			
				
		
		
	

		
		
</body>
		
</html>

