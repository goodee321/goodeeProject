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
		location.href='${contextPath}/qna/list';
	})
	
})
	
</script>
<style>
	* {
		box-sizing: border-box;
	}
	
	h1 {
		text-align: center;
	}
	
	.regit {
		text-align: center;
	}
	
</style>
</head>
<body>

	<h1>Q&A 작성화면</h1>
	<div class="regit">
		<form id="f" action="${contextPath}/qna/save" method="post">
			제목 <input type="text" name="title" id="title"><br>
			작성자 <input type="text" name="id" value="${loginMember.id}" readonly="readonly"><br>
			<br>
			<textarea rows="7" cols="50" name="content" placeholder="문의 확인 후 빠르게 답변해드리겠습니다."></textarea><br><br>
			<button>작성완료</button>
			<input type="button" value="목록" id="btnList">
		</form>
	</div>

</body>
</html>