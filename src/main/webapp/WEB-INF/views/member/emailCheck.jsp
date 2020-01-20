<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>이메일 인증</title>

<style>
#emailCheckContainer{
	text-align: center;
	width: 500px;
	height: 300px;
	margin: auto;
	padding: 10px;
	background-color: #e0e0e0;
}
#inputKey{
	text-align: center;
	width: 250px;
	height: 30px;
}
#checkBtn{
	width: 100px;
	height: 30px;
	border: none;
	border-radius: 5px;
	color: white;
	background-color: #0085cb;
}
</style>
</head>
<body>
	<div id="emailCheckContainer">
		<br><br>이메일로 전송된 인증번호를 입력하세요 <br><br>
		<input type="text" id="inputKey"><br><br><br>
		<button type="button" id="checkBtn">확인</button>
	</div>
	
	<script>
		// 인증이 완료되기 전에는 유효성 검사가 실패하게끔 변수를 0으로 설정
		window.opener.validEmailCheck = 0;
		
		// 인증번호를 입력하여 인증받기
		$("#checkBtn").on("click", function(){
			var inputKey = $("#inputKey").val();
			var emailKey = "${emailKey}";
			
			if(inputKey == emailKey){
				alert("인증이 완료되었습니다.");
				window.opener.validEmailCheck = 1;
				window.close();
			}
			else{
				alert("인증에 실패했습니다. 다시 시도해주세요.")
				window.opener.validEmailCheck = 0;
			}	
		})
	</script>
</body>
</html>