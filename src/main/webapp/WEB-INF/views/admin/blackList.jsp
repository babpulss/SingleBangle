<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>블랙리스트 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/css/nav.css">
<style>
/* 메뉴 폰트 */
* :not ( .rightSidebar ) { box-sizing : border-box ; font-family : ' BMHANNAAir '; }
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
	flex-shrink: unset;
}

.bRow>span:nth-child(4) {
	flex-basis: 10%;
}

.bRow>span:last-child {
	flex-basis: 400px;
}

.bRow:last-child {
	border-radius: 0 0 10px 10px;
}

#input {
	height: 25px;
	margin: 5px 0 5px 0;
	text-align: left;
}

.bRow button {
	line-height: 25px;
}
#mainWrapper {
	margin-top: 80px;
	font-family: 'BMHANNAAir';
}

#viewDashBoard, #viewReporting {
	width: 200px;
	height: 40px;
	border: 1px solid black;
	position: relative;	
	overflow: hidden;
	cursor: pointer;
	text-align: center;
}
#viewDashBoard>a, #viewReporting>a {
	position: relative;
	z-index: 2;
	text-decoration: none;
	line-height: 40px;
	color: black;
}
#view1 {
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
#viewDashBoard:hover #view1{
	right: 0;
}
#viewReporting:hover #view2{
	left: 0;
}
#viewDashBoard:hover>a, #viewReporting:hover>a {
	transition: .5s ease;
	color: red;
}
#btns {
	display: flex;
	margin-left: 10px;
}

@media ( max-width : 650px ) {
	#board {
		margin: 65px 0 0 0;
	}
	#bHeader {
		border-radius: 0;
	}
	#bHeader input {
		width: 100px;
	}
	.bRow>span:last-child {
		flex-basis: 150px;
	}
	#searchById {
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
	<jsp:include page="/resources/jsp/nav.jsp" />
<c:choose>
<c:when test="${empty loginInfo}">
	<script>
		location.href= "/";
	</script>
</c:when>
<c:otherwise>
	<div id="mainWrapper">
		<div class="list">
			<div id="btns">
				<div id="viewDashBoard">
					<div id="view1"> </div>
					<a href="#">대쉬보드 조회</a>
				 </div>
				<div id="viewReporting">
					<div id="view2"></div>
					<a href="#">신고접수 확인 조회</a>
				 </div>
			 </div>
			<div style="text-align: center">
				<br> 회원 목록에서 아이디로 검색: <input type="text" id="searchId">
				<button type="button" id="searchIdBtn">회원 찾기</button>
			 </div>
		</div>
		<h1>블랙리스트</h1>
		<!-- 	결과물 출력 섹션 -->
		<div id="board">
			<div id="bHeader" class="bRow">
				<span>아이디</span> <span>차단 시행 날짜</span> <span>차단 사유</span> <span>해지까지
					남은 시간</span> <span> <span id="searchById">아이디로 검색:</span> <input
					type="text" id="input">
					<button id="search">검색</button>
				</span>
			</div>
			<c:choose>
				<c:when test="${!empty list}">
				<div id="bContents">
				<c:forEach items="${list}" var="i">
				<div class="bRow">
							<span>${i.id}</span> <span>${i.addedDate}</span> <span>${i.reason}
							</span> <span>${i.blockTime}시간 남음 </span> <span>
								<button class="unblock" name="${i.id}">차단 해제</button>
							</span>
				</div>
					</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<div class="bRow" style="display: flex; justify-content: center">
						<span>게시물이 없습니다</span>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="bRow" style="height: 50px; background-color:#e05252;"></div>
	</div>

	<script>
	$("#viewDashBoard").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin";
	});
	$("#viewReporting").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewReporting";
	});
			var idArr = [
				<c:forEach items="${list}" var="i">
					"${i.id}",
				</c:forEach>
			];
			$("#input").autocomplete({
				source: idArr,
				focus: function(e, ui) {
					   return false;
				}
		});
		$("#search").on("click", () => {
			var id = $("#input").val();
			if (id != "") {
				$(".bContents").children().remove();
				$.ajax({
					url: "/admin/searchByBlockedId",
					type: "POST",
					dataType: "json",
					data: {id: id}
				}).done(res => {
					$("#bContents").children().remove();
					var btn = '<button class="unblock" name=" + ' + res.id + '">차단 해제</button>'
					var element = '<div class="bRow"><span>' + res.id + '</span>' +
					'<span>' + res.addedDate + '</span>' +
					'<span>' + res.reason + '</span>' +
					'<span>' + res.blockTime + '</span>' +
					'<span>' + btn + '</span></div>';
					
					$("#bContents").append(element);
				})
			}
		});
	$("#searchIdBtn").click(() => {
		var id = $("#searchId").val();
		window.open("/admin/searchId?id=" + id, "_blank", "width=500px, height=500px, resizable=no");
	});

	$(".unblock").click(function() {
		var conf = confirm("차단을 해제합니까?");
		if (conf) {
			var target = $(this);
			var id = $(this).attr("name");
			$.ajax({
				url: "/admin/unblock",
				type: "POST",
				data: { id: id }
			}).done(function(e) {
				if (e) $(target).closest("div").remove();
				else alert('error occured');
			}).fail(() => { console.log(e);	});
		}
		});
		
		
	</script>

</c:otherwise>
</c:choose>
</body>
</html>