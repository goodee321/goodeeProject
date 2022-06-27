<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		fnFileCheck();
		fnSignIn();
	})
	
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


	
	
	function fnSignIn(){
		$('#f').on('submit', function(event){
			if($('#proName').val() == ""){
				alert('제품 명을 입력해주세요.');
				event.preventDefault();
				return false;
			}
			else if($('#proPrice').val() == ""){
				alert('가격을 입력해주세요.');
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
	
</script>
<style>
/*
.table{
	  width: 40%;
    margin: 0 auto;
    display: flex;
    background-color: gray;
    flex-wrap: wrap;
}
#f{
	color: white;
}
*/
 
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


</style>
</head>
<body>
	
	<%--
		파일 첨부 폼 : method="post" enctype="multipart/form-data"
		다중 첨부    : <input type="file" multiple="multiple">
	--%>
	
	<h1>작성화면</h1>
	<div class="table">
	<form id="f" class="form-horizontal" role="form"  action="${contextPath}/product/save" method="post" enctype="multipart/form-data">
		<table>
		<tr>	
		<td>제품명</td><td>	<input type="text" name="proName" id="proName" class="form-control" placeholder="제품명"></td>
		</tr><tr>
		<td>가격</td><td>	<input type="text" name="proPrice" id="proPrice"class="form-control" placeholder="가격"></td>
		</tr><tr>
		<td>수량</td><td>	<input type="text" name="proStock" class="form-control"placeholder="수량"></td>
		</tr><tr>
		<td>내용</td><td>	<textarea class="form-control" name="proDetail" rows="3" placeholder="상세 내용"></textarea>
		</tr><tr>
		<td>할인가</td><td>	<input type="text" name="proDiscount" class="form-control"placeholder="할인액(0.00)" value="0"></td>
		</tr><tr>
		<td>사이즈</td><td>
		<label class="checkbox-inline">
		  <input type="checkbox" name="proSize" id="inlineCheckbox1" value="240"> 240
		</label>
		<label class="checkbox-inline">
		  <input type="checkbox" name="proSize" id="inlineCheckbox2" value="250"> 250
		</label>
		<label class="checkbox-inline">
		  <input type="checkbox" name="proSize" id="inlineCheckbox3" value="260"> 260
		</label>	
		<label class="checkbox-inline">
		  <input type="checkbox" name="proSize" id="inlineCheckbox3" value="270"> 270
		</label>	
		<label class="checkbox-inline">
		  <input type="checkbox" name="proSize" id="inlineCheckbox3" value="280"> 280
		</label>			
		</tr><tr>
		<td>첨부</td>
		</tr>
		</table>
		<input type="file" name="files" id="files" multiple="multiple"><br>
		<button class="btn">작성완료</button>
	</form>
	</div>
</body>
</html>