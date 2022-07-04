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
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${contextPath}/admin/member/list">NISHOE Admin</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${contextPath}/">Main</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/admin/member/list">Member</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/admin/notice/list">Notice</a>
         <li class="nav-item">
          <a class="nav-link" href="${contextPath}/admin/order/list">Order</a>
        </li>
       
         <li class="nav-item">
          <a class="nav-link" href="${contextPath}/admin/product/list">Product</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/admin/qna/list">Qna</a>
        </li>
         
      </ul>&nbsp;&nbsp;&nbsp;
      <span class="navbar-text">
        ${loginMember.name} 님 반갑습니다.&nbsp;&nbsp;&nbsp;
		<a href="${contextPath}/member/logout">로그아웃</a>
      </span>
    </div>
  </div>
</nav>


</body>
</html>