<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.ok {
		color: limegreen;
	}
	.dont {
		color: crimson;
	}
	.box {
		margin: 0 auto;
		text-align: center;
		width: 300px;
		padding-top: 200px;
	}
	.form-control {
		margin: 0 auto;
	}
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		fnEmailCheck();
		fnPhoneCheck();
	})

	// 휴대폰번호 정규식
	let phonePass = false;
	function fnPhoneCheck(){
		// 휴대폰 번호 정규식 검사
		$('#phone').on('keyup', function(){
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^[0-9]{3})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") );
			let regPhone = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;  // 이거만 넣으면 하이픈 직접 넣기
			if(regPhone.test($('#phone').val())==false){
				$('#phoneMsg').text('휴대폰 번호를 입력하세요.').addClass('dont').removeClass('ok');
				phonePass = false;
			} else {
				$('#phoneMsg').text('').addClass('ok').removeClass('dont');
				phonePass = true;
			}
		})
	}
	
	
	// 이메일 정규식
	let emailPass = false;
	function fnEmailCheck(){
		$('#email').on('keyup', function(){
			// 정규식 체크하기
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/;
			if(regEmail.test($('#email').val())==false){
				$('#emailMsg').text('이메일 형식을 지켜주세요.').addClass('dont').removeClass('ok');
				emailPass = false;
			} else {
				$('#emailMsg').text('').addClass('ok').removeClass('dont');
				emailPass = true;
			}
		})
	}


</script>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>

	<form action="/member/beforeReSign" method="post" class="box">
		<h3 class="shadow p-3 mb-5 bg-body rounded">재가입 조건</h3>
		<div class="shadow p-3 mb-5 bg-body rounded">
			<p class="input-group mb-3">
				<input type="text" class="form-control" name="name" id="name" placeholder="Name" required>
			</p>
				<span></span>
			<p class="input-group mb-3">
				<input type="text" class="form-control" name="email" id="email" placeholder="Email" required>
			</p>
				<span id="emailMsg"></span>
			<p class="input-group mb-3">
				<input type="text" class="form-control" name="phone" id="phone" placeholder="Phone" required>
			</p>
				<span id="phoneMsg"></span>
				<hr>
		</div>
		<div>
				<button type="submit" class="btn btn-dark">다음</button>
				<button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
		</div>
	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
