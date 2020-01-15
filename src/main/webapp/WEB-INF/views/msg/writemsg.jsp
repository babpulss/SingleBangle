<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
<form action="replyMsgProc.do" id="frm" method="post">
	<table>
		<tr><td>받는 사람 : <input type="text" name="receiver" value="${receiver }" readonly><td></tr>
		<tr><td>제목 : <td><input type="text" name="title"></tr>
		<tr><td>내용 : <td><input type="text" name="contents"></tr>
		<tr><td><button id="send" type="button">보내기</button></tr>
	</table>
	</form>
	
	<script>
		$("#send").on("click", function(){
			$("#frm").submit();
			window.close();
		})
	</script>
</body>
</html>