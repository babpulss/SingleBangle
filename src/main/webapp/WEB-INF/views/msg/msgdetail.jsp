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
	<div style="width:300px; margin: auto">
		<form action="${pageContext.request.contextPath }/msg/msgList.do">
		<input type="hidden" name="receiver" value="${dto.receiver }">
		<div style="width: 40%; float: left">발신자 : </div><div style="width: 60%; float: left">${dto.sender }</div>
		<div style="width: 40%; float: left">제목 : </div><div style="width: 60%; float: left">${dto.title }</div>
		<div style="width: 40%; float: left">내용 : </div><div style="width: 60%; float: left">${dto.contents }</div>
		<div style="width: 50%; float: left"><button type="button" id="reply">답장하기</button>
		</div><div style="width: 50%; float: left"><button id="back">뒤로가기</button></div>
		</form>
	</div>
	
	<script>
		$("#reply").on("click", function(){
			location.href="${pageContext.request.contextPath }/msg/writeMsg.do?receiver=${dto.sender }"
		})
	</script>
</body>
</html>