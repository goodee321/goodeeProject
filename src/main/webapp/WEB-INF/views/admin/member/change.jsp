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
	
	section {
		background-color: #BDBDBD;
		text-align: center;
		font-family: Georgia, "Malgun Gothic", serif;
		}
		
	.kind {
		font-family: 'Splash', cursive;
		font-size: 40px;
		text-shadow: 2px 4px 2px gray;
		}	
		
		table {
	padding: 20px;
	margin: auto;
	box-shadow: 5px 5px 5px 3px gray;
	border-radius: 5px;
	}
  	
	
	table td {
		padding: 10px;
		border-top: 1px solid #848484;
	}
	
	input {
	text-align: left;
  	width:100%;
  	height:30px;
  
  	
 
}
			
	
</style>
<script src="../../resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(function(){
		
		
		// 목록
		$('#btnList').on('click', function(){
			location.href='${contextPath}/admin/member/list';
		})
	})
	
	/* 페이지 로드 이벤트 */
	$(function(){
		
		fnPhoneCheck();
		
	})
	
	// 8. 휴대폰번호 정규식
	let phonePass = false;
	function fnPhoneCheck(){
		// 비밀번호 정규식 검사
		$('#phone').on('keyup', function(){
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^[0-9]{3})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") );
			let regPhone = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;  // 이거만 넣으면 하이픈 직접 넣기
			if(regPhone.test($('#phone').val())==false){
				$('#phoneMsg').text('휴대폰 번호를 입력하세요.').addClass('dont').removeClass('ok');
				phonePass = false;
			} else {
				$('#phoneMsg').text('사용 가능한 번호입니다.').addClass('ok').removeClass('dont');
				phonePass = true;
			}
		})
	}
	
	
	
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrDetail").focus();
            }
        }).open();
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
	<h3 class="kind">Member Modify</h3>


	<form action="${contextPath}/admin/member/change" method="post">
	
	
		<table border="1">
			<tbody>
				<tr>
					<td class="table-dark">NAME</td>
					<td class="table-secondary"><input type="text" name="name" id="name" value="${member.name}" placeholder="NAME" required></td>
				</tr>
				<tr>
					<td class="table-dark">E-Mail</td>
					<td class="table-secondary"><input type="text" name="email" id="email" value="${member.email}" placeholder="E-Mail" required></td>
				</tr>
				<tr>
					<td class="table-dark">우편번호</td>
					<td class="table-secondary"><input type="text" name="postcode" id="postcode" value="${member.postcode}" placeholder="우편번호" required>
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td class="table-dark">주소</td>
					<td class="table-secondary"><input type="text" name="address" id="address" value="${member.address}" placeholder="주소" required></td>
				</tr>
				<tr>
					<td class="table-dark">상세주소</td>
					<td class="table-secondary"><input type="text" name="addrDetail" id="addrDetail" value="${member.addrDetail}" placeholder="상세주소" required></td>
				</tr>
				<tr>
					<td class="table-dark">참고항목</td>
					<td class="table-secondary"><input type="text" name="extraAddress" id="extraAddress" value="${member.extraAddress}" placeholder="참고항목"></td>
				</tr>
				<tr>
					<td class="table-dark">휴대폰번호</td>
					<td class="table-secondary"><input type="text" name="phone" id="phone" value="${member.phone}" placeholder="휴대폰번호" ></td>
					<input type="hidden" name="memberNo" value="${member.memberNo}">
				</tr>
			</tbody>
			
		</table>
		
		<br>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button class="btn btn-secondary">수정완료</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
		
		<a href="${contextPath}/admin/member/list">목록으로가기</a>
		
	

	</form>
		<br>
</section>


<footer id="footer">

	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>


</body>
</html>