<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${writeResult == 1 }">
		<script>alert("게시글 입력 성공~!")</script>
		</c:when>
		<c:otherwise>
		<script>alert("게시글 입력 실패ㅠ.ㅠ")</script>
		</c:otherwise>
	</c:choose>
	<button type="button" id="btnGoHome">홈으로 돌아가기</button>
	<script>
	$("#btnGoHome").on("click",function(){
		location.href="${pageContext.request.contextPath}/home";
	})
	</script>
</body>
</html>