<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${stat > 0}">
			<script type="text/javascript">
				alert("삭제 성공")
				location.href = "/house/houseMain"
			</script>
		</c:when>
		<c:otherwise>
			<script type="text/javascript">
				alert("잘못된 접근입니다.")
				location.href = "/house/houseMain";
			</script>
		</c:otherwise>
	</c:choose>
</body>
</html>