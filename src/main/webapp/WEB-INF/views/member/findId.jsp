<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
		$("#loginBtn").click(function(){
			location.href='${contextPath}/member/login';
		})
	})
</script>
<title>아이디 찾기</title>
</head>
<body>
	<div>
		<h3>아이디 찾기 검색결과</h3>
	</div>
	<div>
		<h5>
			${id}
		</h5>
		<p>
			<button type="button" id=loginBtn>Login</button>
			<button type="button" onclick="history.back();">Cancel</button>
		</p>
	</div>
</body>
</html>