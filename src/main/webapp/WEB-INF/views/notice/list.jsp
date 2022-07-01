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
<style>

	* {
		box-sizing: border-box;
	}
	
	.noticeTitle {
		text-align: center;
	}
	
	p {
		font-size: 15px;
	}
	
	.unlink, .link {
		display: inline-block; 
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;
		color: #fbfafa;
	}
	
	a {
		text-decoration: none;
		color: #555555;
	}
	
	a:hover {
		color: #008bcc;
	}
	
	.link:hover {
		color: #008bcc;
	}
	
	table {
	border-collapse: collapse;
	margin: auto;
	}
	
	tbody tr:hover {
		background-color: #fff0f5;
	}
	
	table caption {
		margin-bottom: 5px;
		margin-left: 0;
	}
	
	table caption a {
		background-color: #008bbc;
		color: white;
		text-decoration: none; 
	}
	
	thead {
		background-color: #fbfafa;	
	}
	
	td:nth-of-type(1) { width: 80px; }
	td:nth-of-type(2) { width: 160px; }
	td:nth-of-type(3) { width: 400px; }
	td:nth-of-type(4) { width: 100px; }

	td {
		padding: 5px;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
		text-align: center;
		color: #555555;
	}
	
	tfoot {
		text-align: center;
	}
	
	tfoot td {
		border-left: 0;
		border-right: 0;
		border-bottom: 0;
	}
	
	
</style>
</head>
<body>

	대충이미지

	<hr>
	
	<div class="noticeTitle">
		<h1>공지사항</h1>
		<p>공지사항입니다</p>
	</div>
	
	<form action="${contextPath}/notice/removeList">
	
		<table>
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${notices}" var="notice">
					<tr data-notice_no="${notice.noticeNo}">
						<td>${notice.noticeNo}</td>
						<td><a href="${contextPath}/notice/detail?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a></td>
						<td>${notice.noticeDate}</td>
						<td>${notice.noticeHit}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>

	</form>

</body>
</html>