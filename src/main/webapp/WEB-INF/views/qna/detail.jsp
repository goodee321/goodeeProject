<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
}

table {
	border-collapse: collapse;
	margin: auto;
}

thead {
	background-color: silver;
}

td {
	padding: 5px;
	border: 1px solid silver;
}

td:nth-of-type(1) {
	background-color: #fbfafa;
}

td:nth-of-type(2) {
	width: 160px;
}

tfoot td {
	border-bottom: none;
	border-left: none;
	border-right: none;
	background-color: none;
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
	<div class="qnaDetail">
		<h1>질문 상세보기</h1>
		<form id="f">

			<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			<table>
				<tbody>
					<tr>
						<td>번호</td>
						<td>${qna.qnaNo}</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${qna.id}</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>${qna.qnaTitle}</td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="30" cols="100" readonly>
									${qna.qnaContent}
								</textarea></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td>${qna.qnaDate}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							<c:if test="${loginMember.id eq qna.id}" > 
								<input type="button" value="수정하러가기" id="btnChangePage">
							</c:if>
							<input type="button" value="목록" id="btnList">
						</td>
					</tr>
				</tfoot>
			</table>

		</form>
	</div>
</body>
</html>