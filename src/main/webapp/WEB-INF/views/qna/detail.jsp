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
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		// 수정하러가기
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/qna/changePage?qnaNo=${qna.qnaNo}';
		})
		// 삭제
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/qna/removeOne');
				$('#f').submit();
			}
		})
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/qna/list';
		})
	})
</script>
<style>
	.qnaDetail h1 {
		text-align: center;
		padding-bottom: 10px;
		font-size: xx-large;
	}
	
	table {
		border-collapse: collapse;
		margin: auto;
	}
	
	table td {
		padding: 5px;
		border-top: 1px solid #848484;
	}
	
	tbody td:nth-of-type(1) {
		background-color: #F2F2F2;
		color: #1C1C1C;
	}
	
	tr:nth-of-type(2) td:nth-of-type(3) { 
		background-color: #F2F2F2; 
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

</style>
</head>
<body>
	
	<jsp:include page="../layout/header.jsp"></jsp:include>

	<div class="qnaDetail">
		<h1>질문 상세보기</h1>
		<form id="f">

			<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td colspan="3">${qna.qnaTitle}</td>
					</tr>
					<tr>
						<td>번호</td>
						<td>${qna.qnaNo}</td>
						<td>작성자</td>
						<td>${qna.id}</td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3">${qna.qnaContent}</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td colspan="3">${qna.qnaDate}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td colspan="3">
							<c:if test="${loginMember.id eq qna.id}">
								<input type="button" value="수정하러가기" id="btnChangePage" class="btn btn-danger"> 
							</c:if>
							<input type="button" value="목록" id="btnList" class="btn btn-info">
						</td>
					</tr>
				</tfoot>
			</table>

		</form>
	</div>
	
	<jsp:include page="../layout/Footer.jsp"></jsp:include>
</body>
</html>