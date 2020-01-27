<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Single Bangle</title>
<link rel="stylesheet" href="/css/nav.css"/>
<link rel="stylesheet" href="/css/index/index.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
	 /* 메뉴 폰트 */
        @font-face {
            font-family: 'BMHANNAAir';
            src:
                url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff')
                format('woff');
            font-weight: normal;
            font-style: normal;
        }
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
            background-color: #e05252;
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
<jsp:include page="/resources/jsp/nav.jsp"/>
	<div id="board" style="width: 500px; margin: auto; position: relative; top: 65px;">
		<form action="${pageContext.request.contextPath }/msg/msgList.do">
		<input type="hidden" name="receiver" value="${dto.receiver }">
		<input type="hidden" name="seq" value="${dto.seq }">
		<div id="bHeader" class="bRow">
		&nbsp
		</div>
		<div class="bRow">
		<div style="font-weight: bold; width: 40%; float: left">보낸사람 </div><div style="width: 60%; float: left">${dto.sender }</div>
		</div>
		<div class="bRow">
		<div style="font-weight: bold; width: 40%; float: left">제목 </div><div style="width: 60%; float: left">${dto.title }</div>
		</div>
		<div class="bRow">
		<div style="font-weight: bold; width: 40%; float: left">내용 </div><div style="width: 60%; float: left">${dto.contents }</div>
		</div>
		<div class="bRow">
		<div style="width: 100%; text-align: center">
		<a href="${pageContext.request.contextPath }/msg/sendMsg.do?sender=${dto.sender}">뒤로가기</a></div>
		</div>
		</form>
	</div>
	
</body>
</html>