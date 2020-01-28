<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>re마켓</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <link rel="stylesheet" href="/css/footer.css">
</head>
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
            text-align: center;
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
<body>
<form action="reportProc.do" method="post" id="frm">
	<div>
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
		<button id="btn" style="border: none; width: 55px; height: 30px; border-radius: 10px;">신고하기</button>
		<button id="cancel" style="text-algin: center; border: none; width: 50px; height: 30px; border-radius: 10px;" type="button">취소</button></div>
	</div>
	</form>
	<jsp:include page="/resources/jsp/footer.jsp" />
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