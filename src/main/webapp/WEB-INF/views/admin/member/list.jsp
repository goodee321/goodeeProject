<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	* {
		box-sizing: border-box;
	}
	.unlink, .link {
		display: inline-block;  /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;  /* 링크 밑줄 없애기 */
		color: gray;
	}
	.link:hover {
		border: 1px solid orange;
		color: limegreen;
	}
	table {
		border-collapse: collapse;
		margin-left:auto; 
    	margin-right:auto;
		
	}
	td:nth-of-type(1) { width: 80px; }
	td:nth-of-type(2) { width: 160px; }
	td:nth-of-type(3) { width: 240px; }
	td:nth-of-type(4) { width: 240px; }
	td:nth-of-type(5) { width: 120px; }
	td:nth-of-type(6) { width: 160px; }
	td:nth-of-type(7) { width: 160px; }
	
	td {
		padding: 5px;
		border : 1px solid;
		text-align: center;
	}
	tfoot td {
		border-left: 0;
		border-right: 0;
		border-bottom: 0;
	}
	
	body {
		background-color: #BDBDBD;
		text-align: center;
	}
	
	thead {
		font-weight: bold;
	}
	
	input[type="checkbox"] {
  		width: 27px; 
  		height: 27px; 
	}
	
	
	
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>
	$(document).ready(function(){
		
		$('tbody td:not(td:first-of-type)').on('click', function(){
			var memberNo = $(this).parent().data('member_no');
			location.href='${contextPath}/admin/member/detail?memberNo=' + memberNo;
		})
		
		
		
		/*
		$('tbody tr').on('click', function(){
			// $(this)                          : 클릭한 행을 의미한다.
			//                                    <tr>...</tr>
			// $(this).find('.noticeNo')        : 클릭한 행 내부에 있는 class="noticeNo" 요소를 의미한다.
			//                                    <td class="noticeNo">1</td>
			// $(this).find('.noticeNo').text() : 클릭한 행 내부에 있는 class="noticeNo" 요소의 텍스트를 의미한다.
			//                                    1
			var noticeNo = $(this).find('.noticeNo').text();
			location.href='${contextPath}/notice/detail?noticeNo=' + noticeNo;
		})
		*/
		
		
		// 전체 선택 클릭하기
		// 전체 선택을 체크하면 개별 선택도 모두 체크
		// 전체 선택을 해제하면 개별 선택도 모두 해제
		var checkAll = $('#checkAll');
		var checkes = $('.checkes');
		checkAll.on('click', function(){
			for(let i = 0; i < checkes.length; i++) {
				// check[i].prop('checked', true);  // 전체 선택이 체크된 경우
				// check[i].prop('checked', false); // 전체 선택이 해제된 경우
				$(checkes[i]).prop('checked', checkAll.prop('checked'));
			}
			$.each(checkes, function(i, check){
				$(check).prop('checked', checkAll.prop('checked'));
			})
		})
		
		// 개별 선택 클릭하기
		// 개별 선택을 클릭하면
		// 모든 개별 선택을 확인해서
		// 모두 체크되어 있으면 전체 선택 체크하고,
		// 하나라도 체크 해제되어 있으면 전체 선택 해제한다.
		for(let i = 0; i < checkes.length; i++){
			$(checkes[i]).on('click', function(){
				for(let j = 0; j < checkes.length; j++){
					if($(checkes[j]).prop('checked') == false){  // 하나라도 체크 해제되었다면,
						checkAll.prop('checked', false);         // 전체 선택 해제하고,
						return;                                  // 함수 종료(클릭 이벤트 리스너)
					}
				}
				checkAll.prop('checked', true);             // 체크 해제된 것이 하나도 발견되지 않은 경우 전체 선택 체크
			})
		}
		
	})
	
</script>
	<style>
		.blind{display: none; }
	</style>
</head>
<body>

	<a href="${contextPath}/admin/main">관리자페이지</a>
	
	<h3>회원관리</h3>
	
	
	
	<hr>
	
	<form action="${contextPath}/admin/member/removeList">

		<button>선택삭제</button><br>
	
		<table border="1">
		
			<thead>
				<tr>
					<td>
						<label for="checkAll">전체선택</label>
						<input type="checkbox" id="checkAll" class="blind">
					</td>
					<td>회원번호</td>
					<td>ID</td>
					<td>이름</td>
					<td>이메일</td>
					
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${members}" var="member">
					<tr data-member_no="${member.memberNo}">
						<td><input type="checkbox" name="memberNoList" id="memberNoList" value="${member.memberNo}" class="checkes"></td>
						<td>${member.memberNo}</td>
						<td>${member.id}</td>
						<td>${member.name}</td>
						<td>${member.email}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
			<tr>
				<td colspan="5">
					${paging}
				</td>
			</tr>
		</tfoot>
		</table>

	</form>

</body>
</html>
</html>