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
		<tr><td>받는사람 : <input style="border:none" type="text" name="receiver" value="${receiver }" readonly><td></tr>
		<tr><td>제목 : <input type="text" id="title" name="title"></tr>
		<tr><td>내용
		<tr><td>
		<textarea style="resize:none;" id="contents" name="contents" rows="20px" cols="50px"></textarea>
		</tr>
		<tr><td><button id="send" type="button">보내기</button></tr>
	</table>
	</form>
	
	<script>
		$("#send").on("click", function(){
			if($("#title").val() != "" && $("#contents").val() != ""){
				$("#frm").submit();
				alert("쪽지가 성공적으로 전송되었습니다.");
				window.close();
			}else{
				alert("내용을 모두 입력해 주세요");
			}
			
		})
	</script>
</body>
</html>