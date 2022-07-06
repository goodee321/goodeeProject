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
			location.href='${contextPath}/admin/member/changePage?memberNo=${member.memberNo}';
		})
		
		// 삭제
		// 폼의 서브밋을 활용
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/member/removeOne');
				$('#f').submit();
			}
		})
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/member/list';
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
	<h3 class="kind">Member Detail</h3>

	<form id="f">
	
		<input type="hidden" name="memberNo" value="${member.memberNo}"> <!-- 삭제에서 활용 -->
	
		<strong>회원번호:</strong>&nbsp;&nbsp;&nbsp;${member.memberNo}<br><hr>
		<strong>ID:</strong>&nbsp;&nbsp;&nbsp;${member.id}<br><hr>
		<strong>이름:</strong>&nbsp;&nbsp;&nbsp;${member.name}<br><hr>
		<strong>E-Mail:</strong>&nbsp;&nbsp;&nbsp;${member.email}<br><hr>
		<strong>우편번호</strong>&nbsp;&nbsp;&nbsp;${member.postcode}<br><hr>
		<strong>주소:</strong>&nbsp;&nbsp;&nbsp;${member.address}<br><hr>
		<strong>상세주소:</strong>&nbsp;&nbsp;&nbsp;${member.addrDetail}<br><hr>
		<strong>참고항목:</strong>&nbsp;&nbsp;&nbsp;${member.extraAddress}<br><hr>
		<strong>휴대폰번호:</strong>&nbsp;&nbsp;&nbsp;${member.phone}<br><hr>
		
		
		<input type="button" value="수정" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
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