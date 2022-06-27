<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/js/jquery-3.6.0.js"></script>

<script>
	
$(function(){
	
	// 서브밋
	$('#f').on('submit', function(event){
		if($('#title').val() == ''){
			alert("제목은 필수입니다.");
			$('#title').focus();
			event.preventDefault();
			return;
		}
	})
	
	// 목록
	$('#btnList').on('click', function(){
		location.href='${contextPath}/admin/notice/list';
	})
	
})
	
</script>
</head>
<body>

	<h1>공지사항 작성화면</h1>
	
	<form id="f" action="${contextPath}/admin/notice/save" method="post">
		제목 <input type="text" name="noticeTitle" id="noticeTitle"><br>
		내용<br>
		<textarea rows="3" cols="30" name="noticeContent" id="noticeContent" placeholder="내용" required></textarea><br><br>
		<button>작성완료</button>
		<input type="button" value="목록" id="btnList">
	</form>

</body>
</html>