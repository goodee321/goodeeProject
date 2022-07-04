<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');
	
	section {
		background-color: #BDBDBD;
		text-align: center;
		font-family: Georgia, "Malgun Gothic", serif;
		}
		
		.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
	}
	
	
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>

	$(function(){
	
		$('#f').on('submit', function(event){
			if($('#qnaTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			} else if($('#qnaTitle').val() == '${qna.qnaTitle}' && $('#qnaContent').val() == '${qna.qnaContent}'){
				alert('수정할 내용이 없습니다.');
				event.preventDefault();
				return;
			}
		})
	

		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/qna/list';
			})
	
	})
</script>
</head>
<body>

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		</div>
	</nav>


	<section>
	<br>
	<h3 class="kind">Qna Modify</h3>
	<br>
	
	
	<form id="f" action="${contextPath}/admin/qna/change" method="post">
		제목: <input type="text" name="qnaTitle" id="qnaTitle" value="${qna.qnaTitle}" required><br><br>
		내용<br> <textarea rows="20" cols="30" name="qnaContent" id="qnaContent" class="form-control col-sm-5" style="margin: 0 auto">${qna.qnaContent}</textarea><br>
		<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
		<button class="btn btn-secondary">수정완료</button>
		<input type="button" value="취소" id="btnList" class="btn btn-secondary">
	</form><br>
	
</section>


<footer id="footer">

	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
</body>
</html>