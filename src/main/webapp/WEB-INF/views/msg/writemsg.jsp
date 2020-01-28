<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
</head>
<body>
<form action="replyMsgProc.do" id="frm" method="post">
	<div style="margin: auto; font-family: BMHANNAAir;">
		<div>받는사람 : <input style="border:none; font-family: BMHANNAAir; font-size: 15px" type="text" name="receiver" value="${receiver }" readonly></div>
		<div>제목 : <input type="text" id="title" name="title" style="width: 70%; border: none; border-bottom: 1px solid black;"></div>
		<div>내용</div>
		<div>
		<textarea style="resize:none;" id="contents" name="contents" rows="20px" cols="58px"></textarea>
		</div>
		<div style="text-align: right;">
		<button id="send" type="button" style="border: none; font-family: BMHANNAAir; width: 55px; height: 30px; border-radius: 10px;">보내기</button></div>
	</div>
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
			
		});
		
		 $("#title").on("focusout",function(){
	    	  var regex = /^[a-z가-힣ㄱ-ㅎ0-9!@#$%^&*(.)(-)_=(+)].{0,50}$/;
	    	  var data = $("#title").val();
	    	  var result = regex.exec(data);
	    	  if($("#title").val() != "" && result == null){
	    		  $("#title").val("");
	    		  alert("사용가능한 글자수를 초과하였습니다 \n 제목은 최대 50자까지 사용가능합니다.");
	    	  }
	      });
	</script>
</body>
</html>