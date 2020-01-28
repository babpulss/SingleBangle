<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쪽지</title>
<link rel="stylesheet" href="/css/nav.css"/>
<link rel="stylesheet" href="/css/index/index.css"/>
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
            height: 50px;
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
<jsp:include page="/resources/jsp/nav.jsp"/>

<div id="board" style="width: 500px; height: 57vh; margin: auto; position: relative; top: 65px;">
<div style="height: 20px; display: table; padding: 10px;">
<div style="float: left; display: table-cell; height: inherit; vertical-align: middle; font-weight: bold"><p>받은쪽지함 | </p></div>
<div style="float: left; height: inherit; vertical-align: middle;">
<button type="button" style="border: none; background-color: transparent; font-size: 16px;" id="sendbox">&nbsp 보낸쪽지함</button></div>
</div>
<div id="bHeader" class="bRow">
            <div style="width:50%; float:left">보낸사람</div>
            <div style="width:50%; float:left">제목</div>
        </div>
<c:choose>
	<c:when test="${list.size() == 0 }">
		<div class="bRow" style="margin: auto;"><p style="position: relative; left: 35%;">쪽지함이 비어있습니다.</p></div>
	</c:when>
	<c:otherwise>
	<c:forEach items="${list }" var="list">
		<div class="bRow">
		<div style="width:50%; float:left">${list.sender }</div>
		<div style="width:50%; float:left">
		<a href="${pageContext.request.contextPath }/msg/msgDetail.do?seq=${list.seq}"><c:out value="${list.title }"></c:out></a></div>
		</div>
	</c:forEach>
	</c:otherwise>
</c:choose>
 <div class="bRow"><div style="margin: auto;">${navi }</div></div>
</div>
<div>${navi }</div>
<jsp:include page="/resources/jsp/footer.jsp" />
<script>
		$("#sendbox").on("click", function(){
		location.href="${pageContext.request.contextPath }/msg/sendMsg.do?sender=${receiver}";
		})
</script>
</body>
</html>