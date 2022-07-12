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
		fnPwCheck();
		fnPwConfirm();
		fnModifyPw();
	})
	
	// 비밀번호 정규식
	let pwPass = false;
	function fnPwCheck(){
		// 비밀번호 정규식 검사
		$('#pw').on('keyup', function(){
			let regPw = /^[a-zA-Z0-9!@#$%^&*]{8,15}$/;  // 대소문자, 숫자, 특수문자!@#$%^&* 3~15자 사이
			let pwValid = /[a-z]/.test($('#pw').val()) +  // 소문자 포함이면 1
		    /[A-Z]/.test($('#pw').val()) +  // 대문자 포함이면 1
		    /[0-9]/.test($('#pw').val()) +  // 숫자 포함이면 1
		    /[!@#$%^&*]/.test($('#pw').val());  // 특수문자 포함이면 1
			if(regPw.test($('#pw').val()) && pwValid >= 3){
				$('#pwMsg').text('').addClass('ok').removeClass('dont');
				pwPass = true;
			} else {
				$('#pwMsg').text('8~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요.').addClass('dont').removeClass('ok');
				pwPass = false;
			}
		})
	}
		
	// 비밀번호 입력확인
	let rePwPass = false;
	function fnPwConfirm(){
		$('#pwConfirm').on('keyup', function(){
			if($('#pwConfirm').val() != '' && $('#pw').val() != $('#pwConfirm').val()){
				$('#pwConfirmMsg').text('비밀번호를 확인하세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#pwConfirmMsg').text('');
				rePwPass = true;
			}
		})
	}
	
	// 비밀번호 변경
	function fnModifyPw(){
		$('#f').on('submit', function(event){
			if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			return true;
		})
		
	}
	
</script>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>

	<form id="f" action="/member/modifyPw" method="post" class="box">
		<h3 class="shadow p-3 mb-5 bg-body rounded">비밀번호 변경</h3>
		<div>
			<p>
				<input type="hidden" name="memberNo" id="memberNo" value="${memberNo}">
			</p>
			<div class="shadow p-3 mb-5 bg-body rounded">
				<p class="input-group mb-3">
					<input type="password" class="form-control" name="pw" id="pw" placeholder="신규 비밀번호" required>
				</p>
					<span id="pwMsg"></span>
				<p class="input-group mb-3">
					<input type="password" class="form-control" id="pwConfirm" placeholder="비밀번호 확인" required>
				</p>
					<span id="pwConfirmMsg"></span><hr>
			</div>
			<p>
				<button class="btn btn-dark">비밀번호변경</button>
			</p><hr>
		</div>
	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
