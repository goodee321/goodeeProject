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
</head>
<body>

	대충이미지

	<hr>

	<h1>공지사항</h1>
	
	
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
						<td><a href="${contextPath}/notice/detail?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</td>
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