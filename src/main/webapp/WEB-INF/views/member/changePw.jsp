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
		fnNowPwCheck();
		fnPwCheck();
		fnPwConfirm();
		fnModifyPw();
	})
	
	// 현재 비밀번호가 맞는지 확인
	let nowPwPass = false;
	function fnNowPwCheck(){
		$('#nowPw').on('keyup', function(){
			$.ajax({
				url: '${contextPath}/member/checkNowPw',
				type: 'post',
				data: 'nowPw=' + $('#nowPw').val(),
				dataType: 'json',
				success: function(obj){
					nowPwPass = obj.res;
				}
			})			
		})
	}
	
	// 비밀번호 정규식
	let pwPass = false;
	function fnPwCheck(){
		// 비밀번호 정규식 검사
		$('#pw').on('keyup', function(){
			let regPw = /^[a-zA-Z0-9!@#$%^&*]{3,15}$/;  // 대소문자, 숫자, 특수문자!@#$%^&* 3~15자 사이
			let pwValid = /[a-z]/.test($('#pw').val()) +  // 소문자 포함이면 1
		    /[A-Z]/.test($('#pw').val()) +  // 대문자 포함이면 1
		    /[0-9]/.test($('#pw').val()) +  // 숫자 포함이면 1
		    /[!@#$%^&*]/.test($('#pw').val());  // 특수문자 포함이면 1
			if(regPw.test($('#pw').val()) && pwValid >= 3){
				$('#pwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			} else {
				$('#pwMsg').text('3~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요.').addClass('dont').removeClass('ok');
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
			if(nowPwPass == false){
				alert('현재 비밀번호가 올바르지 않습니다.');
				event.preventDefault();
				return false;
			}
			if(pwPass == false || rePwPass == false){
				alert('비밀번호 입력을 확인하세요.');
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

	<h3>비밀번호 변경 페이지입니다.</h3>
	
	<br><br>
	
	<form id="f" action="${contextPath}/member/modifyPw" method="post">
	
		<input type="hidden" name="memberNo" id="memberNo" value="${loginMember.memberNo}">
		<input type="password" id="nowPw" placeholder="현재 비밀번호"><br>
		<span id="nowPwMsg"></span><br>
		<input type="password" name="pw" id="pw" placeholder="신규 비밀번호">
		<span id="pwMsg"></span><br>
		<input type="password" id="pwConfirm" placeholder="비밀번호 확인">
		<span id="pwConfirmMsg"></span><br>
		<button>비밀번호변경</button>
		
	</form>

</body>
</html>