<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<script>
	<c:if test="${result < 0}">
			alert("오류 발생, 다시 시도해 주세요");
	</c:if>
			location.href= "/notice";
	</script>
</body>
</html>