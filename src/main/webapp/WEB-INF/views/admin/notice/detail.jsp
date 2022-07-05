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

	form {
			padding: 50px;
			text-align: center;
	}

	section {
			background-color: #BDBDBD;
			text-align: center;
			font-family: Georgia, "Malgun Gothic", serif;
	}
	
	strong {
		font-size: 20px;
	}
	
	
	.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
	}
	
	#f {
		font-size: 18px;
	}
		
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		// 수정하러가기
		// location과 파라미터 noticeNo를 활용
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/admin/notice/changePage?noticeNo=${notice.noticeNo}';
		})
		
		// 삭제
		// 폼의 서브밋을 활용
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/notice/removeOne');
				$('#f').submit();
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

<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
			
		</div>
	</nav>
	

	<section>
	<br>
	<h3 class="kind">Notice Detail</h3>

	<form id="f">
	
		<input type="hidden" name="noticeNo" value="${notice.noticeNo}"> <!-- 삭제에서 활용 -->
	
		<strong>공지사항번호:</strong>&nbsp;&nbsp;&nbsp;${notice.noticeNo}<br><hr>
		<strong>제목:</strong>&nbsp;&nbsp;&nbsp;${notice.noticeTitle}<br><hr>
		<strong>내용:</strong><br><textarea rows="10" cols="25" readonly>
								${notice.noticeContent}
							</textarea><br><hr>
		<strong>등록일:</strong>&nbsp;&nbsp;&nbsp;${notice.noticeDate}<br><hr>
		<strong>조회수:</strong>&nbsp;&nbsp;&nbsp;${notice.noticeHit}<br><hr>
		
		
		
		<input type="button" value="수정페이지" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
		<input type="button" value="목록" id="btnList" class="btn btn-secondary"><br><br>
		
	
	</form>
	</section>
	
	<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
	
	
	

</body>
</html>