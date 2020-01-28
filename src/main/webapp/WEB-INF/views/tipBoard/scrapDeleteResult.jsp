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
		<c:when test="${scrapDeleteResult == 1 }">
			<script>alert("스크랩 취소되었습니다.")
		location.href="${pageContext.request.contextPath}/member/myPage.mem";
		</script>
		</c:when>
		<c:otherwise>
			<script>alert("스크랩 취소 실패ㅠ.ㅠ")
		location.href="${pageContext.request.contextPath}/member/myPage.mem";
		</script>
		</c:otherwise>
	</c:choose>
</body>
</html>