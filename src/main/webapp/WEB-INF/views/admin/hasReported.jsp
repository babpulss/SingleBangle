<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고접수 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
	<div id="screen">
		<div>
			<span>아이디 ||</span>
			<span>신고 접수 날짜 ||</span>
			<span>신고 사유 ||</span>
			<span>신고 URL ||</span>
			아이디로 검색: <input type="text" id="input"> <button id="search">검색</button>
		</div>
		<div id="results">
		<c:forEach items="${list}" var="i">
				<span>${i.id} ||</span>
				<span>${i.reportingDate} ||</span>
				<span>${i.reason} ||</span>
				<span><a href="${i.url}" target="_blank">해당 URL로 이동</a> ||</span>
				<button class="unblock" name="${i.seq}">접수 완료</button>
		</c:forEach>
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