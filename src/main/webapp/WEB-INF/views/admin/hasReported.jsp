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
<link rel="stylesheet" href="/css/nav.css">
<link rel="stylesheet" href="/css/footer.css">
<style>
/* 메뉴 폰트 */

html, body {
	margin: 0px;
	padding: 0px;
}

*:not (.rightSidebar ) {
	box-sizing: border-box;
	font-family: 'BMHANNAAir';
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
    flex-basis: 10%;
}

.bRow>span:nth-child(3) {
    flex-basis: 50%;
}

.bRow a {
	text-decoration: none;
}

.bRow>span:nth-child(4) {
    flex-basis: 20%;
    flex-shrink: unset;
}

.bRow>span:last-child {
    flex-basis: 10%;
}

.bRow button {
	line-height: 25px;
}

.bRow:last-child {
	border-radius: 0 0 10px 10px;
	background-color: #dce3e8;
}

#mainWrapper {
	margin-top: 80px;
	font-family: 'BMHANNAAir';
}

#viewDashBoard, #viewBlackList, #viewRestaurant {
	width: 200px;
	height: 40px;
	border: 1px solid black;
	position: relative;	
	overflow: hidden;
	cursor: pointer;
	text-align: center;
}
#viewDashBoard>a, #viewBlackList>a, #viewRestaurant>a {
	position: relative;
	z-index: 2;
	text-decoration: none;
	line-height: 40px;
	color: black;
}
.view1 {
	position:absolute;
	width: 200px;
	height: 40px;
	right: -200px;	
	background-color: black;
	transition: all .5s ease;
}
#view2 {
	position:absolute;
	width: 200px;
	height: 40px;
	left: -200px;	
	background-color: black;
	transition: all .5s ease;
}
#viewDashBoard:hover .view1{
	right: 0;
}
#viewRestaurant:hover .view1{
	right: 0;
}
#viewBlackList:hover #view2{
	left: 0;
}
#viewDashBoard:hover>a, #viewBlackList:hover>a, #viewRestaurant:hover>a {
	transition: .5s ease;
	color: red;
}
#btns {
	display: flex;
	margin-left: 10px;
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
		margin: 0;
		transition: all 2s ease-in-out;
	}
}
</style>
</head>
<body>
<c:choose>
<c:when test="${loginInfo.adminCheck eq \"Y\"}">
<jsp:include page="/resources/jsp/nav.jsp"/>
	<div id="mainWrapper">
		<div class="list">
			<div id="btns">
				<div id="viewDashBoard">
					<div class="view1"> </div>
					<a href="#">대쉬보드 조회</a>
				 </div>
				<div id="viewBlackList">
					<div id="view2"></div>
					<a href="#">블랙리스트 조회</a>
				 </div>
				<div id="viewRestaurant">
					<div class="view1"></div>
					<a href="#">혼밥/혼술 게시물 관리</a>
				 </div>
			 </div>
		</div>
		<h1>신고리스트</h1>
		<!-- 	결과물 출력 섹션 -->
		<div id="board">
			<div id="bHeader" class="bRow">
				<span>아이디</span> <span>신고 접수 날짜</span> <span>신고 사유</span> <span>신고
					URL</span> <span>접수 완료 여부</span>
			</div>
			<c:choose>
				<c:when test="${!empty list}">
					<c:forEach items="${list}" var="i">
						<div class="bRow">
							<span>${i.id}</span> <span>${i.reportingDate}</span> 
							<span><c:choose>
							<c:when test="${i.reason == '1'}">영리목적/홍보성</c:when>
							<c:when test="${i.reason == '2'}">불법정보</c:when>
							<c:when test="${i.reason == '3'}">음란성/선정성</c:when>
							<c:when test="${i.reason == '4'}">욕설/인신공격</c:when>
							<c:when test="${i.reason == '5'}">개인정보노출</c:when>
							<c:otherwise>같은 내용의 반복 게시 (도배)</c:otherwise>
							</c:choose></span>
							<span> <a href="${i.reportedUrl}" target="_blank">URL로
									이동(${i.reportedUrl})</a>
							</span> <span>
								<button class="unblock" name="${i.seq}">접수 완료</button>
							</span>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="bRow">
						<span>게시물이 없습니다</span>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="bRow" style="height: 50px"></div>
		</div>
	</div>

	<script>
	$("#viewDashBoard").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin";
	});
	$("#viewBlackList").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewBlackList";
	});
	$("#viewRestaurant").on("click", function() {
		location.href="${pageContext.request.contextPath}/restaurant/rstListN.rst";
	});
		$(".unblock").on("click", function() {
			var conf = confirm("신고요청완료하시겠습니까?");
			if (conf) {
				var target = $(this);
				var seq = $(this).attr("name");
				$.ajax({
					url: "/admin/confirmReporting",
					type: "POST",
					data: { seq: seq }
				}).done(function(e) {
					if (e) $(target).closest("div").remove();
					else alert('error occured');
				}).fail(() => { console.log(e);	});
			}
		});
	</script>

</c:when>
<c:otherwise>
	<script>
		location.href= "/";
	</script>
</c:otherwise>
</c:choose>
<jsp:include page="/resources/jsp/footer.jsp"/>
</body>
</html>