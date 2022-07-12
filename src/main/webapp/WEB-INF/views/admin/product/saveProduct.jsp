<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script>
	
	$(function(){
		fnSignIn();
		fnFileCheck();
		fnRegExp();
	})
	
	function fnSignIn(){
		$('#f').on('submit', function(event){
			
			
			if($('#proName').val() == ""){
				alert('제품 명을 입력해주세요.');
				event.preventDefault();
				return false;
			}
		
			else if($('#proPrice').val() == 0){
				alert('가격을 입력해주세요.');
				event.preventDefault();
				return false;
			}
			
			else if(pricePass == false){
				alert('가격을 변경하시기 바랍니다.');
				event.preventDefault();
				return false;
			}
			
			else if(discountPass == false){
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

			else if($('#files').val() == ""){
				alert('이미지를 반드시 1개 이상 업로드해야 합니다.');
				event.preventDefault();
				return false;
			}
			return true;
		})
	}
	
	
	// 첨부파일 사전점검(확장자, 크기)
	function fnFileCheck(){
		$('#files').on('change', function(){
			// 첨부 규칙
			let regExt = /(.*)\.(jpg|png|gif)$/;
			let maxSize = 1024 * 1024 * 10;  // 하나당 최대 크기
			// 첨부 가져오기
			let files = $(this)[0].files;
			// 각 첨부의 순회
			for(let i = 0; i < files.length; i++){
				// 확장자 체크
				if(regExt.test(files[i].name) == false){
					alert('이미지만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일이 모두 없어짐
					return;
				}
				// 크기 체크
				if(files[i].size > maxSize){
					alert('10MB 이하의 파일만 첨부할 수 있습니다.');
					$(this).val('');  // 첨부된 파일이 모두 없어짐
					return;
				}
			}
		})
	}

			let pricePass = false;
			let discountPass = false;
			let qtyPass = false; 
			
	function fnRegExp(){
			let numberRegExp = 	/^[0-9]+$/;
			let decimalRegExp = /^[0][\.]?(\d{1,1})?$/g;	// 소수점 한자리까지
			
			
			$('#proPrice').on('keyup', function(){
				if(numberRegExp.test( $('#proPrice').val() ) == false){
					$('#proPriceError').text('가격에는 숫자만 입력 가능합니다.').addClass('dont').removeClass('hidden');
					pricePass = false;
					return;
				}else{
					$('#proPriceError').addClass('hidden').removeClass('dont');
					pricePass = true;
				}
				
			})
			
			
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

section {
		background-color: #BDBDBD;
		
		font-family: Georgia, "Malgun Gothic", serif;
		}
		
		
		footer {
		background-color: #BDBDBD;
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
	
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		</div>
	</nav>
	
	<section>
	<br>
	<h3 class="kind">Product Insert</h3><br>
	
	
	
	<div class="table">
	<form id="f" class="form-horizontal" role="form"  action="${contextPath}/admin/product/saveProduct" method="post" enctype="multipart/form-data">
		<table>
		<tr>	
		<td><strong>제품명</strong></td><td>	<input type="text" name="proName" id="proName" class="form-control" placeholder="제품명"></td>
		</tr><tr>
		<td><strong>가격</strong></td><td>	<input type="text" name="proPrice" id="proPrice"class="form-control" value="0" placeholder="가격"></td>
		</tr><tr>
		<td></td><td id="proPriceError"></td>
		</tr><tr>
		<td><strong>내용</strong></td><td>	<textarea class="form-control" name="proDetail" rows="3" placeholder="상세 내용"></textarea>
		</tr><tr>
		<td><strong>할인가</strong></td><td>	<input type="text" name="proDiscount" id="proDiscount" class="form-control" placeholder="할인액(0.00)" value="0"></td>
		</tr><tr>
		<td></td><td id="proDiscountError"></td>
		</tr><tr>
		<td><strong>사이즈</strong></td><td>
		<select name="proSize" id="proSize">
			<option value="0" selected >사이즈 선택</option>
			<option value="240">240</option>
			<option value="250">250</option>
			<option value="260">260</option>
			<option value="270">270</option>
			<option value="280">280</option>
		</select>
		</td>
		</tr><tr>
		<td><strong>수량</strong></td><td><input type="text" name="proQty" id="proQty" value="0"></td>
		</tr><tr>
		<td></td><td id="proQtyError"></td>
		</tr><tr>
		<td><strong>첨부</strong></td><td><input type="file" name="files" id="files" multiple="multiple"></td>
		</tr>
		</table>
		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="btn" class="btn btn-secondary">작성완료</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		
		<a href="${contextPath}/admin/product/list">목록으로</a><br>
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