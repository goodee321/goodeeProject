<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>




<script>
	
	$(function(){
		fnSignIn();
		fnRegExp();
		
	})
	
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
			let decimalRegExp = /^[0]\.{0}\d*$/;	//시작이 0, 중간에 .이 하나, 마지막이 0으로 끝나지 않은 소수
			
			
			
			$('#proDiscount').on('keyup',function(){
			
				if(decimalRegExp.test( $('#proDiscount').val() ) == false){ 
					$('#proDiscountError').text('할인율에는 1이하의 숫자만 입력 가능합니다.').addClass('dont').removeClass('hidden');
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
  color: gray;
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

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<h2>옵션 저장 페이지</h2>
	
	<div class="table">
	<form id="f" class="form-horizontal" role="form"  action="${contextPath}/product/saveProductOptionOk" method="post">
		<table>
		<input type="hidden" name="proNo" value="${detail.proNo}" readonly="readonly">
		<tr>	
		<td>제품명</td><td>	<input type="text" name="proName" id="proName" value="${detail.proName}" class="form-control" placeholder="제품명" readonly="readonly"></td>
		</tr><tr>
		<td>가격</td><td>	<input type="text" name="proPrice" id="proPrice"class="form-control" value="${detail.proPrice}" placeholder="가격" readonly="readonly"></td>
		</tr><tr>
		<td>사이즈</td><td>
		<select class="my-select selectpicker" name="proSize" id="proSize" >
			<option value="0" selected >사이즈 선택</option>
			<option value="240">240</option>
			<option value="250">250</option>
			<option value="260">260</option>
			<option value="270">270</option>
			<option value="280">280</option>
		</select>
		</td>
		</tr><tr>
		<td>수량</td><td><input type="text" name="proQty" id="proQty" value="0"  class="form-control"></td>
		</tr><tr>
		<td></td><td id="proQtyError"></td>
		</tr><tr>
		<td>할인가</td><td>	<input type="text" name="proDiscount" id="proDiscount" class="form-control" placeholder="할인액(0.00)" value="0"></td>
		</tr><tr>
		<td></td><td id="proDiscountError"></td>
		</table>
		
		<button class="btn">작성완료</button>
		<br>
	</form>
	</div>
	
</body>
</html>