<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>re마켓</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <link rel="stylesheet" href="/css/footer.css">
</head>
<style>
	@font-face {
	font-family: 'BMHANNAAir';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/MapoPeacefullA.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
	
}
</style>
<body>
<form action="reportProc.do" method="post" id="frm">
	<div style="font-family: 'BMHANNAAir';">
		<div style="font-weight: bold; height: 30px; font-size: 20px">신고하기</div>
		<div>신고자 : <input style="border:none" type="text" name="id" value="${id }"></div>
		<div>&nbsp</div>
		<div style="font-weight: bold; border-top: 1px solid #c3c3c3"><br>사유선택</div>
		<div style="border-bottom: 1px solid #c3c3c3">
		<input type="hidden" name="reportedUrl" value="${reportedUrl}">
		<input type="radio" name="reason" value="전문판매업자"/>전문판매업자<br>
		<input type="radio" name="reason" value="판매금지물품"/>판매금지물품<br>
		<input type="radio" name="reason" value="부적절한 글"/>부적절한 글<br>
		<input type="radio" name="reason" value="기타"/>기타
		<br>
		</div>
		<br><div style="position: relative; left: 35%;">
		<button id="btn" style="border: none; width: 65px; height: 30px; padding: 0; border-radius: 10px;">신고하기</button>
		<button id="cancel" style="text-algin: center; border: none; width: 50px; height: 30px; border-radius: 10px;" type="button">취소</button></div>
	</div>
	</form>
	<script>
		$("#btn").on("click", function(){
			$("#frm").submit();
			alert("신고가 정상적으로 접수되었습니다.");
			window.close();
		})
		
		$("#cancel").on("click", function(){
			window.close();
		})
	</script>
</body>
</html>