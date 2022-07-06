<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../resources/js/jquery-3.6.0.js"></script>
<style>

	h3 { text-align: center; }
	
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
</style>
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
			location.href='${contextPath}/qna/list';
			})
	
	})
</script>
</head>
<body>

	<h3>수정페이지</h3><br>
	
	<form id="f" action="${contextPath}/qna/change" method="post">
		<table>
			<tbody>
				<tr>
					<td>제목</td>
					<td><input type="text" name="qnaTitle" id="qnaTitle" value="${qna.qnaTitle}" required="required" class="form-control"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="20" cols="100" name="qnaContent" id="qnaContent">${qna.qnaContent}</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td>
						<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
						<button class="btn btn-success">수정완료</button>
						<input type="button" value="취소" id="btnList" class="btn btn-danger">
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
	

</body>
</html>