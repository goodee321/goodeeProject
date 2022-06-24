<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="../resources/js/jquery-3.6.0.js"></script>
<script>
	$(function(){
	
		$('.reply_link').on('click', function(){
			$('.reply_form').addClass('blind');
	    	$(this).parent().parent().next().removeClass('blind');
		})
	
	})
</script>
<style>
	.blind {
		display: none;
	}
</style>
</head>
<body>

	대충이미지

	<hr>

	<h1>Q&A</h1>
	
	<!-- 로그인만 가능 -->
	<a href="${contextPath}/qna/saveQna">글쓰기</a><br>

		<table>
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
						<td colspan="5">첫 게시글을 작성해 주세요.</td>
					</tr>
				</c:if>
				<c:if test="${not empty qnas}">
					<c:forEach var="qna" items="${qnas}">
						<c:if test="${qna.qnaState == -1}">
							<tr>
								<td>${totalRecord - qna.qnaNo + 1}</td>
								<td colspan="4">삭제된 게시글입니다</td>
							</tr>
						</c:if>
						<c:if test="${qna.qnaState == 1}">
							<tr>
								<td>${totalRecord - qna.qnaNo + 1}</td>
								<td>
									<c:forEach begin="1" end="${qna.qnaDepth}" step="1">&nbsp;&nbsp;</c:forEach>
									
									<c:if test="${qna.qnaDepth gt 0}"><i class="fa-brands fa-replyd"></i></c:if>
									<!-- 제목 -->
									<c:if test="${qna.qnaTitle.length() gt 20}">
										<a href="${contextPath}/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle.substring(0, 20)}</a>
									</c:if>
									<c:if test="${qna.qnaTitle.length() le 20}">								
										<a href="${contextPath}/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
									</c:if>
								</td>
								<td>${qna.qnaContent}</td>
								<td>${qna.id}</td>
								<td>
									${qna.qnaDate}
									<!-- 답글달기(if 있으면 1단 댓글만 허용, if 없으면 다단 댓글 허용) -->
									
									<c:if test="${qna.qnaDepth eq 0}">
										<a class="reply_link">답글</a>								
									</c:if>
								</td>
								<td>
									<!-- 삭제버튼c:if test=qna.id == member.id || qna.id == 관리자/c:if -->
										<a href="${contextPath}/qna/remove?qnaNo=${qna.qnaNo}" onclick="fnRemove(this)">
											<i class="fa-solid fa-trash-can"></i>
										</a>
								</td>
							</tr>
							<tr class="reply_form blind">
								<td colspan="5">
									<form action="${contextPath}/qna/saveReply" method="post">
										<input type="text" name="id" value="${qna.id}" size="4" readonly="readonly">
										<input type="text" name="qnaContent" placeholder="내용" size="40">
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
					<td colspan="4">
						${paging}
					</td>
				</tr>
			</tfoot>
		</table>
		
	<script>
		function fnRemove(a) {
			if(confirm('게시글을 삭제할까요?')){
				a.href='${contextPath}/qna/remove?qnaNo=' + $(a).data('qna_no');
			}
		}
	</script>		



</body>
</html>