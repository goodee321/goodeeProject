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
	
	* {
		box-sizing: border-box;
	}
	
	.changeTitle { text-align: center; }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
	
		$('#f').on('submit', function(event){
			if($('#noticeTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			} else if($('#noticeTitle').val() == '${notice.noticeTitle}' && $('#noticeContent').val() == '${notice.noticeContent}'){
				alert('수정할 내용이 없습니다.');
				event.preventDefault();
				return;
			}
		})
	

		$('#btnList').on('click', function(){
			location.href='${contextPath}/notice/list';
			})
	
	})
</script>
</head>
<body>
	<div class="changeTitle">
	<h3>수정페이지</h3><br>
	</div>
		
		<form id="f" action="${contextPath}/notice/change" method="post">
			제목 <input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" required><br>
			내용 <textarea rows="10" cols="30" name="noticeContent" id="noticeContent">${notice.noticeContent}</textarea><br>
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
			<button>수정완료</button>
			<input type="button" value="목록" id="btnList">
		</form>

</body>
</html>