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
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){		
		// 수정하러가기
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/admin/notice/changePage?noticeNo=${notice.noticeNo}';
		})
		// 삭제
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/admin/notice/removeOne');
				$('#f').submit();
			}
		})
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/notice/list';
		})
	})
</script>
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');


	.detail h1 { 
		text-align: center; 
		font-size: xx-large;
		padding-bottom: 10px;
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
	
	table td {
		padding: 5px;
		border-top: 1px solid black;
		
	}
	
	tbody td:nth-of-type(1) { 
		
		
		
	}
	
	td:nth-of-type(2) { 
		
		
	}
	
	tbody tr:nth-of-type(1) { border-top: 1px solid; }
	
	tr:nth-of-type(2) td:nth-of-type(3) { 
		
		text-align: center;
		
	}
	
	tr:nth-of-type(2) td:nth-of-type(5) { 
		
		text-align: center;
		
	}
	
	tr:nth-of-type(3) td:nth-of-type(2) {
	height: 300px;
	vertical-align: top;
	width: 600px; 
	}
	
	textarea { text-align: left; }
	
	tfoot td { 
		border-bottom: none; 
		border-left: none;
		border-right: none;
		background-color: none;
		text-align: right;
	}
	
	
	.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
			text-align: center;
			text-shadow: 2px 4px 2px gray;
	}
	
	section {
			background-color: #BDBDBD;
			text-align: left;
			font-family: Georgia, "Malgun Gothic", serif;
	}
	
	
</style>
</head>
<body>

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../layout/nav.jsp" %>
			
		</div>
	</nav>
	
	<section>
	<br>
	<h3 class="kind">Notice Detail</h3>
		
		<form id="f">
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}"> 
			<table>
				<tbody>
					<tr>
						<td class="table-dark">제목</td>
						<td colspan="5" class="table-secondary">${notice.noticeTitle}</td>
					</tr>
					<tr>
						<td class="table-dark">번호</td>
						<td class="table-secondary">${notice.noticeNo}</td>
						<td class="table-dark">작성자</td>
						<td class="table-secondary">관리자</td>
						<td class="table-dark">조회수</td>
						<td class="table-secondary">${notice.noticeHit}</td>
					</tr>
					<tr>
						<td class="table-dark">내용</td>
						<td colspan="5" class="table-secondary">${notice.noticeContent}</td>
					</tr>
					<tr>
						<td class="table-dark">작성일</td>
						<td colspan="5" class="table-secondary">${notice.noticeDate}</td>
					</tr>
					
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td colspan="5">
							<c:if test="${loginMember.id eq 'admin'}">
								<input type="button" value="수정하러가기" id="btnChangePage" class="btn btn-secondary">
								<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">
							</c:if>
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