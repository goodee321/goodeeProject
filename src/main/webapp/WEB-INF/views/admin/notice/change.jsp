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
	body {
		background-color: #BDBDBD;
		text-align: center;
		}
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/notice/list';
		})
	})
</script>
</head>
<body>
	
	<h1>수정페이지</h1>


	<form action="${contextPath}/admin/notice/change" method="post">
	
	
		<strong>제목</strong><br>
		<input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" placeholder="제목" required><br><br>
		<strong>내용</strong> 
		<textarea rows="10" cols="30" name="noticeContent" id="noticeContent" placeholder="내용" required>${notice.noticeContent}</textarea><br><br>
		<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
		
		
		
		<button>수정완료</button>
		<input type="button" value="목록" id="btnList">
		
	
	
	</form>



</body>
</html>