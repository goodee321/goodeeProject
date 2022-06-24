<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<script>

	if('${type}' == 'insert'){
		
		if('${insRes}' == '1'){	
			alert('공지사항이 등록되었습니다.');
			location.href='${contextPath}/notice/list';
		} else{
			alert('공지사항이 등록되지 않았습니다.');
			history.back();
		}
	}
	
	if('${type}' == 'update'){
		if('${updRes}' == '1'){
			alert('공지사항이 수정되었습니다.');
			location.href='${contextPath}/notice/list';
		} else{
			alert('공지사항이 수정되지 않았습니다.');
			history.back();
		}
	}
	
	
	
	if('${type}' == 'delete'){
		if('${delRes}' > '0'){		
			alert('선택한 공지사항이 삭제되었습니다.');
			location.href='${contextPath}/notice/list';
		} else{
			alert('선택한 공지사항이 삭제되지 않았습니다.');
			history.back();
		}
	}

</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	

</body>
</html>