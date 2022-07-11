<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

<script>
	
	$(function(){
		fnRemove();
		fnChange();
	})
	
		function fnRemove(){
		$('#btnRemove').on('click', function(){
			
			var memberNo = "${reviewbyno.memberNo}";
			var sessionNo = "${loginMember.memberNo}";
			
			if(${loginMember eq null}){
				
				alert('로그인 후 이용해주세요');
				
			} else {
				
				if(memberNo == sessionNo){
					if (confirm('삭제하시겠습니까?')) {
						location.href='${contextPath}/product/deleteReview?reviewNo=${reviewbyno.reviewNo}';
						//location.href='${contextPath}/product/deleteReview?proNo=${reviewbyno.proNo}';
						//location.href='${contextPath}/product/deleteReview?reviewNo=' + $('#reviewNo').val();
					}
				} else {
					alert('작성자만 삭제 가능합니다.');
				}
				
			}
			
		})
	}
	
	
	function fnChange(){
		$('#btnChangePage').on('click', function(){
			
			var memberNo = "${reviewbyno.memberNo}";
			var sessionNo = "${loginMember.memberNo}";
			
			if(${loginMember eq null}){
				
				alert('로그인 후 이용해주세요');
				
			} else {
				
				if(memberNo == sessionNo){
					if (confirm('수정하시겠습니까?')) {
						location.href='${contextPath}/product/changeReviewPage?reviewNo=${reviewbyno.reviewNo}';
						//location.href='${contextPath}/product/detail?proNo=${reviewbyno.proNo}';
						//location.href='${contextPath}/product/deleteReview?reviewNo=' + $('#reviewNo').val();
					}
				} else {
					alert('작성자만 수정 가능합니다.');
				}
				
			}
		})
	}
	
		
	
	
</script>
<style>
	
	

</style>

</head>
<body>
	
	
	
	<c:forEach var="fileAttach" items="${fileAttaches}">
		<div><img alt="${fileAttach.riOrigin}" src="${contextPath}/product/reviewDisplay?riNo=${fileAttach.riNo}" width="100%"></div>
	</c:forEach>
	<hr>
	<div class="">
    	<h2>${reviewbyno.reviewTitle}</h2>
	</div>
	<div style="margin: 10px 0px 0px 0px">${reviewbyno.reviewContent}<br></div>
	<div align="right" style="margin-top: 5px; font-size: 12px;">No: ${reviewbyno.reviewNo}</div>
	<div align="right" style="margin-top: 5px; font-size: 12px;">작성일: <fmt:formatDate value="${reviewbyno.reviewDate}" pattern="yyyy-MM-dd"/><br></div>
	<input type="hidden" value="${reviewbyno.reviewNo}">
	<input type="hidden" value="${reviewbyno.proNo}">
	<input type="button" value="리뷰 삭제하기" id="btnRemove" style="background: #212529; color: #fff; margin: 25px 1px 0px 330px; border-radius: 5px;">
	<!-- <input type="button" value="수정하기" id="btnChangePage"> -->
	
</body>
</html>

