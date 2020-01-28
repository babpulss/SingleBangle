<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지 사항</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css"/>
<link rel="stylesheet" href="/css/footer.css">
    <style>
        html, body { margin: 0px; padding: 0px;}
        * {
             box-sizing: border-box; 
            font-family: 'BMHANNAAir';
        }
        #board {
            margin: 80px 110px 0 110px;
        }
        #bHeader {
            background-color: #0085cb;
            border-radius: 10px 10px 0 0;
            height: 40px;
        }
        #bHeader * {
            text-align: center;
            line-height: 40px;
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
            flex-basis: 20%;
        }
        .bRow>span:nth-child(2) {
            flex-basis: 60%;
        }
        .bRow a {
            text-decoration: none;
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
            justify-content: flex-end;
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
            .bRow {
            	border-bottom: 1px solid #dce3e8;
            }
            .bRow>span:first-child {
                display: none;
            }
			.bRow>span:nth-child(2) {
				flex-basis: 80%;
				font-size: 12px;	
			}
			.bRow>span:last-child {
				flex-basis: 20%;
				font-size: 7px;
			}
            #btns {
                margin: 20px 0 0 0;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
   <div id="board">
        <div id="bHeader">
        	<h1>공지 사항</h1>
        </div>
        <c:forEach items="${list}" var="i">
        <div class="bRow">
            <span>${i.seq}</span>
            <span><a href="/notice/readNotice?seq=${i.seq}">${i.title}</a></span>
            <span>${i.writeDate}</span>
        </div>
        </c:forEach>
        <div class="bRow" style="height:20px"></div>
   </div> 
   <c:if test="${loginInfo.adminCheck eq \"Y\"}">
   <div id="btns">
		<button type="button" onclick="location.href='/notice/writeNotice'">글쓰기</button>
   </div>
   </c:if>
<jsp:include page="/resources/jsp/footer.jsp"/>
</body>
</html>