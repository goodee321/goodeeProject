<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
</head>
<body>

	<form action="${contextPath}/member/findId">
		<h3>아이디 찾기</h3>
		<div>
			<p>
				<label>Email</label>
				<input type="text" id="email" name="email" required>
			</p>
			<p>
				<button type="submit" id="findIdBtn">찾기</button>
				<button type="button" onclick="history.back()">취소</button>
			</p>
		</div>
	</form>

</body>
</html>