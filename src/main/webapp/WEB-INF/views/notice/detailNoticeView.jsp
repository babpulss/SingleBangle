<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.title}</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
<style>
#bHeader {
	background-color: #0085cb;
	border-radius: 10px 10px 0 0;
	height: 40px;
	margin-top: 80px;
}

#bTitles {
	border-bottom: 1px dotted black;
	margin-top: 20px;
	margin-bottom: 20px;
	padding-bottom: 20px;
}

#bTitles span:first-child {
	margin-left: 10px;
	width: 75%;
	display: inline-block;
	text-align: center;
}

#bTitles span:last-child {
	width: 20%;
	display: inline-block;
	text-align: right;
}

#title {
	border: none;
	border-bottom: 1px solid black;
	width: 80%;
	margin-bottom: 10px;
}

#content {
	border: 1px solid #dce3e8;
	padding: 10px 10px 10px 10px;
}

#bFooter {
	border-radius: 0 0 10px 10px;
	background-color: #dce3e8;
	height: 20px;
}

#btns {
	margin: 20px 110px 0 110px;
	display: flex;
	justify-content: space-between;
}

#btns>button, #btns>div>button {
	border: none;
	width: 50px;
	height: 30px;
	border-radius: 10px;
	margin-right: 20px;
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
@media ( max-width : 600px ) {
	#bHeader {
		border-radius: 0;
	}
	#bFooter {
		border-radius: 0;
	}
}
</style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
	<div id="mainWrapper">
		<div id="bHeader"></div>
		<div id="bTitles">
			<span>${dto.title}</span><span>${dto.writeDate}</span>
		</div>
		<div id="content">${dto.contents }</div>
		<div id="bFooter"></div>
	</div>
   <div id="btns">
        <button type="button" onclick="history.back()">목록</button>
        <c:if test="${loginInfo.adminCheck eq \"Y\"}">
        <button id="modify" type="button">수정</button>
        <button type="button" onclick="location.href='/notice/deleteNotice?seq=${dto.seq}'">삭제</button>
        <script>
			$("#modify").on('click', function() {
				location.href="/notice/tryUpdateNotice?seq=${dto.seq}";
			});
        </script>
        </c:if>
   </div>
</body>
</html>