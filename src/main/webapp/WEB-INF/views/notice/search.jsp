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

	.search {
		display: block;
		text-align: center;
	}
	
	span input:hover {
		border: 1px solid #008bcc;
	}
	
	#btnSearch { 
		background-color: #708090; 
		color: silver;
		border: #708090;
		border-radius: 3px;
		width: 60px;
		height: 25px;
	}
	
</style>
<script>
	
	// 페이지 로드 이벤트
	$(function(){
		fnAreaChoice();
		fnSearch();
	})

	function fnAreaChoice(){
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
	
	function fnSearch(){
		
		var column = $('#column');
		var query = $('#query');
		
		
		$('#btnSearch').on('click', function(){
			// equalArea 작업은 column, query 파라미터 전송
			if( column.val() == 'NOTICE_TITLE' || column.val() == 'NOTICE_CONTENT' ) {
				location.href="${contextPath}/notice/search?column=" + column.val() + "&query=" + query.val();
			} 
			
		})
		
	}
	
	
	
</script>
</head>
<body>


	<%@ include file="list.jsp" %>
	
	<div class="search">
		<form id="f" method="get" >
			<select name="column" id="column">
				<option value="">:::선택:::</option>
				<option value="NOTICE_TITLE">제목</option>
				<option value="NOTICE_CONTENT">내용</option>
			</select>
			<span id="equalArea">
				<input type="text" name="query" id="query">
			</span>
			<input type="button" value="검색" id="btnSearch">
		</form>
	</div>
	
	
	
	
</body>
</html>