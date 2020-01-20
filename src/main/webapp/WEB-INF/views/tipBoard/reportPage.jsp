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
	<form action="reportProc.bo" method="post" id="reportForm">
		신고할 글: <input type="text" value="${url}" name="url" readonly="readonly" style="width:250px"><br>
		신고사유 : <textarea name="reason"></textarea><br>
		신고자: <input type="text" value="${loginInfo.id}" name="reporter"><br>
	<button type="submit">신고</button>
	<button type="button">취소</button>
	</form>
</body>
</html>