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

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		
		</div>
	</nav>

	<section>
	<br>
	<h3 class="kind">Notice Modify</h3><br>


	<form action="${contextPath}/admin/notice/change" method="post">
	
	
		<strong>제목:</strong>
		<input type="text" name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle}" placeholder="제목" required style="margin: 0 auto"><br><br>
		<strong>내용:</strong><br><br>
		<textarea  rows="5" name="noticeContent" id="noticeContent" placeholder="내용" required class="form-control col-sm-5" style="margin: 0 auto">${notice.noticeContent}</textarea><br><br>
		<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
		
		
		
		<button class="btn btn-secondary">수정완료</button>&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" id="btnList" class="btn btn-secondary">
		
	
	
	</form>
	<br>
	</section>

<footer id="footer">

	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>


</body>
</html>