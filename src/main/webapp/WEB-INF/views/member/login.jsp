<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>

  .box {
  	margin: 0 auto;
  	width: 400px;
  	padding-top: 150px;
  }
</style>

    
<!-- jquery -->
<script src="../resources/js/jquery-3.6.0.js"></script>
<!-- jquery-cookie -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
	
	/* 페이지 로드 이벤트 */
	$(function(){
		fnLogin();
		fnDisplayRememberId();
	})
	
	/* 함수 */
	
	
	
	// 1. 로그인
	function fnLogin(){
		$('#ffff').on('submit', function(event){
			// 아이디, 비밀번호 입력 확인
			if($('#id').val() == '' || $('#pw').val() == ''){
				alert('아이디와 비밀번호를 모두 입력하세요.');
				event.preventDefault();
				return false;
			}
			// 아이디 저장 체크 확인
			// 아이디 저장은 쿠키를 이용한다.
			if($('#rememberId').is(':checked')){
				$.cookie('rememberId', $('#id').val());	// 입력한 id를 쿠키에 rememberId로 저장한다.
			} else {
				$.cookie('rememberId', '');
			}
			// 서브밋 수행
			return true;
			
		})
	}
	
	// 2. 아이디 저장을 체크하면 쿠키에 저장된 아이디를 보여줌
	function fnDisplayRememberId(){
		let rememberId = $.cookie('rememberId');
		if(rememberId != ''){
			$('#id').val(rememberId);
			$('#rememberId').prop('checked', true);
		} else {
			$('#id').val('');
			$('#rememberId').prop('checked', false);
		}
	}
	
</script>
</head>
<body class="text-center">
    
    <jsp:include page="../layout/header.jsp"></jsp:include>
    
<main class="form-signin">
  <form id="ffff" action="${contextPath}/member/login" method="post" class="box">
  	<div class="shadow p-3 mb-5 bg-body rounded">
	    <img class="mb-4" src="/docs/5.1/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
	    <h1 class="h3 mb-3 fw-normal">NiShoe</h1>
	    
	    <input type="hidden" name="url" value="${url}">
	
	    <div class="form-floating">
	      <input type="text" class="form-control" name="id" id="id" placeholder="아이디" required>
	      <label for="id">ID</label>
	    </div>
	    <div class="form-floating">
	      <input type="password" class="form-control" name="pw" id="pw" placeholder="비밀번호" required>
	      <label for="pw">PW</label>
	    </div>
		<br>
	    <div class="checkbox mb-3">
	      <label>
	        <input type="checkbox" value="remember-me"><span class="fw-bold">아이디 저장</span>
	      </label>
	    </div>
    </div>
    <button class="w-100 btn btn-lg btn-dark" type="submit">로그인</button>
    <p class="mt-5 mb-3 text-muted"></p>
  	<hr>
  </form>
	<div>
		<a href="${contextPath}/member/findIdForm" class="btn btn-secondary">아이디 찾기</a> | 
		<a href="${contextPath}/member/findPwForm" class="btn btn-secondary">비밀번호 찾기</a>
	</div>
</main>


	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>