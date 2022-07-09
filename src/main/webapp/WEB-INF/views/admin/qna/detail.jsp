<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		// 수정하러가기
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/admin/qna/changePage?qnaNo=${qna.qnaNo}';
		})
		// 삭제
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/qna/remove');
				$('#f').submit();
			}
		})
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/qna/list';
		})
	})
</script>
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');
	

	.qnaDetail h1 {
		text-align: center;
		padding-bottom: 10px;
		font-size: xx-large;
	}
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 5px 5px 5px 3px gray;
	border-radius: 5px;
	font-size: 18px;
	}
	
	table td {
		padding: 5px;
		border-top: 1px solid #848484;
	}
	
	tbody td:nth-of-type(1) {
		
		
	}
	
	tr:nth-of-type(2) td:nth-of-type(3) { 
		
		width: 80px;
	}
	
	tr:nth-of-type(2) td:nth-of-type(2) { 
		width: 250px;
	}
	
	tr:nth-of-type(3) td:nth-of-type(2) {
		width: 600px;
		height: 500px;
		vertical-align: top;
	}

	
	
	tfoot td {
		border-bottom: none;
		border-left: none;
		border-right: none;
		background: none;
		text-align: right;
	}
	
	input {
		background-color: #778899;
		border-color: #778899;
		border-radius: 3px;
		color: white;
	}
	
	
	
	.kind {
			font-family: 'Splash', cursive;
		
			text-align: center;
			background-color: #BDBDBD;
			text-shadow: 2px 4px 2px gray;
	}
	
	
	
	section {
		background-color: #BDBDBD;
		text-align: left;
		font-family: Georgia, "Malgun Gothic", serif;
		
	}
	
	form {
		margin: 0 auto;
	}
	

</style>
</head>
<body>
	
	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		
		</div>
			
		</nav>


	<div  class="kind">
	<br>
	<h1>Qna Detail</h1><br>
	</div>
	
		<section>
		<form id="f">

			<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			<table border="1">
				<tbody>
					<tr>
						<td class="table-dark">제목</td>
						<td colspan="3" class="table-secondary">${qna.qnaTitle}</td>
					</tr>
					<tr>
						<td class="table-dark">번호</td>
						<td class="table-secondary">${qna.qnaNo}</td>
						<td class="table-dark">작성자</td>
						<td class="table-secondary">${qna.id}</td>
					</tr>
					<tr>
						<td class="table-dark">내용</td>
						<td colspan="3" class="table-secondary">${qna.qnaContent}</td>
					</tr>
					<tr>
						<td class="table-dark">작성일</td>
						<td colspan="3" class="table-secondary">${qna.qnaDate}</td>
					</tr>
				</tbody>
				
				
			</table>
			
			<br>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			
			
			<input type="button" value="수정" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
								<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">&nbsp;&nbsp;
							
							<input type="button" value="목록" id="btnList" class="btn btn-secondary">
							<br>
		</form>

	</section>
	
	<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
</body>
</html>