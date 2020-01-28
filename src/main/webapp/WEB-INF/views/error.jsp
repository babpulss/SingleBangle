<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css" />
<link rel="stylesheet" href="/css/footer.css">
</head>
<body>
	<jsp:include page="/resources/jsp/nav.jsp" />
	<div id="mainWrapper">
		<div style="width: 500px; margin: auto;">
			<img src="/img/temporary_error_sign.png" width=500px height=200px><br>
			<h1>에러 발생</h1>
			<br>
			<h1>관리자에게 문의하세요</h1>
			<br> <a href="${pageContext.request.contextPath}/">초기화면으로 가기</a>
		</div>
	</div>
	<jsp:include page="/resources/jsp/footer.jsp" />
</body>
</html>