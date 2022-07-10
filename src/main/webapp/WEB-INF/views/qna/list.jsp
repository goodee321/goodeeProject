<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
	
		$('.reply_link').on('click', function(){
			$('.reply_form').addClass('blind');
	    	$(this).parent().parent().next().removeClass('blind');
		})
	
	})
	
	function fnRemove(a) {
			if(confirm('게시글을 삭제할까요?')){
				a.href='${contextPath}/qna/remove?qnaNo=' + $(a).data('qna_no');
			}
		}
	
</script>
<style>
	.blind {
		display: none;
	}
	
	* {
		box-sizing: border-box;
	}
	.unlink, .link {
		display: inline-block; 
		padding: 10px;
		margin: 5px;
		border: 1px solid white;
		text-align: center;
		text-decoration: none;
		color: #555555;
	}
	
	.link:hover {
		color: #008bcc;
	}
	
	a:hover {
		color: #008bcc;
		text-decoration: none;
		font-weight: 600;
		
	}
	
	.title {
		font-size: 20px;
		text-align: center;
	}
	
	h1 { 
		padding-bottom: 10px; 
		font-size: xx-large;
	}
	
	.title p {
		font-size: 15px;
		display: block;
	}
	.title a {
		color: #B22222;
		font-size: 15px;
		margin: 10px;
	}
	
	
	table {
		border-collapse: collapse;
		margin: auto;
		width: 60%;
	}
	
	table caption {
		margin-bottom: 5px;
	
	}

	table a { 
		text-decoration: none; 
		color: #2E2E2E;
	}
	
	thead {
		background-color: #778899;	
	}
	
	thead td { 
		color: white; 
		font-weight: 600;
		text-align: center;
	}
	
	thead td:nth-of-type(2) { width: 230px; }
	thead td:nth-of-type(3) { width: 440px; }
	thead td:nth-of-type(4) { width: 120px; }
	
	tbody tr:nth-of-type(3) td:nth-of-type(2) { line-height: 1.5; }
	
	table td {
		padding: 5px;
		border-top: 1px solid silver;
		border-bottom: 1px solid silver;
		
	}
	
	tbody tr { height: 50px; }
	
	tbody tr:hover { 
		background-color: #F5F5F5; 
		
	}
	
	tbody tr i { text-align: right; }
	
	tfoot {
		text-align: center;
	}
	
	tfoot td {
		border-left: 0;
		border-right: 0;
		border-bottom: 0;
	}

</style>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="title">
		<h1>Q&A</h1>
		<c:if test="${loginMember.id eq null}">
		<a href="${contextPath}/member/loginPage" class="btn btn-outline-warning">로그인 후 글 작성</a>
		</c:if>
	</div>

		<table>
			<c:if test="${loginMember.id ne null}">
			<caption><a href="${contextPath}/qna/saveQna" class="btn btn-success">글쓰기</a><br></caption>
			</c:if>
			<thead>
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>내용</td>
					<td>작성자</td>
					<td>작성일</td>
					<td></td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty qnas}">
					<tr>
						<td colspan="5" class="text-center">첫 게시글을 작성해 주세요.</td>
					</tr>
				</c:if>
				<c:if test="${not empty qnas}">
					<c:forEach var="qna" items="${qnas}">
						<c:if test="${qna.qnaState == -1}">
							<tr class="text-muted">
								<td class="text-center">${qna.qnaNo}</td>
								<td colspan="2" class="text-center">관리자에 의해 삭제된 게시글입니다</td>
								<td class="text-center">${qna.id}</td>
								<td class="text-center">${qna.qnaDate}</td>
							</tr>
						</c:if>
						<c:if test="${qna.qnaState == 1}">
							<tr>
								<td class="text-center">${qna.qnaNo}</td>
								<td class="text-center">
									<c:forEach begin="1" end="${qna.qnaDepth}" step="1">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</c:forEach>
									<c:if test="${qna.qnaDepth gt 0}"><i class="fa-solid fa-comment-dots">관리자 답변</i></c:if>
									<!-- 제목 -->
									<c:if test="${qna.qnaTitle.length() gt 20}">
										<a href="${contextPath}/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle.substring(0, 20)}</a>
									</c:if>
									<c:if test="${qna.qnaTitle.length() le 20}">								
										<a href="${contextPath}/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
									</c:if>
								</td>
								<td>
									<c:if test="${qna.qnaContent.length() gt 36}">
										${qna.qnaContent.substring(0, 36)}	
									</c:if>
									<c:if test="${qna.qnaContent.length() lt 36}">
										${qna.qnaContent}
									</c:if>
								</td>
								<td class="text-center">${qna.id}</td>
								<td class="text-center">${qna.qnaDate}</td>
								<c:if test="${loginMember.id eq 'admin'}">
									<td>
									<!-- 답글달기(if 있으면 1단 댓글만 허용, if 없으면 다단 댓글 허용) -->

										<a class="reply_link">답변하기</a>								
									</td>
									<td>
										<a data-qna_no="${qna.qnaNo}" onclick="fnRemove(this)">
											<i class="fa-solid fa-trash-can"></i>
										</a>
									</td>
								</c:if>
							</tr>
							<tr class="reply_form blind">
								<td colspan="5" class="text-center">
									<form action="${contextPath}/qna/saveReply" method="post">
										<input type="text" name="id" value="${qna.id}" size="4" readonly="readonly">
										<input type="text" name="qnaContent" placeholder="답변을 작성해주세요." size="40">
										<!-- <input type="text" name="qnaDate" value="${qna.qnaDate}"> -->
										<input type="hidden" name="qnaDepth" value="${qna.qnaDepth}">
										<input type="hidden" name="qnaGroupNo" value="${qna.qnaGroupNo}">
										<input type="hidden" name="qnaGroupOrd" value="${qna.qnaGroupOrd}">
										<button class="btn btn-light">답글달기</button>
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
		
		<jsp:include page="../layout/Footer.jsp"></jsp:include>

	
</body>
</html>