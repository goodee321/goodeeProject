<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
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
		$("#loginBtn").click(function(){
			location.href='${contextPath}/member/loginPage';
		})
	})
</script>
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<form class="box">
		<div>
			<h3 class="shadow p-3 mb-5 bg-body rounded">아이디 검색결과</h3>
		</div>
		<div>
			<h5 class="shadow p-3 mb-5 bg-body rounded">
				ID : ${id}<br><hr>
			</h5>
			<p>
				<button type="button" id=loginBtn class="btn btn-dark">로그인</button>
				<button type="button" onclick="history.back();" class="btn btn-secondary">뒤로가기</button>
			</p>
		</div>
	</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>