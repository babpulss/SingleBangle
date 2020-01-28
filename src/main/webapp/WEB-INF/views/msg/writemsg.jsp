<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
	
        html, body { margin: 0px; padding: 0px;}
        * {
             box-sizing: border-box; 
            font-family: 'BMHANNAAir';
        }
        #board {
            margin: 65px 110px 0 110px;
        }
        #bHeader {
            background-color: #0085cb;
            border-radius: 10px 10px 0 0;
        	line-height: 50px;
        }
        .bRow {	
            display: flex;
            justify-content: flex-start;
            align-items: center;
        }
        .bRow * {
            line-height: 50px;
            text-align: center;
        }
        .bRow>span:first-child {
            flex-basis: 10%;
        }
        .bRow>span:nth-child(2) {
            flex-basis: 20%;
        }
        .bRow>span:nth-child(3) {
            flex-basis: 50%;
            text-align: left;
        }
        .bRow a {
            text-decoration: none;
        }
        .bRow>span:nth-child(4) {
            flex-basis: 10%;
        }
        .bRow>span:last-child {
            flex-basis: 10%;
        }
        .bRow:last-child {
            border-radius: 0 0 10px 10px;
            background-color: #dce3e8;
        }
        #btns {
            margin: 20px 110px 0 110px;
            display: flex;
            justify-content: space-between;
        }
        #btns>button:first-child, #btns>div>button {
            border: none;
            width: 50px;
            height: 30px;
            border-radius: 10px;
        }
        #btns>div>input {
            width: 100px;
            height: 30px;
            border-radius: 10px;
        }
        #btns>button:last-child {
            border: none;
            width: 80px;
            height: 30px;
            border-radius: 10px;
        }
        @media ( max-width: 600px ) {
            #board {
                margin: 65px 0 0 0;
            }
            #bHeader {
                border-radius: 0;
            }
            .bRow>span:first-child {
                display: none;
            }
            #btns {
                margin: 20px 0 0 0;
            }
        }
</style>
</head>
<body>
<form action="replyMsgProc.do" id="frm" method="post">
	<table>
		<tr><td>받는사람 : <input style="border:none" type="text" name="receiver" value="${receiver }" readonly><td></tr>
		<tr><td>제목 : <input type="text" id="title" name="title" style="width: 80%;"></tr>
		<tr><td>내용
		<tr><td>
		<textarea style="resize:none;" id="contents" name="contents" rows="20px" cols="55px"></textarea>
		</tr>
		<tr style="text-align: right"><td>
		<button id="send" type="button" style="border: none; width: 50px; height: 30px; border-radius: 10px;">보내기</button></tr>
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