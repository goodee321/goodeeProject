<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.ok {
		color: limegreen;
	}
	.dont {
		color: crimson;
	}
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		fnIdCheck();
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
	
	
	// 아이디 정규식
	let idPass = false;
	function fnIdCheck(){
		$('#id').on('keyup', function(){
			// 정규식 체크하기
			let regId = /^[a-z0-9_-]{4,12}$/;  // 소문자, 숫자, 특수문자(_-) 4~12자 사이
			if(regId.test($('#id').val())==false){
				$('#idMsg').text('아이디는 4~12자리 입니다.').addClass('dont').removeClass('ok');
				idPass = false;
			} else {
				$('#idMsg').text('').addClass('ok').removeClass('dont');
				idPass = true;
			}
		})
	}


</script>
</head>
<body>

	<form action="${contextPath}/member/findPw">
		<h3>비밀번호 찾기</h3>
		<div>
			<p>
				<label>ID</label>
				<input type="text" name="id" id="id" required>
				<span id="idMsg"></span>
			</p>
			<p>
				<label>EMAIL</label>
				<input type="text" name="email" id="email" required>
				<span id="emailMsg"></span>
			</p>
			<p>
				<label>PHONE</label>
				<input type="text" name="phone" id="phone" required>
				<span id="phoneMsg"></span>
			</p>
			<p>
				<button type="button" onclick="history.back()">취소</button>
				<button type="submit">다음</button>
			</p>
		</div>
	</form>

</body>
</html>