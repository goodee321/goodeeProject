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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../../resources/js/jquery-3.6.0.js"></script>





<script>
	
	$(function(){
		
		fnSignIn();
		fnRegExp();
		fnData();
		
	})
	
	
	function fnData(){
	
$("#proSize").change(function () {
	var proNo= $("#proNo").val();
	var proSize= $("#proSize").val();
	
	  $.ajax({
		    
		    url: '${contextPath}/admin/product/changeProductOptionDetail/',
		    type: 'get',
		    data:"proNo="+proNo+'&proSize='+proSize,
			dataType: 'json',
			header: {
				"Content-Type" : "application/json"
			},
			contentType : "application/json",
		    success: function (data) {
		    	$('#proQty').val(data.proQty); alert('수정가능한 사이즈입니다.');
		    	$('#proDiscount').val(data.proDiscount);
		    },
		    error: function () {
		    	$('#proQty').val('0'); alert('등록되지 않은 사이즈입니다.');
		    	$('#proDiscount').val('0');
		    }
	  });
	});
	
	}
	
	function fnSignIn(){
		
		$('#f').on('submit', function(event){
	
			if(discountPass == false){
				alert('할인율을 변경하시기 바랍니다.');
				event.preventDefault();
				return;
			}

			else if($("#proSize").val() == 0){
				alert('사이즈를 선택해주시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			
			else if($('#proQty').val() == 0){
				alert('수량을 확인하시길 바랍니다.');
				event.preventDefault();
				return false;
			}
			else if(qtyPass == false){
				alert('수량은 숫자만 입력가능합니다.');
				event.preventDefault();
				return false;
			}

			return true;
		})
	}
	

			let discountPass = true;
			let qtyPass = true; 
			
	function fnRegExp(){
			let numberRegExp = 	/^[0-9]+$/;
			let decimalRegExp = /^[0][\.]?(\d{1,1})?$/g;	//시작이 0, 중간에 .이 하나, 마지막이 0으로 끝나지 않은 소수
			
			
			
			$('#proDiscount').on('keyup',function(){
			
				if(decimalRegExp.test( $('#proDiscount').val() ) == false){ 
					$('#proDiscountError').text('할인율에는 1이하의 숫자와 소수점 한자리수만 가능합니다.').addClass('dont').removeClass('hidden');
					discountPass = false;
					return;
				}else{
					$('#proDiscountError').addClass('hidden').removeClass('dont');
					discountPass = true;
				}
				
			})
			
				$('#proQty').on('keyup',function(){
			
				if(numberRegExp.test( $('#proQty').val() ) == false){ 
					$('#proQtyError').text('수량에는 숫자만 넣을 수 있습니다..').addClass('dont').removeClass('hidden');
					qtyPass = false;
					return;
				}else{
					$('#proQtyError').addClass('hidden').removeClass('dont');
					qtyPass = true;
				}
				
			})
			
			
			
		}
		
	
	
</script>

<style>


@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');

section {
		background-color: #BDBDBD;
	
		font-family: Georgia, "Malgun Gothic", serif;
		}


.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
			text-shadow: 2px 4px 2px gray;
	}


#f {
  width:70%; 
    margin-left:15%; 
    margin-right:15%;
  height: auto;  /* 높이값 초기화 */
  line-height : normal;  /* line-height 초기화 */
  padding: .8em .5em; /* 원하는 여백 설정, 상하단 여백으로 높이를 조절 */
  font-family: inherit;  /* 폰트 상속 */
  border: 1px solid #999;
  border-radius: 0;  /* iSO 둥근모서리 제거 */
  outline-style: none;  /* 포커스시 발생하는 효과 제거를 원한다면 */
  -webkit-appearance: none;  /* 브라우저별 기본 스타일링 제거 */
  -moz-appearance: none;
  appearance: none;
  display: block;
}

table{
 width:80%; 

   font-family: inherit;  /* 폰트 상속 */
   border-collapse: separate;
  border-spacing: 0 10px;
  
}

.btn{
  width: 50%;  /* 원하는 너비 설정 */ 
  height: auto;  /* 높이값 초기화 */
  line-height : normal;  /* line-height 초기화 */
  margin:auto;
  display: block;
  font-size: large;
  font-weight: bold;  
}

.hidden{
 display: none;
}


.dont {
	color: crimson;
}

	 </style>

</head>
<body>

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		</div>
	</nav>

	
	<section>
	<br>
	<h3 class="kind">Product Option Modify</h3><br>
	
	
	<div class="table">
	<form id="f" class="form-horizontal" role="form"  action="${contextPath}/admin/product/changeProductOption" method="post">
		<table>
		<input type="hidden" name="proNo" id="proNo" value="${product.proNo}" readonly="readonly">
		<tr>	
		<td><strong>제품명</strong></td><td>	<input type="text" name="proName" id="proName" value="${product.proName}" class="form-control" placeholder="제품명" readonly="readonly"></td>
		</tr><tr>
		<td><strong>가격</strong></td><td>	<input type="text" name="proPrice" id="proPrice"class="form-control" value="${product.proPrice}" placeholder="가격" readonly="readonly"></td>
		</tr><tr>
		<td><strong>사이즈</strong></td><td>
		<select class="my-select selectpicker" name="proSize" id="proSize" >
			<option value="0" >사이즈 선택</option>
			<option value="240">240</option>
			<option value="250">250</option>
			<option value="260">260</option>
			<option value="270">270</option>
			<option value="280">280</option>
		</select>
		</td>
		</tr><tr>
		<td><strong>수량</strong></td><td><input type="text" name="proQty" id="proQty"   class="form-control"></td>
		</tr><tr>
		<td></td><td id="proQtyError"></td>
		</tr><tr>
		<td><strong>할인가</strong></td><td>	<input type="text" name="proDiscount" id="proDiscount" class="form-control" placeholder="할인액(0.00)"></td>
		</tr><tr>
		<td></td><td id="proDiscountError"></td>
		</tr>
		</table>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="btn" class="btn btn-secondary">변경 완료</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="${contextPath}/admin/product/list">목록</a><br>
		<br>
	</form>
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
