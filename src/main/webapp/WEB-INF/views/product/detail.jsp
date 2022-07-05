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
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	$(function(){
		fnReviewCheck();
		fnFileCheck();
		fnData();
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
			
			
			if ($('#reviewContent').val() == '' || $('#reviewTitle').val() == '') {    
				alert('내용과 제목은 필수입니다.');
				return false;
			}
		})
		
		// 로그인 + 주문자만 리뷰 작성 가능
		$('.WriteReview').on('click', function(res){
			
			if(${loginMember eq null}){
				
				if (confirm("로그인이 필요한 기능입니다. 로그인 하시겠습니까?")) {
                    location.href = '${contextPath}/member/loginPage?url=${contextPath}/Product/detailPage';
                    
                } return false; res.preventDefault();
			} else {
				 
				
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
	
	function numCheck(){
		
		var sizeOption = "${detail.productQtyDTO.proSize}";
		var qtyOption = "${detail.productQtyDTO.proQty}";
		
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
		          
		          url: '${contextPath}/product/selectProductOptionDetail/',
		          type: 'get',
		          data:"proNo="+proNo+'&proSize='+proSize,
		         dataType: 'json',
		         header: {
		            "Content-Type" : "application/json"
		         },
		         contentType : "application/json",
		          success: function (data) {
		        	 
		        	 let Price = "${detail.proPrice}";
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
		
		let Price = "${detail.proPrice}";	// 총 가격
		let Qty = "${detail.productQtyDTO.proQty}"; 	
		
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
	 
	 #reviewTitle{
	 	border-radius:4px; 
	 	border:1px solid #D3D3D3; 
	 	width:250px; 
	 	height:32px;
	 	
	 }
	 
	  table {    
	 	width:70%;     
	 	margin-left:15%;     
	 	margin-right:15%;
	 } 
	 
	 
	/* ************************************************************************************************************************* */
	/* **************************************************[별점 CSS]************************************************************* */
	/* ************************************************************************************************************************* */
	
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
	 
	/* ******************************************************************************************* */
	
	.WriteReview {
		
		position: relative;
        text-decoration: none;
        font-size: 1.5em;
        color: #111d4a;
		
	}
	
	 .WriteReview::after {
            content: " ";
            position: absolute;
            z-index: -1;
            height: 100%;
            width: 110%;
            left: -5%;
            bottom: 0;
            border-radius: 5px;
            border-bottom: 2px solid #9D9D9C;
            transition: all 0.5s ease;
        }
        
        .WriteReview:hover:after {
            background: #DCDBD7;
        }
	
	
	
</style>

</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
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
	
	
	<!-- 관리자 로그인 시 수정 내역 확인 -->
   <c:if test="${loginMember.id eq 'admin'}">
      <input type="button" value="제품 수정" onclick="location.href='${contextPath}/product/changeProductPage?proNo=${detail.proNo}'"/>
      <input type="button" value="옵션 추가" onclick="location.href='${contextPath}/product/saveProductOption?proNo=${detail.proNo}'"/>
      <input type="button" value="옵션 수정" onclick="location.href='${contextPath}/product/changeProductOptionPage?proNo=${detail.proNo}'"/>
      <input type="button" value="제품 삭제" onclick="location.href='${contextPath}/product/productDelete?proNo=${detail.proNo}'"/>
   </c:if>
	
	
	
	<div class="container" style="width: 70%; margin-bottom:100px;">
		<div class="row"><h1 class="page-header" style="text-align: center; margin-bottom: 50px;"></h1>
			<input type="hidden" value="${detail.proNo}" id="proNo" name="proNo" class="proNo">
		</div>
		<div class="row" style="float: left; text-align: center; width:35%; position:absolute;">
			<img alt="이미지${detail.productImageDTO.proimgNo}" src="${contextPath}/product/display?proimgNo=${detail.productImageDTO.proimgNo}" width="100%" width="400px">
		</div>

		<div class="row productInfo" style="width: 40%; float: right; margin-bottom: 30px; margin-left: 150px; padding-left: 150px;">
			<div class="form-group" style="text-align: center;">
				<h3 class="page-header"><span>${detail.proName}</span><br><small>${detail.proDetail}</small></h3>
			</div>
			<div>
				<img src="https://d29fhpw069ctt2.cloudfront.net/icon/image/84580/preview.svg" style="width:30px">
			</div>
			<div class="form-group" style="text-align: left;">
				<label>가격 : </label><span>&nbsp;<fmt:formatNumber value="${detail.proPrice}" type="number"/></span><span>&nbsp;원</span>
				<input type="hidden" value="${detail.proPrice}" id="price">
			</div>
			<div class="form-group" style="text-align: left;">
				<label>배송비 : </label><span>&nbsp;2500원</span>
				<p>도서산간지역 배송비 5000원 / 3만원 이상 결제시 무료배송?</p>
			</div>
			구매 가능수량 : <p id="proQty" class="proQty"></p><br>
			할인 : <p id="proDiscount" class="proDiscount" ></p><br>
				<div class="form-horizontal" style="text-align: left;">
					<label>사이즈 : </label>
					<select class="form-control opt_select proSize" name="proSize" id="proSize">
						<option selected disabled>사이즈를 선택해 주세요</option>
						<option value="240">240</option>
						<option value="250">250</option>
						<option value="260">260</option>
						<option value="270">270</option>
						<option value="280">280</option>
					</select>
				</div>
			<div class="form-horizontal" style="text-align: left;">
				<label>수량 : </label>
				<%-- <select class="form-control" id="selectedQty">
				<c:forEach begin="1" end="10" var="count">
					<option>${count}</option></c:forEach>
				</select> --%>
				<select class="form-control opt_select" name="selectedQty" id="selectedQty">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				</select>
				
			</div>	
			<div class="sumAmount" name="sumAmount" id="price">
				총 금액: <span class="finalPrice">원</span></div>
			<div class="row">
				<div class="selected_option" style="text-align: right;">
				</div>
				<div style="text-align: center;">
					<button class="btn btn-default">주문하기</button>
					<button class="btn btn-cart">장바구니</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container">
		
		<div class="row" style="margin: 50px 0;">
			<h1 class="jumbotron">
				<div class="container">
				</div>
			</h1>
		</div>
		<div class="row about_product" style="text-align: center; margin-top: 350px; position:relative;">
			<h1 class="page-header" style="margin-bottom: 50px;">상품 상세</h1>
		</div>
		<div class="row reviews" style="text-align: center; margin: 80px 0;">
			<h1 class="page-header" style="margin-bottom: 50px;">상품 후기</h1>
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<!-- 리뷰 리스트 -->
						<table border="1" style="text-align: center;">
							<thead>
								<tr>
									<td>제목</td>
									<td>내용</td>
									<td>별점</td>
									<td>작성일</td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${reviews}" var="re" varStatus="vs">
										<input type="hidden" name="proNo" id="proNo" value="${re.proNo}">
										<input type="hidden" name="reviewNo" id="reviewNo" value="${re.reviewNo}">
									<tr>
										<td>${re.reviewTitle}</td>
										<td>
											<a href="${contextPath}/product/detailReview?reviewNo=${re.reviewNo}" rel="modal:open">${re.reviewContent}</a>
										</td>
										<td>
										    <c:forEach var="reviewStar" items="${ ratingOptions }" varStatus="vs" begin="1" end="${ re.reviewStar }"><img src="https://d29fhpw069ctt2.cloudfront.net/icon/image/84580/preview.svg" style="width:30px"></c:forEach>
										</td>
										<td>
											<fmt:formatDate value="${re.reviewDate}" pattern="yyyy-MM-dd E HH:mm:ss"/>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5">
										${paging}
									</td>
								</tr>
							</tfoot>
						</table>
						<!-- 추후에는 주문자만 작성 가능하게 -->
						<%-- <c:if test="${loginMember ne null}"> --%>
							<p><a href="#reviewModal" rel="modal:open" class="WriteReview">리뷰 작성하기</a></p>
						<%-- </c:if> --%>
					</div>
					
					<div class="panel-body">
						  
					</div>
				</div>
		</div>
	</div>
	<!-- ************************************************************************************************************************* -->
	<!-- ********************************************** [제품 후기 작성] ************************************************************** -->
	<!-- ************************************************************************************************************************* -->
	<!-- 리뷰 작성 모달창 -->
	
	<div id="reviewModal" class="modal">
	<h3>리뷰</h3>
		<form id="f" action="${contextPath}/product/detailReviewSave" method="post" enctype="multipart/form-data">
			<input type="hidden" name="proNo" id="proNo" value="${detail.proNo}">
			<input type="hidden" name="memberNo" id="memberNo" value="${loginMember.memberNo}">
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
				<input type="radio" name="reviewStar" value="1" id="rate5" class="starClass" checked><label
					for="rate5">★</label>
			</fieldset>
			<div class="form-group col-12" >
			<input type="text" name="reviewTitle" id="reviewTitle" placeholder="제목"><br>
			  <textarea name="reviewContent" class="col-auto form-control" type="text" id="reviewContent"
					  placeholder="좋은 구매평을 남겨주시면 NiShoe에 큰 힘이 됩니다!"></textarea>	
			  <div class="textLengthWrap">
			    <p class="textCount">0자</p>
			    <p class="textTotal">/200자</p>
			  </div>
			</div>
			<input type="file" id="files" name="files" multiple="multiple"><br>			
			<button>작성완료</button>
		</form>
	</div>
    
	
	
	
	<p><a href="${contextPath}/product/list">상품 리스트</a></p>
	
	
</body>
</html>

