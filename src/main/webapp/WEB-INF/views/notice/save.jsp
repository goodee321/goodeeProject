<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="../resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="../resources/summernote-0.8.18-dist/summernote-lite.css"/>
<style>
	* {
		box-sizing: border-box;
	}
	
	.changeTitle { text-align: center; }
	
	table {
		margin: auto;
		border-collapse: collapse;
	}
	
	td:nth-of-type(2) {
		width: 400px;
	}
	
	h1 {
		text-align: center;
		font-size: 30px;
	}
</style>
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
		location.href='${contextPath}/notice/list';
	})
	
	// summernote
	$('#content').summernote({
		width: 800,
		height: 500,
		lang: 'ko-KR',
		placeholder: '내용을 작성해주세요.',
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

	<h1>공지사항 작성화면</h1>
	
	<form id="f" action="${contextPath}/notice/save" method="post">
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td><input type="text" name="title" class="form-control" placeholder="제목" id="inputDefault"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="content" id="content"></textarea></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							<button class="btn btn-primary">작성완료</button>
							<input type="button" value="목록" id="btnList" class="btn btn-info">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	
</body>
</html>