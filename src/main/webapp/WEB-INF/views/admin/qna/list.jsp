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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script src="../../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
	
		$('.reply_link').on('click', function(){
			$('.reply_form').addClass('blind');
	    	$(this).parent().parent().next().removeClass('blind');
		})
	
	})
</script>
<style>

	@import url('https://fonts.googleapis.com/css2?family=Splash&display=swap');


	.blind {
		display: none;
	}
	
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
		font-weight: bold;
	}
	
	.link:hover {
		border: 1px solid black;
		color: green;
	}
	
	.title {
		font-size: 20px;
		text-align: center;
	}
	
	.title p {
		font-size: 15px;
		display: block;
	}
	
	
	table {
	border-collapse: collapse;
	padding: 20px;
	margin: auto;
	box-shadow: 2px 2px 2px 2px gray;
	border-radius: 5px;
	}

	
	table caption {
		margin-bottom: 5px;
	
	}
	
	table caption a {
		background-color: #6495ed;
		color: white;
		text-decoration: none; 
		border-radius: 3px;
	
	}
	
	table a { text-decoration: none; }
	
	thead {
		background-color: #696969;	
	}
	
	thead td { 
		color: white; 
		font-weight: 600;	
	}
	
	td:nth-of-type(1) { width: 80px; }
	td:nth-of-type(2) { width: 160px; }
	td:nth-of-type(3) { width: 450px; }
	td:nth-of-type(4) { width: 100px; }
	td:nth-of-type(5) { width: 150px; }
	td {
		padding: 5px;
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
		text-align: center;
	}
	
	tbody tr:hover { background-color: #f0ffff; }
	
	tfoot {
		text-align: center;
	}
	
	tfoot td {
		border-left: 0;
		border-right: 0;
		border-bottom: 0;
	}
	
	section {
		background-color: #BDBDBD;
		text-align: center;
		
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
	
	
</style>
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
		<h3 class="kind">Qna Management</h3>
		
		<h3 class="kind2">Total Qna	: ${totalRecord}</h3><br>
		<!-- <a href="${contextPath}/admin/qna/saveQna">글쓰기</a><br>  -->
		
	
	</div>
	
	

		<table>
			<!-- <c:if test="${member.id != null}"></c:if> -->
			
			<thead class="table-dark">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>내용</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>답변기능</td>
					<td>X</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty qnas}">
					<tr>
						<td colspan="5">첫 게시글을 작성해 주세요.</td>
					</tr>
				</c:if>
				<c:if test="${not empty qnas}">
					<c:forEach var="qna" items="${qnas}">
						<c:if test="${qna.qnaState == -1}">
							<tr>
								<td colspan="7">&nbsp;&nbsp;&nbsp;&nbsp;<i class="fa-solid fa-ban"></i> 삭제된 게시글입니다</td>
							</tr>
						</c:if>
						<c:if test="${qna.qnaState == 1}">
						<!-- 작성자or관리자 아니면 비밀글 -->
						<!-- <tr><td><i class="fa-regular fa-lock-keyhole"></i>비밀글입니다</td></tr> -->
							<tr>
								<td>${qna.qnaNo}</td>
								<td>
									<c:forEach begin="1" end="${qna.qnaDepth}" step="1"></c:forEach>
									
									<c:if test="${qna.qnaDepth gt 0}"><i class="fa-solid fa-comment-dots"> 관리자 답변</i></c:if>
									<!-- 제목 -->
									<c:if test="${qna.qnaTitle.length() gt 20}">
										<a href="${contextPath}/admin/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle.substring(0, 10)}</a>
									</c:if>
									<c:if test="${qna.qnaTitle.length() le 20}">								
										<a href="${contextPath}/admin/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
									</c:if>
								</td>
								<td>
									<c:if test="${qna.qnaContent.length() gt 24}">
										${qna.qnaContent.substring(0, 24)}	
									</c:if>
									<c:if test="${qna.qnaContent.length() lt 24}">
										${qna.qnaContent}
									</c:if>
								</td>
								<td>${qna.id}</td>
								<td>${qna.qnaDate}</td>
								
									<td>
									<!-- 답글달기(if 있으면 1단 댓글만 허용, if 없으면 다단 댓글 허용) -->
									<c:if test="${qna.qnaDepth eq 0}">
										<a class="reply_link">답변하기</a>								
									</c:if>
								</td>
								<td>
									<a data-qna_no="${qna.qnaNo}" onclick="fnRemove(this)">
										<i class="fa-solid fa-trash-can"></i>
									</a>
								</td>
								
							</tr>
							<tr class="reply_form blind">
								<td colspan="5">
									<form action="${contextPath}/admin/qna/saveReply" method="post">
										<input type="text" name="id" value="${loginMember.id}" size="4" readonly="readonly">
										<input type="text" name="qnaContent" placeholder="답글을 달아주세요" size="40">
										<!-- <input type="text" name="qnaDate" value="${qna.qnaDate}"> -->
										<input type="hidden" name="qnaDepth" value="${qna.qnaDepth}">
										<input type="hidden" name="qnaGroupNo" value="${qna.qnaGroupNo}">
										<input type="hidden" name="qnaGroupOrd" value="${qna.qnaGroupOrd}">
										<button>답글달기</button>
									</form>
								</td>
							</tr>
						</c:if>
				</c:forEach>
				</c:if>

			</tbody>
			<tfoot>
				<tr>
					<td colspan="7">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
<br>
	<script>
		function fnRemove(a) {
			if(confirm('게시글을 삭제하시겠습니까?')){
				a.href='${contextPath}/admin/qna/remove?qnaNo=' + $(a).data('qna_no');
			}
		}
	</script>		

</section>


<footer id="footer">
	<div id="footer_box">
		<%@ include file="../layout/footer.jsp" %>
	</div>
</footer>

</body>
</html>