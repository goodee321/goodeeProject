<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<script>
	
	
	if('${kind}' == 'update'){
		if('${res}' == '1'){
			alert('제품이 수정되었습니다.');
			location.href='${contextPath}/admin/product/list';
		} else {
			alert('제품이 수정되지 않았습니다.');
			history.back();
		}
	}
	
	if('${type}' == 'insert'){
		
		if('${insRes}' == '1'){	
			alert('제품이 등록되었습니다.');
			location.href='${contextPath}/admin/product/list';
		} else{
			alert('제품이 등록되지 않았습니다.');
			history.back();
		}
	}
	
	
	
	if('${kind}' == 'deleteOne'){
		if('${res}' == '1'){
			alert('제품이 삭제되었습니다.');
			location.href='${contextPath}/admin/product/list';
		} else {
			alert('제품이 삭제되지 않았습니다.');
			history.back();
		}
	}
	
	if('${kind}' == 'deleteList'){
		
		if('${res}' > '0'){
			alert('선택한 제품이 삭제되었습니다.');
			location.href='${contextPath}/admin/product/list';
		} else {
			alert('선택한 제품이 삭제되지 않았습니다.');
			history.back();
		}
		
	}
</script>