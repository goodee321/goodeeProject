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


<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
<link rel="stylesheet" href="../resources/css/bootstrap-grid.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>
	
	$(function(){
		fnReviewCheck();
		fnFileCheck();
		fnData();
		imageShow();
		change_qty2();
		fnOrder();
		fnOrders();
		fnAdd();
		fnFileName();
		fnReviewImage();
		/* FnPrice(); */
		
		
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
				alert('제목과 내용은 필수입니다.');
				return false;
			}
		})
		
		// 로그인 + 주문자만 리뷰 작성 가능
		$('.WriteReview').on('click', function(res){
			
			if(${loginMember eq null}){
				
				if (confirm("로그인이 필요한 기능입니다. 로그인 하시겠습니까?")) {
                    // location.href = '${contextPath}/member/loginPage?url=${contextPath}/product/list';
                    location.href = '${contextPath}/member/loginPage?url=${contextPath}/product/detail?proNo=${detail.proNo}';
                    
                } return false; res.preventDefault();
			} else {
				 
				
			}
		})
		
	}
	
	// 첨부파일 사전점검(확장자, 크기)
	function fnFileCheck(){
		$('#ex_filename').on('change', function(){
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
	
	function fnFileName(){
		$(document).ready(function(){
			  var fileTarget = $('.filebox .upload-hidden');

			  fileTarget.on('change', function(){  // 값이 변경되면
			    if(window.FileReader){  // modern browser
			      var filename = $(this)[0].files[0].name;
			    } 
			    else {  // old IE
			      var filename = $(this).val().split('/').pop().split('\\').pop();  // 파일명만 추출
			    }
			    
			    // 추출한 파일명 삽입
			    $(this).siblings('.upload-name').val(filename);
			  });
			}); 
	}
	
	
	/*  // 천단위 콤마 (소수점포함) 
	  function numberWithCommas() {
		 
		  $("#totalPrice").on("keyup", function(){    $(this).val($(this).val().toLocaleString("ko-KR"));});
		 
	  } */
	  
	  
	 // 숫자 타입에서 쓸 수 있도록 format() 함수 추가
	  Number.prototype.format = function(){
	      if(this==0) return 0;

	      var reg = /(^[+-]?\d+)(\d{3})/;
	      var n = (this + '');

	      while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

	      return n;
	  };

	  // 문자열 타입에서 쓸 수 있도록 format() 함수 추가
	  String.prototype.format = function(){
	      var num = parseFloat(this);
	      if( isNaN(num) ) return "0";

	      return num.format();
	  };   
		
	  
	 
	  
	  
	
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
		        	 let proDiscountValue = $('#proDiscount').text();
		             $('#proQty').text(data.proQty);
		             $('.proDiscount').text(data.proDiscount * 100);
		             // $('#proDiscount').text(data.proDiscount);
		             // $(".totalPrice").text(Price) * proDiscountValue;
		             change_qty2();
		             
		          },
		          error: function (err) {
		        	 
		             $('#proQty').text('0'); alert('재고가 없습니다.');
		             // $("select[name=proSize]").attr('disabled',true);
		             
		             
		             $('#proDiscount').text('0');
		          }
		     });
		   });
	}
	
	
	
	function imageShow(){
		 var bigImg = document.getElementById('big_img');
	     var thumbnails = document.getElementsByClassName('thumbnail');
	     
	     for(let i = 0; i < thumbnails.length; i++) {
	         thumbnails[i].onmouseover = function(ev){
	             bigImg.src = this.src;
	         }
	     }
	     
	}
	
	function change_qty2(t) {
		let min_qty = 1;
		let basic_amount = $('#proPrice').val();
		let this_qty = $("#cartQty").val() * 1;
		let proDiscountValue = ($('.proDiscount').text())/100;
		
		
		if (t == "m") {
			this_qty -= 1;
			if (this_qty < min_qty) {
				alert("수량은 1개 이상 입력해 주십시오.");
				return;
			}
		} else if (t == "p") {
			this_qty += 1;
		}
		let show_total_amount = basic_amount * this_qty * (1- proDiscountValue);
		$("#cartQty").val(this_qty);
		$(".totalPrice").text(show_total_amount);
		$("#totalPrice").text(function() {
		    $(this).text(
		        $(this).text().format()
		    );
		});
		$("#totalPrice").change(function() {
		    $(this).text(
		        $(this).text().format()
		    );
		});
		
		$(".totalPrice").on("keyup", function(){    $(this).val($(this).val().toLocaleString("ko-KR"));});
	}
	
	function fnSizeCheck(ev) {
		if ($('#proSize').val() == null) {
			alert('사이즈를 선택해주세요.');
			ev.preventDefault();
			return false;
		}
	}

	function fnAdd() {
		$(".btn-light").on('click', function () {
			let data = {
				productNo: ${detail.proNo},
				cartQty: parseInt($("#cartQty").val()),
                productSize : parseInt($("#proSize").val())
			}
			$.ajax({
				url: "${contextPath}/cart/add",
				type: "post",
				data: data,
				success: function (res) {
					console.log(res)
					if (res > 0) {
						if (confirm("장바구니에 상품을 담았습니다." + "\n" + "장바구니로 이동하시겠습니까?")) {
							location.href = '${contextPath}/cart/list';
						}
					} else if (res == 0) {
						if (confirm("로그인이 필요한 기능입니다. 로그인 할까요?")) {
							location.href = '${contextPath}/member/loginPage?url=${contextPath}/product/detail?proNo=${detail.proNo}';
						}
					} else {
						alert("장바구니 담기에 실패했습니다. 새로고침 후 다시 시도해주세요.");
					}
				}, error:function(request,status,error){
                    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                }
			})
		})
	}

	function fnOrder() {
        $(".btn-dark").on('click', function () {
			fnSizeCheck();
            if(${loginMember == null}){
                if(confirm('로그인이 필요한 기능입니다. 로그인 할까요?')){
                    location.href = '${contextPath}/member/loginPage?url=${contextPath}/product/detail?proNo=${detail.proNo}';
                }
                return false;
            }
            let cartQty = $(".cartQty").val();
            $(".order_form").find("input[name='cartQty']").val(cartQty);
            let proSize = $("#proSize").val();
            $(".order_form").find("input[name='productSize']").val(proSize);
            $(".order_form").submit();
        })
    }

	function fnOrders() {
		$(".testOrder").on('click', function () {
			fnSizeCheck();
			if(${loginMember == null}){
				if(confirm('로그인이 필요한 기능입니다. 로그인 할까요?')){
					location.href = '${contextPath}/member/loginPage?url=${contextPath}/product/detail?proNo=${detail.proNo}';
				}
				return false;
			}
			let cartQty = $(".cartQty").val();
			$(".order_forms").find("input[name='cartQty']").val(cartQty);
			let proSize = $("#proSize").val();
			$(".order_forms").find("input[name='productSize']").val(proSize);
			$(".order_forms").submit();
		})
	}
	
	
	
	function fnReviewImage() {
		//preview image 
	    var imgTarget = $('.preview-image .upload-hidden');

	    imgTarget.on('change', function(){
	        var parent = $(this).parent();
	        parent.children('.upload-display').remove();

	        if(window.FileReader){
	            //image 파일만
	            if (!$(this)[0].files[0].type.match(/image\//)) return;
	            
	            var reader = new FileReader();
	            reader.onload = function(e){
	                var src = e.target.result;
	                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
	            }
	            reader.readAsDataURL($(this)[0].files[0]);
	        }

	        else {
	            $(this)[0].select();
	            $(this)[0].blur();
	            var imgSrc = document.selection.createRange().text;
	            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

	            var img = $(this).siblings('.upload-display').find('img');
	            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
	        }
	    });
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
	 	width:250px; 
	 	height:32px;
	 	border: solid 1.5px #D3D3D3!important;
	 	
	 }
	 
	  table {    
	 	width:100%;     
	 	margin-left:1%;     
	 	margin-right:1%;
	 	text-align: center;
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
	    height: 200px;
	    padding: 1px;
	    box-sizing: border-box;
	    border: solid 1.5px #D3D3D3;
	    border-radius: 5px;
	    font-size: 16px;
	    resize: none;
	} 
	
	
	 
	/* ******************************************************************************************* */
	
	.WriteReview,
	.btn-light,
	.btn-dark
	             {
		
		border-radius: 4px;
	    background: #212529;
	    color: #fff;
	    padding: 7px 45px;
	    display: inline-block;
	    margin-top: 20px;
	    border: solid 2px #212529; 
	    transition: all 0.5s ease-in-out 0s;
	    text-decoration: none;
	    
	    text-transform: uppercase;
		cursor: pointer;
		
	}
	
	 
        
    .WriteReview:hover:hover, 
    .WriteReview:hover:focus,
    .btn-light:hover:hover,
    .btn-light:hover:focus,
    .btn-dark:hover:hover,
    .btn-dark:hover:focus {
    
        background: #DCDBD7;
        background: transparent;
		color: #212529;
		text-decoration: none;
    }
	
	.card {
    margin-bottom: 30px;
	}
	.card {
	    position: relative;
	    display: flex;
	    flex-direction: column;
	    min-width: 0;
	    word-wrap: break-word;
	    background-color: #fff;
	    background-clip: border-box;
	    border: 0 solid transparent;
	    border-radius: 0;
	}
	.card .card-subtitle {
	    font-weight: 300;
	    margin-bottom: 10px;
	    color: #8898aa;
	}
	.table-product.table-striped tbody tr:nth-of-type(odd) {
	    background-color: #f3f8fa!important
	}
	.table-product td{
	    border-top: 0px solid #dee2e6 !important;
	    color: #728299!important;
	}
	
	 .proSize {
  	  Reset Select
	  appearance: none;
	  outline: 0;
	  border: 0;
	  box-shadow: none;
	  /* Personalize */
	  flex: 1;
	  padding: 0 1em;
	  color: #fffafa!important;
	  background-color: #212529!important;
	  cursor: pointer!important;
	} 
	/* Custom Select wrapper */
	.proSize {
	  position: relative;
	  display: flex;
	  width: 205px!important;
	  height: 3em;
	  border-radius: .25em;
	  overflow: hidden;
	}
	/* Arrow */
	.proSize::after {
	  content: '\25BC'!important;
	  position: absolute!important;
	  top: 0;
	  right: 0;
	  padding: 1em;
	  background-color: #fffafa!important;
	  transition: .25s all ease;
	  pointer-events: none;
	}
	/* Transition */
	.proSize:hover::after {
	  color: #fffafa;
	}
		
	.table-product thead {
	
	  background: #DCDCDC;
	  height: 40px;
	}
	
	.modal{
	  position: fixed!important;
	  top: 50%!important;
	  left: 50%!important;
	  transform: translate(-50%, -50%)!important;
	  height: 750px!important;
	}
	
	
	
	/* **************************************************************************** */
	
	.filebox input[type="file"] {
	  position: absolute;
	  width: 1px;
	  height: 1px;
	  padding: 0;
	  margin: -1px;
	  overflow: hidden;
	  clip:rect(0,0,0,0);
	  border: 0;
	}
	
	.filebox label {
	  display: inline-block;
	  padding: .5em .75em;
	  font-size: 20px!important;
	  line-height: 10px;
	  vertical-align: middle;
	  cursor: pointer;
	  border: 1px solid #ebebeb;
	  border-bottom-color: #e2e2e2;
	  border-radius: .25em;
	  color: #fffafa;
      background-color: #5cb85c;
	  border-color: #4cae4c;
	}
	
	/* named upload */
	.filebox .upload-name {
	  display: inline-block;
	  padding: .5em .75em;  /* label의 패딩값과 일치 */
	  font-size: 13px!important;
	  font-family: inherit;
	  line-height: 10px;
	  vertical-align: middle;
	  background-color: #f5f5f5;
	  border: 1px solid #ebebeb;
	  border-bottom-color: #e2e2e2;
	  border-radius: .25em;
	  -webkit-appearance: none; /* 네이티브 외형 감추기 */
	  -moz-appearance: none;
	  appearance: none;
	}
	
	
	/* *************************************************************** */
	
	/* imaged preview */
	.filebox .upload-display {  /* 이미지가 표시될 지역 */
	  margin-bottom: 5px;
	}
	
	@media(min-width: 768px) { 
	  .filebox .upload-display {
	    display: inline-block;
	    margin-right: 5px;
	    margin-bottom: 0;
	  }
	}
	
	.filebox .upload-thumb-wrap {  /* 추가될 이미지를 감싸는 요소 */
	  display: inline-block;
	  width: 75px;
	  padding: 2px;
	  vertical-align: middle;
	  border: 1px solid #ddd;
	  border-radius: 5px;
	  background-color: #fff;
	}
	
	.filebox .upload-display img {  /* 추가될 이미지 */
	  display: block;
	  max-width: 100%;
	  width: 100% \9;
	  height: auto;
	}
	
	.table-responsive {
	
	   overflow-x: hidden!important;
	  
	}
	
	.btn-adminPage {
	
	 color: #fff;
     background-color: #6c757d;
     border-radius: 5px;
     border: none;
     
	
	}
	
	.btn-adminPage:hover:hover,
	.btn-adminPage:hover:focus {
	
	 background-color: #5c636a;
	
	}
	
	
	
</style>

</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	
	
	<!-- 관리자 로그인 시 수정 내역 확인 -->
	<div align="right" style="margin: 1px 220px 1px 1px";>
	   <c:if test="${loginMember.id eq 'admin'}">
	      <input type="button" class="btn-adminPage" value="제품 수정" onclick="location.href='${contextPath}/product/changeProductPage?proNo=${detail.proNo}'"/>
	      <input type="button" class="btn-adminPage" value="옵션 추가" onclick="location.href='${contextPath}/product/saveProductOption?proNo=${detail.proNo}'"/>
	      <input type="button" class="btn-adminPage" value="옵션 수정" onclick="location.href='${contextPath}/product/changeProductOptionPage?proNo=${detail.proNo}'"/>
	      <input type="button" class="btn-adminPage" value="제품 삭제" onclick="location.href='${contextPath}/product/productDelete?proNo=${detail.proNo}'"/>
	   </c:if>
   </div>
   		
	   <div class="container">
	    <div class="card" style="border: none;">
	        <div class="card-body">
	            <h1 class="card-title">${detail.proName}</h1>
	            <h6 class="card-subtitle">NISHOE - SHOES</h6>
	            <div class="row">
	                <div class="col-lg-5 col-md-5 col-sm-6">
	                    <div class="white-box text-center"><img alt="이미지${detail.productImageDTO.proimgNo}" src="${contextPath}/product/display?proimgNo=${detail.productImageDTO.proimgNo}" style="width: 520px; height: 400px" class="img-responsive"></div>
	                </div>
	                <div class="col-lg-7 col-md-7 col-sm-6">
	                    <h4 class="description-title" style="margin:1px 1px 1px 40px;">Product description</h4>
	                    <p style="margin: 10px 1px 1px 40px;">${detail.proDetail}</p>
	                    <h3 class="price-title" style="margin: 20px 1px 1px 40px">
	                        <fmt:formatNumber value="${detail.proPrice}" pattern="#,###"/>원<small class="text-success">[<span id="proDiscount" class="proDiscount" ></span>% OFF</small>]
	                    </h3>
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;재고현황 : <span id="proQty" class="proQty"></span>
						<div class="form-horizontal" style="text-align: left; margin:1px 1px 1px 40px;">
							<label> </label>
							<select class="form-control opt_select proSize" name="proSize" id="proSize">
								<option selected disabled>사이즈를 선택해 주세요</option>
								<option value="240">240</option>
								<option value="250">250</option>
								<option value="260">260</option>
								<option value="270">270</option>
								<option value="280">280</option>
							</select>
						</div>
						<div style="padding: 5px 1px 1px 40px">
						<span class="minus" style="margin:25px 1px 1px 1px; font-size: 28px;"><a href="javascript:change_qty2('m')"><i class="fa-solid fa-square-caret-left" style="color:black;"></i></a></span>
						<input type="text" class="cartQty" id="cartQty" value="1" readonly="readonly" style="margin:1px 1px 20px 1px; width: 30px; height: 30px; font-size: 24px; border: 0; text-align:center;">
	                    <span class="plus" style="margin:25px 1px 1px 1px; font-size: 28px;"><a href="javascript:change_qty2('p')"><i class="fa-solid fa-square-caret-right" style="color:black;"></i></a></span>
						</div>
	                    <h2 style="margin: 5px 1px 1px 438px">
	                    	총 금액: <span class="totalPrice" id="totalPrice"></span>원
	                    </h2>
	                    <button type="button" class="btn btn-light" style="margin:10px 1px 1px 575px; background: #212529; color: #fff; border-radius: 5px;">장바구니 담기</button><br>
	                    <button type="button" id="iamportPayment" class="btn btn-dark" style="margin:10px 1px 1px 610px;">구매하기</button><br>
						<button class="testOrder">..</button>
	                    <input type="hidden" value="${detail.proPrice}" id="proPrice">
	                    
						<form class="order_form" action="${contextPath}/order/orderPage/${loginMember.memberNo}" method="get">
							<input type="hidden" name="productNo" value="${detail.proNo}">
							<input type="hidden" name="cartQty" value="">
				            <input type="hidden" name="productSize" value="">
						</form>
						<form class="order_forms" action="${contextPath}/order/orderPages/${loginMember.memberNo}" method="get">
							<input type="hidden" name="productNo" value="${detail.proNo}">
							<input type="hidden" name="cartQty" value="">
							<input type="hidden" name="productSize" value="">
						</form>
	                </div><br>
	                
	                <div class="col-lg-12 col-md-12 col-sm-12">
	                    <h2 class="box-title mt-5" style="margin: 1px 1px 5px 10px">General Info</h2>
	                    <div class="table-responsive">
	                        <table class="table table-striped table-product">
	                            <tbody>
	                                <tr>
	                                    <td width="390">Brand</td>
	                                    <td>Nishoe</td>
	                                </tr>
	                                <tr>
	                                    <td>Product Number</td>
	                                    <td>${detail.proNo}</td>
	                                </tr>
	                                <tr>
	                                    <td>제품소재</td>
	                                    <td>겉감 : 폴리에스터 100%, 합성수지 / 안감 : 폴리에스터 100% / 창 : 합성고무</td>
	                                </tr>
	                                <tr>
	                                    <td>제품명</td>
	                                    <td>${detail.proName}</td>
	                                </tr>
	                                <tr>
	                                    <td>소비자가</td>
	                                    <td><fmt:formatNumber value="${detail.proPrice}" pattern="#,###"/>원</td>
	                                </tr>
	                                <tr>
	                                    <td>치수</td>
	                                    <td>240 - 280</td>
	                                </tr>
	                                <tr>
	                                    <td>제조국</td>
	                                    <td>중국</td>
	                                </tr>
	                                <tr>
	                                    <td>품질보증기준</td>
	                                    <td>품질보증기간:구입후 6개월</td>
	                                </tr>
	                                
	                            </tbody>
	                        </table>
	                    </div>
	                </div><br>
	                <h2 class="box-title mt-5" style="margin: 1px 1px 5px 10px">제품상세</h2>
	                <div style="height: 200px; margin: 10px 1px 1px 10px;">
		                ${detail.proDetail}<br>
	                </div>
	                <hr>
	                <div class="col-lg-12 col-md-12 col-sm-12">
	                    <h1 class="box-title mt-5" style="margin: 1px 1px 5px 10px">Review</h1>
	                    <p><a href="#reviewModal" rel="modal:open" class="WriteReview" style="margin-left: 1060px;">리뷰 작성하기</a></p>
	                    <div class="table-responsive">
	                        <table class="table table-striped table-product">
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
												<a href="${contextPath}/product/detailReview?reviewNo=${re.reviewNo}" rel="modal:open" style="color: black; font-weight: 600;">${re.reviewContent}</a>
											</td>
											<td>
											    <c:forEach var="reviewStar" items="${ ratingOptions }" varStatus="vs" begin="1" end="${re.reviewStar}"><img src="https://d29fhpw069ctt2.cloudfront.net/icon/image/84580/preview.svg" style="width:30px"></c:forEach>
											</td>
											<td>
												<fmt:formatDate value="${re.reviewDate}" pattern="yyyy-MM-dd"/>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<%-- <td colspan="5">
											${paging}
										</td> --%>
									</tr>
								</tfoot>
	                            
	                        </table>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
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
	             <input type="text" name="reviewTitle" id="reviewTitle" placeholder="제목" class="title col-auto form-control"><br>
	             <textarea name="reviewContent" class="content col-auto form-control" type="text" id="reviewContent"
	                     placeholder="좋은 구매평을 남겨주시면 NiShoe에 큰 힘이 됩니다!"></textarea>	
	             <div class="textLengthWrap" align="right" style="margin-top: 5px;">
	                 <span class="textCount">0자</span>
	                 <span class="textTotal">/200자</span>
	             </div>
	             </div>
	             <div class="filebox preview-image" align="right" style="padding: 15px 10px 1px 0px">
	             	<input class="upload-name" value="파일선택" disabled="disabled">

  					<label for="ex_filename">사진 업로드</label> 
		            <input type="file" id="ex_filename" name="files" class="upload-hidden"><br>			
	             </div>
	             <button class="btn-review" style="background: #212529; color: #fff; margin: 5px 1px 0px 350px; border-radius: 5px;">작성완료</button>
	         </form>
	     	</div>


		   <jsp:include page="../layout/Footer.jsp"></jsp:include>
</body>
</html>