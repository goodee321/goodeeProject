<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
		fnEmailCheck();
	})
	
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

	<form action="${contextPath}/member/findId" class="box">
		<div class="shadow p-3 mb-5 bg-body rounded">
			<h3>아이디 찾기</h3>
		</div>
		<div>
			<div class="shadow p-3 mb-5 bg-body rounded">
				<p class="input-group mb-3">
				  <input type="text" class="form-control" id="email" name="email" placeholder="Email" required>
				</p>
					<span id="emailMsg"></span>
					<hr>
			</div>
			<p>
				<button type="submit" id="findIdBtn" class="btn btn-dark">찾기</button>
				<button type="button" onclick="history.back()" class="btn btn-secondary">취소</button>
			</p>
		</div>
	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>