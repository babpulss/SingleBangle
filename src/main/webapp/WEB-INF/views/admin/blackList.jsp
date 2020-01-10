<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body>
<h1>블랙리스트</h1>
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
			<span>차단 시행 날짜 ||</span>
			<span>차단 사유 ||</span>
			아이디로 검색: <input type="text" id="input"> <button id="search">검색</button>
		</div>
		<div id="results">
		<c:forEach items="${list}" var="i">
			<span>${i.id} ||</span>
			<span>${i.addedDate} ||</span>
			<span>${i.reason} ||</span>
			<button class="unblock" name="${i.id}">차단 해제</button><br>
		</c:forEach>
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