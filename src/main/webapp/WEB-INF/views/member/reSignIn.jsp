<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
	.ok {
		color: limegreen;
	}
	.dont {
		color: crimson;
	}
	.box {
		margin: 0 auto;
		text-align: center;
		width: 500px;
		padding-top: 0px;
	}
	.box3 {
		text-align: left;
	}

</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	
	$(function(){
		fnPwCheck();
		fnPwConfirm();
		fnPhoneCheck();
	})

	
	
	
	// 3. 비밀번호 입력확인
	let rePwPass = false;
	function fnPwConfirm(){
		$('#pwConfirm').on('keyup', function(){
			if($('#pwConfirm').val() != '' && $('#pw').val() != $('#pwConfirm').val()){
				$('#pwConfirmMsg').text('비밀번호를 확인하세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#pwConfirmMsg').text('');
				rePwPass = true;
			}
		})
	}
	
	// 2. 비밀번호 정규식
	let pwPass = false;
	function fnPwCheck(){
		// 비밀번호 정규식 검사
		$('#pw').on('keyup', function(){
			let regPw = /^[a-zA-Z0-9!@#$%^&*]{8,15}$/;  // 대소문자, 숫자, 특수문자!@#$%^&* 3~15자 사이
			/*if(regPw.test($('#pw').val())==false){
				$('#pwMsg').text('8~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요.').addClass('dont').removeClass('ok');
				pwPass = false;
			} else {
				$('#pwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			}*/
			let pwValid = /[a-z]/.test($('#pw').val()) +  // 소문자 포함이면 1
		    /[A-Z]/.test($('#pw').val()) +  // 대문자 포함이면 1
		    /[0-9]/.test($('#pw').val()) +  // 숫자 포함이면 1
		    /[!@#$%^&*]/.test($('#pw').val());  // 특수문자 포함이면 1
			if(regPw.test($('#pw').val()) && pwValid >= 3){
				$('#pwMsg').text('').addClass('ok').removeClass('dont');
				pwPass = true;
			} else {
				$('#pwMsg').text('8~15자 영문 대 소문자, 숫자, 특수문자를 사용하세요.').addClass('dont').removeClass('ok');
				pwPass = false;
			}
			
		})
	}
	
	let phonePass = false;
	function fnPhoneCheck(){
		// 휴대폰 번호 정규식 검사
		$('#phone').on('keyup', function(){
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^[0-9]{3})([0-9]+)?([0-9]{4})/,"$1-$2-$3").replace("--", "-") );
			let regPhone = /^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$/;  // 이거만 넣으면 하이픈 직접 넣기
			if(regPhone.test($('#phone').val())==false){
				$('#phoneMsg').text('휴대폰 번호를 입력하세요.').addClass('dont').removeClass('ok');
				phonePass = false;
			} else {
				$('#phoneMsg').text('').addClass('ok').removeClass('dont');
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
	
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<form id="f" action="${contextPath}/member/reSignIn" method="post" class="box">
	
	<h3 class="shadow p-3 mb-5 bg-body rounded">재가입 페이지</h3>
	
	<div class="shadow p-3 mb-5 bg-body rounded">
		<br>
		<div class="box3">
			<h6 class="shadow p-3 mb-5 bg-body rounded"><span class="fw-bold">가입 아이디 : ${member.id}</span></h6>
			
			
			<label for="pw">
				<span class="fw-bold">신규 비밀번호</span><br>
				<input type="password" name="pw" id="pw" required><br>
				<span id="pwMsg"></span>
			</label><br><br>
			
			<label for="pwConfirm">
				<span class="fw-bold">비밀번호 확인</span><br>
				<input type="password" id="pwConfirm" required><br>
				<span id="pwConfirmMsg"></span>
			</label><br><br>
			
			
			
			<span class="fw-bold">가입자명</span><br>
			${member.name.substring(0,1)}*${member.name.substring(2,4)}<br><br>
			
			<span class="fw-bold">가입 당시 이메일</span><br>
			${member.email.substring(0,3)}***${member.email.substring(member.email.indexOf('@'))}<br><br>
			
			<span class="fw-bold">주소검색</span><br>
			<input type="text" name="postcode" id="postcode" value="${member.postcode}" placeholder="우편번호">
			<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
			<input type="text" name="address" id="address" value="${member.address}" placeholder="주소"><br>
			<input type="text" name="addrDetail" id="addrDetail" value="${member.addrDetail}" placeholder="상세주소">
			<input type="text" name="extraAddress" id="extraAddress" value="${member.extraAddress}" placeholder="참고항목">
			<br><br>
			
			<label for="phone">
				<span class="fw-bold">휴대폰번호</span><br>
				<input type="text" name="phone" id="phone" value="${member.phone}"><br>
				<span id="phoneMsg"></span>
			</label><br><br>
			
			<span class="fw-bold">탈퇴일</span><br>
			${member.signOutDate}<br><br>
			<hr>
		</div>
			<input type="hidden" name="memberNo" value="${member.memberNo}">
			<input type="hidden" name="name" value="${member.name}">
			<input type="hidden" name="id" value="${member.id}">
			<input type="hidden" name="email" value="${member.email}">
			<input type="hidden" name="agreeState" value="${member.agreeState}">
	</div>
		<button class="btn btn-dark">사이트 다시 이용하기</button>
		<hr><br><br><br>
		
		
	
	</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>