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
</style>
<script>

	$(function(){
	
		$('#f').on('submit', function(event){
			if($('#noticeTitle').val() == ''){
				alert('제목은 필수입니다.');
				event.preventDefault();
				return;
			} else if($('#noticeTitle').val() == '${notice.noticeTitle}' && $('#noticeContent').val() == '${notice.noticeContent}'){
				alert('수정할 내용이 없습니다.');
				event.preventDefault();
				return;
			}
		})
	

		$('#btnList').on('click', function(){
			location.href='${contextPath}/notice/list';
			})
			
		// summernote
		$('#noticeContent').summernote({
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
	<div class="changeTitle">
	<h3>수정페이지</h3><br>
	</div>
		
		<form id="f" action="${contextPath}/notice/change" method="post">
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td><input type="text" name="noticeTitle" value="${notice.noticeTitle}" required class="form-control" placeholder="Default input" id="inputDefault"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="noticeContent" id="noticeContent">${notice.noticeContent}</textarea></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
							<button class="btn btn-primary">수정완료</button>
							<input type="button" value="목록" id="btnList" class="btn btn-info">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>

</body>
</html>