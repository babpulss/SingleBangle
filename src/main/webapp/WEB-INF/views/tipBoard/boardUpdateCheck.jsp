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
		<c:when test="${updateResult == 1 }">
		<script>alert("게시글 수정 성공~!")
		location.href="${pageContext.request.contextPath}/board/boardList.bo";
		</script>
		</c:when>
		<c:otherwise>
		<script>alert("게시글 수정 실패ㅠ.ㅠ")
		location.href="${pageContext.request.contextPath}/board/boardList.bo";
		</script>
		</c:otherwise>
	</c:choose>
</body>
</html>