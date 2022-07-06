<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
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
			let decimalRegExp = /^[0]\.{0}\d*$/;	//시작이 0, 중간에 .이 하나, 마지막이 0으로 끝나지 않은 소수
			
			
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
	<h3 class="kind">Product Modify</h3><br>
	
	
	
	
	<div class="table">
	<form id="f" class="form-horizontal" role="form"  action="${contextPath}/admin/product/changeProduct" method="post" enctype="multipart/form-data">
				
				<c:forEach var="productImage" items="${productImages}" begin="1">	
					<td>${productImage.proimgOrigin}<a href="${contextPath}/admin/product/removeProductImage?proimgNo=${productImage.proimgNo}&proNo=${productImage.proNo}"><i class="fa-solid fa-circle-xmark"></i></a></td>		
					<label>
					<td><img alt="${productImage.proimgOrigin}" src="${contextPath}/admin/product/display?proimgNo=${productImage.proimgNo}" width="90px"></td>
					</label>
				</c:forEach>
				<br>
			<input type="hidden" name="proNo" value="${product.proNo}">
			<tr>	
			<td><strong>제품명</strong><p><p><p></td><td>	<input type="text" name="proName" id="proName" class="form-control" placeholder="제품명" value="${product.proName}"></td>
			</tr><tr><p>
			<td><strong>가격</strong></td><td><p>	<input type="text" name="proPrice" id="proPrice"class="form-control" value="${product.proPrice}" placeholder="가격"></td>
			</tr><tr>
			<td></td><td id="proPriceError"></td>
			</tr><tr><p>
			<td><strong>내용</strong><p></td><td>	<textarea class="form-control" name="proDetail"  "${product.proDetail}"rows="3" placeholder="상세 내용"></textarea>
			</tr><tr><p>
			<td>첨부</td><td><input type="file" name="files" id="files" multiple="multiple"></td>
			
			
			
			
			
			<button id="btn" class="btn btn-secondary">수정완료</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="${contextPath}/admin/product/list">목록으로가기</a><br>
	</form>
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