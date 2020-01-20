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
	<c:when test="${reportResult == 1}">
		<script>alert("신고가 완료되었습니다.")
		window.close();
		</script>
		
	</c:when>
	<c:otherwise>
		<script>alert("신고가 정상적으로 처리되지 않았습니다.")
		window.close();
		</script>
		
	</c:otherwise>
</c:choose>
</body>
</html>