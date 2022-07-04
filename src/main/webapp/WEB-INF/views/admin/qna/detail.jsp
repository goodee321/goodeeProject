<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	
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
				$('#f').attr('action', '${contextPath}/admin/qna/removeOne');
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

	.qnaDetail h1 { text-align: center; 
	
	
	}


	
	table {
		border-collapse: collapse;
		margin: auto;
	}
	
	thead {
		
	}
	
	td {
		padding: 5px;
		border: 1px solid ;
	}
	
	td:nth-of-type(1) {}
	
	td:nth-of-type(2) { width: 160px; }
	
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
		
		section {
			background-color: #BDBDBD;
			text-align: center;
			font-family: Georgia, "Malgun Gothic", serif;
	}
	
	.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
	}
	
	
	
	section {
		background-color: #BDBDBD;
		text-align: center;
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

<div>
	<h3 class="kind">Qna Detail</h3><br>
	</div>
	<div class="qnaDetail">
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
							<td>${loginMember.id}</td>
						</tr>
						<tr>
							<td>제목</td>
							<td>${qna.qnaTitle}</td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
								<textarea rows="20" cols="30" readonly>
									${qna.qnaContent}
								</textarea>
							</td>
						</tr>
						<tr>
							<td>작성일</td>
							<td>${qna.qnaDate}</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td></td>
							<td><!-- c:if test="${loginMember.id eq 'admin'}" -->
								<br>
								<input type="button" value="수정하러가기" id="btnChangePage" class="btn btn-secondary">&nbsp;&nbsp;&nbsp;
								<input type="button" value="삭제" id="btnRemove" class="btn btn-secondary">&nbsp;&nbsp;
							
							<input type="button" value="목록" id="btnList" class="btn btn-secondary">
							</td>
						</tr>
					</tfoot>
					</table> 
			
		</form>
		</div>
		</section>
		
		<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>
		
	
	
</body>
</html>