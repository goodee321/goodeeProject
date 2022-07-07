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
	
	table {
	border-collapse: collapse;
	margin: auto;
	}
	
	thead {
		background-color: silver;
	}
	
	td {
		padding: 5px;

	}
	
	td:nth-of-type(1) {
		
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
	
	textarea {
		border:  1px solid #ced4da;
	}

	
</style>
</head>
<body>

	<h1>Q&A 작성화면</h1>
	
	<form id="f" action="${contextPath}/qna/save" method="post">
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" id="title" class="form-control" placeholder="제목을 작성해주세요."></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="id" value="${loginMember.id}" readonly="readonly" class="form-control"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="20" cols="100" name="content" placeholder="문의 확인 후 빠르게 답변해드리겠습니다." ></textarea></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							<button class="btn btn-success">작성완료</button>
							<input type="button" value="목록" id="btnList" class="btn btn-info">
						</td>
					</tr>
				</tfoot>
			</table>
	</form>
	

</body>
</html>