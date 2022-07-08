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

	.detail h1 { 
		text-align: center; 
		font-size: xx-large;
		padding-bottom: 10px;
	}
	
	table {
		margin: auto;
		border-collapse: collapse;
		width: 50%;
	}
	
	thead {
		background-color: silver;	
	}
	
	table td {
		padding: 5px;
		border-top: 1px solid silver;
		
	}
	
	tbody td:nth-of-type(1) { 
		color: #1C1C1C;
		background-color: #F2F2F2; 
		text-align: center;
	}
	
	td:nth-of-type(2) { 
		background-color: none;
		
	}
	
	tbody tr:nth-of-type(1) { border-top: 2px solid #17a2b8; }
	
	tr:nth-of-type(2) td:nth-of-type(3) { 
		color: #1C1C1C;
		text-align: center;
		background-color: #F2F2F2; 
	}
	
	tr:nth-of-type(2) td:nth-of-type(5) { 
		color: #1C1C1C;
		text-align: center;
		background-color: #F2F2F2; 
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
	
</style>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="detail">
		<h1>공지사항 상세보기</h1>
		
		<form id="f">
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}"> 
			<table>
				<tbody>
					<tr>
						<td>제목</td>
						<td colspan="5">${notice.noticeTitle}</td>
					</tr>
					<tr>
						<td>번호</td>
						<td>${notice.noticeNo}</td>
						<td>작성자</td>
						<td>관리자</td>
						<td>조회수</td>
						<td>${notice.noticeHit}</td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="5">${notice.noticeContent}</td>
					</tr>
					<tr>
						<td>작성일</td>
						<td colspan="5">${notice.noticeDate}</td>
					</tr>
					
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td colspan="5">
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
	
	<jsp:include page="../layout/Footer.jsp"></jsp:include>
	
</body>
</html>