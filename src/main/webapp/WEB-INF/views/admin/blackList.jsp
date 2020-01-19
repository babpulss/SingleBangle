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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
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
    border: 1px solid black;
}

.bRow>span:first-child {
    flex-grow: 2;
}

.bRow>span:nth-child(2) {
    flex-grow: 1;
}

.bRow>span:nth-child(3) {
    flex-grow: 6;
}

.bRow>span:last-child {
    flex-basis: 300px;
}

.bRow:last-child {
	border-radius: 0 0 10px 10px;
	background-color: #e05252;
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
}
</style>
</head>
<body>
	<h1>블랙리스트</h1>
	<div class="list">
		<a href="${pageContext.request.contextPath}/">사용자 페이지 메인</a> <a
			href="${pageContext.request.contextPath}/admin">관리자 페이지 메인</a> <a
			href="${pageContext.request.contextPath}/admin/viewBlackList">블랙리스트
			조회</a> <a href="${pageContext.request.contextPath}/admin/viewReporting">신고접수
			확인 조회</a>
	</div>
	<!-- 	결과물 출력 섹션 -->
	<div id="board">
		<div id="bHeader" class="bRow">
			<span>아이디</span> 
			<span>차단 시행 날짜</span> 
			<span>차단 사유</span> 
			<span>
				<span id="searchById">아이디로 검색:</span> <input type="text" id="input">
				<button id="search">검색</button>
			</span>
		</div>
		<c:choose>
			<c:when test="${!empty list }">
				<c:forEach items="${list}" var="i">
					<div class="bRow">
						<span>${i.id}</span> 
						<span>${i.addedDate}</span> 
						<span>${i.reason} </span>
						<span>
						<button class="unblock" name="${i.id}">차단 해제</button>
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
		<div class="bRow" style="height: 50px">
		</div>
	</div>

	<script>
		$(".unblock").click(function() {
			var target = $(this);
			var id = $(this).attr("name");
			$.ajax({
				url: "/admin/unblock",
				type: "POST",
				data: { id: id }
			}).done(function(e) {
				if (e) $(target).parent().remove();
				else alert('error occured');
			}).fail(() => { console.log(e);	});
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
				$("#results").children().remove();
				$.ajax({
					url: "/admin/searchByBlockedId",
					type: "POST",
					dataType: "json",
					data: {id: id}
				}).done(res => {
					$.each(res, (i, j) => {
						var element = '<span>' + j.id + '||</span>' +
										'<span>' + j.addedDate + '||</span>' +
										'<span>' + j.reason + '||</span>' + 
										'<button class="unblock" name=' + j.id + '>차단 해제</button><br>';
						console.log(element);
						$("#results").append(element);
					});
				}).fail(() => console.log("failed")
				)
			}
		});
	</script>
</body>
</html>