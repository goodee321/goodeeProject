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
<script>

	$(function(){
		fnPhoneCheck();
	})
	
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
	
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<a href="${contextPath}/member/signOut?memberNo=${loginMember.memberNo}" onclick="return confirm('정말로 회원탈퇴 하시겠습니까?')">회원탈퇴하기</a>
	
	<h3>회원정보 변경 페이지입니다.</h3>
	
	<div>
		개인정보 변경을 위해 작성해 주세요.
	</div>
	
	<br>
	
	<form id="f" action="${contextPath}/member/modify" method="post">
	
		가입 아이디<br>
		${loginMember.id}<br><br>
		
		<input type="button" value="비밀번호 변경" id="btnEditPw"><br><br>
		<script>
			$('#btnEditPw').on('click', function(){
				location.href = '${contextPath}/member/editPw';
			})
		</script>
		
		가입자명<br>
		<input type="text" name="name" value="${loginMember.name}"><br><br>
		
		가입 당시 이메일<br>
		<input type="text" name="email" value="${loginMember.email}"><br><br>
		
		주소검색<br>
		<input type="text" name="postcode" id="postcode" value="${loginMember.postcode}" placeholder="우편번호">
		<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" name="address" id="address" value="${loginMember.address}" placeholder="주소"><br>
		<input type="text" name="addrDetail" id="addrDetail" value="${loginMember.addrDetail}" placeholder="상세주소">
		<input type="text" name="extraAddress" id="extraAddress" value="${loginMember.extraAddress}" placeholder="참고항목">
		<br><br>
		
		<label for="phone">
			휴대폰번호<br>
			<input type="text" name="phone" id="phone" value="${loginMember.phone}"><br>
			<span id="phoneMsg"></span>
		</label><br><br>
			
		<div>위치정보 동의여부</div>
		<input type="radio"	name="location" value="on">동의함
		<input type="radio"	name="location" value="off">동의안함<br><br>
		<script>
			if('${loginMember.agreeState}' == '2' || '${loginMember.agreeState}' == '4'){
				$(':radio[name="location"][value="on"]').prop('checked', true);
			} else {
				$(':radio[name="location"][value="off"]').prop('checked', true);
			}
		</script>
		
		<div>프로모션 동의여부</div>
		<input type="radio"	name="promotion" value="on">동의함
		<input type="radio"	name="promotion" value="off">동의안함<br><br>
		<script>
			if('${loginMember.agreeState}' == '3' || '${loginMember.agreeState}' == '4'){
				$(':radio[name="promotion"][value="on"]').prop('checked', true);
			} else {
				$(':radio[name="promotion"][value="off"]').prop('checked', true);
			}
		</script>
		
		<input type="hidden" name="memberNo" value="${loginMember.memberNo}">
		
		<button>회원정보 변경하기</button>
	
	</form>
	
</body>
</html>