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
<script>
	
	// 페이지 로드 이벤트
	$(function(){
		fnAreaChoice();
		fnSearchAll();
		fnSearch();
		
	})
	
	// 함수
	function fnAreaChoice(){
		
		// 초기
		$('#equalArea').css('display', 'none');
	
		// 선택
		$('#column').on('change', function(){
			if( $(this).val() == '' ) {
				$('#equalArea').css('display', 'none');
			} else if( $(this).val() == 'NOTICE_TITLE' || $(this).val() == 'NOTICE_CONTENT' ) {
				$('#equalArea').css('display', 'inline');
			} else {
				$('#equalArea').css('display', 'none');
			}
		})
		
	}
	
	function fnSearchAll(){
		$('#btnSearchAll').on('click', function(){
			location.href="${contextPath}/admin/notice/list";
		})
	}
	
	function fnSearch(){
		
		var column = $('#column');
		var query = $('#query');
		
		
		$('#btnSearch').on('click', function(){
			
			
			// 사원번호 검색
			// var regId = /^[0-9]{3}$/;  // 숫자 3자리여야 함.
			// if( column.val() == 'ID' && regId.test(query.val()) == false) {
				// alert('사원번호가 올바르지 않습니다.');
				// query.focus();
				// return;
			// }
			
			
			
			// 검색 실행
			// equalArea 작업은 column, query 파라미터 전송
			
			if( column.val() == 'NOTICE_TITLE' || column.val() == 'NOTICE_CONTENT' ) {
				location.href="${contextPath}/admin/notice/search?column=" + column.val() + "&query=" + query.val();
			} 
			
		})
		
	}
	
	
	
</script>
</head>
<body>

	<h1>공지사항검색</h1>
	
	
	
	<form id="f" method="get">
		<select name="column" id="column">
			<option value="">:::선택:::</option>
			<option value="NOTICE_TITLE">제목</option>
			<option value="NOTICE_CONTENT">내용</option>
		</select>
		<span id="equalArea">
			<input type="text" name="query" id="query">
		</span>
		<input type="button" value="검색" id="btnSearch">
		<input type="button" value="전체공지사항조회" id="btnSearchAll">
	</form>
	
	<br><hr><br>
	
	<%@ include file="list.jsp" %>
	
</body>
</html>