<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <body onload="javascript:window_onload()">  <!-- body에 onload를 이용, 페이지 load 후 스크립트 함수를 호출-->

  

  <script language="javascript">

  <!--

      function window_onload(){

         setTimeout('go_url()',200)  // 5초후 go_url() 함수를 호출한다.

      }

 

      function go_url(){

         location.href="${contextPath}/product/list"  // 페이지 이동...

      }


  </script>

</body>
</html>