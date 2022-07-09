<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<script src="../../resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="../../resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="../../resources/summernote-0.8.18-dist/summernote-lite.css"/>
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');

	
	* {
		box-sizing: border-box;
	}
	
	.changeTitle { text-align: center; }
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 5px 5px 5px 3px gray;
	border-radius: 5px;
	
	}
	
	table td {
		padding: 5px;
		border-top: 1px solid gray;
		
	}
	
	thead {
		background-color: silver;
	}
	
	
	
	td:nth-of-type(2) {
		width: 400px;
	}
	
	section {
		background-color: #BDBDBD;
		text-align: left;
		font-family: Georgia, "Malgun Gothic", serif;
		}
		
		.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
			text-align: center;
			background-color: #BDBDBD;
			text-shadow: 2px 4px 2px gray;
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
			location.href='${contextPath}/admin/notice/list';
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

<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
		
		</div>
		
	</nav>

	<section>
	<br>
	<h3 class="kind">Notice Modify</h3><br>
	
	
	
	
	
		
		<form id="f" action="${contextPath}/admin/notice/change" method="post">
		<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
			<table>
				<tbody>
					<tr>
						<td class="table-dark">제목</td>
						<td><input type="text" name="noticeTitle" value="${notice.noticeTitle}" required class="form-control" placeholder="Default input" id="inputDefault" required></td>
					</tr>
					<tr>
						<td class="table-dark">내용</td>
						<td class="table-secondary"><textarea name="noticeContent" id="noticeContent" required>${notice.noticeContent}</textarea></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							
							<button class="btn btn-secondary">수정완료</button>
							<input type="button" value="목록" id="btnList" class="btn btn-secondary">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
		</section>

<footer id="footer">

	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>


</body>
</html>