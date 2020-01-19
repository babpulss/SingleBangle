<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고접수 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
	justify-content: space-between;
	align-items: center;
}

.bRow * {
	line-height: 50px;
	text-align: center;
}

.bRow>span:first-child {
	flex-grow: 1;
}

.bRow>span:nth-child(2) {
	flex-grow: 2;
}

.bRow>span:nth-child(3) {
	flex-grow: 5;
	flex-basis: 200px;
}

.bRow a {
	text-decoration: none;
}

.bRow>span:nth-child(4) {
	flex-grow: 1;
}

.bRow>span:last-child {
	flex-grow: 1;
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
<h1>신고리스트</h1>
	<div class="list">
		<a href="${pageContext.request.contextPath}/">사용자 페이지 메인</a>
		<a href="${pageContext.request.contextPath}/admin">관리자 페이지 메인</a>
		<a href="${pageContext.request.contextPath}/admin/viewBlackList">블랙리스트 조회</a>
		<a href="${pageContext.request.contextPath}/admin/viewReporting">신고접수 확인 조회</a>
	</div>
	<!-- 	결과물 출력 섹션 -->
   <div id="board">
		<div id="bHeader" class="bRow">
			<span>아이디</span> 
			<span>신고 접수 날짜</span> 
			<span>신고 사유</span> 
			<span>신고 URL</span> 
			<span> 
				<span id="searchById">아이디로 검색:</span> <input type="text" id="input">
				<button id="search">검색</button>
			</span>
		</div>
		<c:choose>
			<c:when test="${!empty list}">
				<c:forEach items="${list}" var="i">
					<div class="bRow">
						<span>${i.id}</span> <span>${i.reportingDate}</span> <span>${i.reason}</span>
						<span><a href="${i.url}" target="_blank">해당 URL로 이동</a> ||</span>
						<button class="unblock" name="${i.seq}">접수 완료</button>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="bRow">
					<span>게시물이 없습니다</span>
				</div>
			</c:otherwise>
		</c:choose>
		<div class="bRow">
		</div>
	</div>

		<script>
		$(".unblock").on("click", function() {
			var target = $(this);
			var seq = $(this).attr("name");
			$.ajax({
				url: "/admin/confirmReporting",
				type: "POST",
				data: { seq: seq }
			}).done(function(e) {
				if (e) $(target).parent().remove();
				else alert('error occured');
			}).fail(() => { console.log(e);	});
		});
	</script>
</body>
</html>