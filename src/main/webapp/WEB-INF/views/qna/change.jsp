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
<script src="../resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="../resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="../resources/summernote-0.8.18-dist/summernote-lite.css"/>
<style>

	h3 { 
		text-align: center; 
		font-size: xx-large;
		padding-bottom: 10px;
		margin-top: 5%;
	}
	
	table {
	border-collapse: collapse;
	margin: auto;
	}
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 5px 5px 5px 3px gray;
	border-radius: 5px;
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
			
		// summernote
		$('#qnaContent').summernote({
			width: 800,
			height: 500,
			lang: 'ko-KR',
			// 툴바 수정
			toolbar: [
				   ['fontname', ['fontname']],
				   ['fontsize', ['fontsize']],
				   ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				   ['color', ['forecolor','color']],
				   ['table', ['table']],
				   ['para', ['ul', 'ol', 'paragraph']],
				   ['height', ['height']],
				   ['view', ['fullscreen', 'help']]
			],
			fontNames: ['Arial', 'Arial Black', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','36','48','72']
		})
			
	
	})
</script>
</head>
<body>
	<jsp:include page="../layout/header2.jsp"></jsp:include>
	<h3>수정페이지</h3>
	
	<form id="f" action="${contextPath}/qna/change" method="post">
		<table>
			<tbody>
				<tr>
					<td>제목</td>
					<td><input type="text" name="qnaTitle" id="qnaTitle" value="${qna.qnaTitle}" required="required" class="form-control"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="qnaContent" id="qnaContent">${qna.qnaContent}</textarea></td>
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
	
	<jsp:include page="../layout/Footer.jsp"></jsp:include>

</body>
</html>