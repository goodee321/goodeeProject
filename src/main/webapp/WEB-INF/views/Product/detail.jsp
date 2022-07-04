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
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	$(function(){
		fnReviewCheck();
		fnFileCheck();
	})
	
	function fnReviewCheck(){
		
		$('#reviewContent').keyup(function (e) {
			let content = $(this).val();
		    
		    // 글자수 세기
		    if (content.length == 0 || content == '') {
		    	$('.textCount').text('0자');
		    } else {
		    	$('.textCount').text(content.length + '자');
		    }
		    
		    // 글자수 제한
		    if (content.length > 200) {
		    	// 200자 부터는 타이핑 되지 않도록
		        $(this).val($(this).val().substring(0, 200));
		        // 200자 넘으면 알림창 뜨도록
		        alert('리뷰는 200자까지 입력 가능합니다.');
		    };
		});
		
		$('#f').on('submit', function(e2){
			if ($('#reviewContent').val() == '' || $('.starClass').val() == 0) {    // input type:radio 로 ㅊ ㅓ리?
				alert('5자 이상 입력해주세요');
				return false;
			}
		})
		
		
		
	}
	
	// 첨부파일 사전점검(확장자, 크기)
	function fnFileCheck(){
		$('#files').on('change', function(){
			// 첨부 규칙
			let regExt = /(.*)\.(jpg|png|gif|JPG|PNG|GIF)$/;
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
	 
	 #reviewTitle{
	 	border-radius:4px; 
	 	border:1px solid #D3D3D3; 
	 	width:250px; 
	 	height:32px;
	 	
	 }
	 
	 
	  /*===================================== 별점 CSS ================================================================*/
	#f fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
	}
	#f fieldset legend{
	    text-align: right;
	}
	#f input[type=radio]{
	    display: none;
	}
	#f label{
	    font-size: 2em;
	    color: transparent;
	    text-shadow: 0 0 0 #f0f0f0;
	}
	#f label:hover{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#f label:hover ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#f input[type=radio]:checked ~ label{
	    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
	}
	#reviewContent {
	    width: 100%;
	    height: 150px;
	    padding: 10px;
	    box-sizing: border-box;
	    border: solid 1.5px #D3D3D3;
	    border-radius: 5px;
	    font-size: 16px;
	    resize: none;
	}
	 

</style>

</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<h2>제품 상세 TEST</h2>
	
	번호 ${detail.proNo}
	상품명 ${detail.proName}
	제품가격 ${detail.proPrice}
	이미지번호 ${detail.productImageDTO.proimgNo}
	디테일 ${detail.proDetail}

	<hr>
	<a href="${contextPath}/product/changeProductPage?proNo=${detail.proNo}">제품 수정 </a>
	<a href="${contextPath}/product/saveProductOption?proNo=${detail.proNo}">옵션 추가 </a>
	<a href="${contextPath}/product/changeProductOptionPage?proNo=${detail.proNo}">옵션 수정 </a> 
	<a href="${contextPath}/product/productDelete?proNo=${detail.proNo}">삭제 </a> 
	
	
	
	<div class="">
    	<h2>상품후기</h2>
	</div>
	
	<!-- 리뷰 작성 모달창 -->
	<p><a href="#reviewModal" rel="modal:open">리뷰 작성하기</a></p>
	<div id="reviewModal" class="modal">
	<h3>리뷰</h3>
		<form id="f" action="${contextPath}/product/detailReviewSave" method="post" enctype="multipart/form-data">
			<input type="hidden" name="proNo" id="proNo" value="${detail.proNo}">
			<input type="text" name="memberNo" placeholder="mno"><br>
			<input type="text" name="reviewTitle" id="reviewTitle" placeholder="제목"><br>
			
			<!-- <input type="text" name="reviewStar" id="reviewStar" placeholder="별점"><br> -->
			<fieldset id="filedset">
				<span class="text-bold">별점을 선택해주세요</span>
				<input type="radio" name="reviewStar" value="5" id="rate1" class="starClass"><label
					for="rate1">★</label>
				<input type="radio" name="reviewStar" value="4" id="rate2" class="starClass"><label
					for="rate2">★</label>
				<input type="radio" name="reviewStar" value="3" id="rate3" class="starClass"><label
					for="rate3">★</label>
				<input type="radio" name="reviewStar" value="2" id="rate4" class="starClass"><label
					for="rate4">★</label>
				<input type="radio" name="reviewStar" value="1" id="rate5" class="starClass"><label
					for="rate5">★</label>
			</fieldset>
			<div class="form-group col-12" >
			  <div class="textLengthWrap">
			    <p class="textCount">0자</p>
			    <p class="textTotal">/200자</p>
			  </div>
			  <textarea name="reviewContent" class="col-auto form-control" type="text" id="reviewContent"
					  placeholder="좋은 구매평을 남겨주시면 NiShoe에 큰 힘이 됩니다!"></textarea>	
			</div>
			<!-- <textarea name="reviewContent" id="textarea" style="font-size:15px"></textarea><br> -->
			<input type="file" id="files" name="files" multiple="multiple"><br>			
			<button>작성완료</button>
		</form>
	</div>
	
	<!-- 리뷰 리스트 -->
	<table border="1">
		<thead>
			<tr>
				<td>번호</td>
				<td>제품번호</td>
				<td>제목</td>
				<td>내용</td>
				<td>별점</td>
				<td>작성일</td>
			</tr>
		</thead>
		<tbody>
			
				<c:forEach items="${reviews}" var="re" varStatus="vs">
					<tr>
						<td>${startNo - vs.index}</td>
						<td>${re.proNo}</td>
						<td>${re.reviewTitle}</td>
						<td>${re.reviewContent}</td>
						<td>${re.reviewStar}</td>
						<%-- <td>
							<c:forEach var="star" items="${ reviewStar }" varStatus="vs" begin="1" end="${star.reviewStar}">★</c:forEach>
						</td> --%>
						<td>${re.reviewDate}</td>
					</tr>
				</c:forEach>
			
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					${paging}
				</td>
			</tr>
		</tfoot>
	</table>
	
	
	<p><a href="${contextPath}/product/list">상품 리스트</a></p>
	
	
</body>
</html>
