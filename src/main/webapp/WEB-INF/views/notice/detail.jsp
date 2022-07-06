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
		// 수정하러가기
		$('#btnChangePage').on('click', function(){
			location.href='${contextPath}/notice/changePage?noticeNo=${notice.noticeNo}';
		})
		// 삭제
		$('#btnRemove').on('click', function(){
			if(confirm('삭제할까요?')){
				$('#f').attr('action', '${contextPath}/notice/removeOne');
				$('#f').submit();
			}
		})
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/notice/list';
		})
	})
</script>
<style>

	.detail h1 { text-align: center; }
	
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
	
	td:nth-of-type(1) { background-color: #fbfafa; }
	
	td:nth-of-type(2) { width: 160px; }
	
	textarea { text-align: left; }
	
	tfoot td { 
		border-bottom: none; 
		border-left: none;
		border-right: none;
		background-color: none;
		text-align: right;
	}
	
</style>
</head>
<body>

	<div class="detail">
		<h1>공지사항 상세화면</h1>
		
		<form id="f">
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}"> 
			<table>
				<tbody>
					<tr>
						<td>번호</td>
						<td>${notice.noticeNo}</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>${notice.noticeTitle}</td>
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea rows="20" cols="100" readonly>
								${notice.noticeContent}
							</textarea>
						</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td>${notice.noticeDate}</td>
					</tr>
					<tr>
						<td>조회수</td>
						<td>${notice.noticeHit}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
							<c:if test="${loginMember.id eq 'admin'}">
								<input type="button" value="수정하러가기" id="btnChangePage" class="btn btn-danger">
								<input type="button" value="삭제" id="btnRemove" class="btn btn-light">
							</c:if>
						<input type="button" value="목록" id="btnList" class="btn btn-info">
						</td>
					</tr>
				</tfoot>
				</table>
		</form>
		
	</div>
	
</body>
</html>