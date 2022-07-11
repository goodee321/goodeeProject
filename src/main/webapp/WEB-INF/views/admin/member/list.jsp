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
	
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');

	.blind{display: none; }

	.unlink, .link {
		display: inline-block;  /* 같은 줄에 둘 수 있고, width, height 등 크기 지정 속성을 지정할 수 있다. */
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;  /* 링크 밑줄 없애기 */
		color: gray;
		font-weight: bold;
	}
	.link:hover {
		border: 1px solid black;
		color: green;
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
		text-align: center;
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
	}
	tfoot td {
		border-left: 0;
		border-right: 0;
		border-bottom: 0;
	}
	
	input[type="checkbox"] {
  		width: 27px; 
  		height: 27px; 
	}
	
	
	thead {
		font-weight: bold;
		
	}
	
	
	section {
		background-color: #BDBDBD;
		text-align: center;
		font-family: Georgia, "Malgun Gothic", serif;
	}
	
	
	
	.kind {
			font-family: 'Splash', cursive;
			font-size: 40px;
			text-shadow: 1px 1px 1px gray;
	}
	
	.kind2 {
			font-family: 'Splash', cursive;
			font-size: 32px;
			text-shadow: 1px 1px 1px gray;
			
	}
	
	table {
	padding: 20px;
	margin: auto;
	box-shadow: 2px 2px 2px 2px gray;
	border-radius: 5px;
	
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



$(function(){
fnAreaChoice();
fnSearchAll();
fnSearch();
fnRemove();
})





// 함수
function fnAreaChoice(){
	
	// 초기
	$('#equalArea').css('display', 'none');

	// 선택
	$('#column').on('change', function(){
		if( $(this).val() == '' ) {
			$('#equalArea').css('display', 'none');
		} else if( $(this).val() == 'ID' || $(this).val() == 'NAME' ) {
			$('#equalArea').css('display', 'inline');
		} else {
			$('#equalArea').css('display', 'none');
		}
	})
	
}

function fnSearchAll(){
	$('#btnSearchAll').on('click', function(){
		location.href="${contextPath}/admin/member/list";
	})
}


function fnRemove(){
	
	$('#btnRemove').on('click', function(){
		
		var result = confirm("선택한 회원을 삭제하시겠습니까?");
		
		if(result == true){
				$('#f2').submit();
			}
		else {
			event.preventDefault();
			return false;
			}
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
		if( query.val() == '') {
			alert('검색어를 입력해주세요.');
			event.preventDefault();
			return false;
		}
		
		else if( column.val() == 'ID' || column.val() == 'NAME' ) {
			location.href="${contextPath}/admin/member/search?column=" + column.val() + "&query=" + query.val();
		} 
		
	})
	
	
}
	
	
	
	
	
</script>
	
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
	<h3 class="kind">Member Management</h3>
	
	<h3 class="kind2">Total Member : ${totalRecord}</h3>
	
	
	</div>
	
	
	
	
	<hr>
	
	
	<form id="f" method="get">
	
		<select name="column" id="column">
			<option value="">:::선택:::</option>
			<option value="ID">ID</option>
			<option value="NAME">NAME</option>
		</select>
		
		<span id="equalArea">
			
			<input type="text" name="query" id="query">
			
		</span>
		
		<input type="button" value="검색" id="btnSearch" class="btn btn-secondary" >
		<input type="button" value="전체사원조회" id="btnSearchAll" class="btn btn-secondary">
		
	</form>
	
	
	
	<form id="f2" action="${contextPath}/admin/member/removeList">

		
	
		<table id="boardtable"  class="table-hover"><br>
		
			<thead>
				<tr>
					<td class="table-dark" scope="col">
						<label for="checkAll">전체선택</label>
						<input type="checkbox" id="checkAll" class="blind">
					</td>
					<td class="table-dark">회원번호</td>
					<td class="table-dark">ID</td>
					<td class="table-dark">NAME</td>
					<td class="table-dark">E-Mail</td>
					
				</tr>
			</thead>
			
			<tbody class="table-secondary">
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
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					${paging}
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button id="btnRemove" class="btn btn-secondary">선택삭제</button><br><br>
				</td>
				
				
			</tr>
		</tfoot>
		
		</table>
	</form><br>
	
	
	
	
</section>

<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>

</body>
</html>
