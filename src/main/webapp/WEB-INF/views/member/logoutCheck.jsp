<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<script>
		alert("로그아웃 되었습니다.");
		location.href="${pageContext.request.contextPath}/memberHome";
	</script>
</body>
</html>