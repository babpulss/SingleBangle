<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ea7c69cd1bf56d37c0df13609580d2bd&libraries=services"></script>
<title>혼밥/혼술</title>

<link rel="stylesheet" href="/css/nav.css">
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

html, body {
	margin: 0px;
	padding: 0px;
}

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
	flex-basis: 50%;
	text-align: left;
}

.bRow>span:nth-child(3) {
	flex-basis: 20%;
}

.bRow a {
	text-decoration: none;
}

.bRow>span:last-child {
	flex-basis: 20%;
}

.bRow:last-child {
	border-radius: 0 0 10px 10px;
	background-color: #e05252;
}

#btns {
	margin: 20px 110px 0 110px;
	display: flex;
	justify-content: flex-start;
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

#viewDashBoard, #viewBlackList, #viewReporting {
	width: 200px;
	height: 40px;
	border: 1px solid black;
	position: relative;
	overflow: hidden;
	cursor: pointer;
	text-align: center;
}

#viewDashBoard>a, #viewBlackList>a, #viewReporting>a {
	position: relative;
	z-index: 2;
	text-decoration: none;
	line-height: 40px;
	color: black;
}

.view1 {
	position: absolute;
	width: 200px;
	height: 40px;
	right: -200px;
	background-color: black;
	transition: all .5s ease;
}

#view2 {
	position: absolute;
	width: 200px;
	height: 40px;
	left: -200px;
	background-color: black;
	transition: all .5s ease;
}

#viewDashBoard:hover .view1 {
	right: 0;
}

#viewReporting:hover .view1 {
	right: 0;
}

#viewBlackList:hover #view2 {
	left: 0;
}

#viewDashBoard:hover>a, #viewBlackList:hover>a, #viewReporting:hover>a
	{
	transition: .5s ease;
	color: red;
}

@media ( max-width : 600px ) {
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
	<jsp:include page="/resources/jsp/nav.jsp" />

	<br>
	<br>
	<br>
	<div id="mainWrapper">
		<div class="list">
			<div id="btns">
				<div id="viewDashBoard">
					<div class="view1"></div>
					<a href="#">대쉬보드 조회</a>
				</div>
				<div id="viewBlackList">
					<div id="view2"></div>
					<a href="#">블랙리스트 조회</a>
				</div>
				<div id="viewReporting">
					<div class="view1"></div>
					<a href="#">신고접수 확인 조회</a>
				</div>
			</div>
		</div>
		<div id="board">
			<div id="bHeader" class="bRow">
				<span>번호</span> <span>제목</span> <span>작성자</span> <span>작성일</span>
			</div>

			<c:forEach items="${list}" var="dto">
				<div class="bRow">
					<span>${dto.seq}</span> <span><a
						href="${pageContext.request.contextPath}/restaurant/rstDetail.rst?seq=${dto.seq}">${dto.title}</a></span>
					<span>${dto.writer}</span> <span>${dto.getFormedDate1()}</span>
				</div>
			</c:forEach>

			<div class="bRow" style="height: 20px"></div>
		</div>
		<div id="btns">
			<button type="button" style="color: white; background-color: white;">목록</button>
			<div>
				<input type="text" placeholder="search">
				<button type="button" id="searchBtn">검색</button>
			</div>
			<button type="button" id="writeBtn"
				style="color: white; background-color: white;">글쓰기</button>
		</div>
	</div>

	<script>
	$("#viewBlackList").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewBlackList";
	});
	$("#viewReporting").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewReporting";
	});
	$("#viewDashBoard").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin";
	});
        </script>
</body>
</html>