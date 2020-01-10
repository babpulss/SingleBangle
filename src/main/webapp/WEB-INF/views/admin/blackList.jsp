<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="list">
		<a href="#">사용자 페이지 메인</a>
		<a href="#">관리자 페이지 메인</a>
		<a href="#">블랙리스트 조회</a>
		<a href="#">신고접수 확인 조회</a>
	</div>
	<!-- 	결과물 출력 섹션 -->
	<div id="screen">
		<div>
			<span>아이디 ||</span>
			<span>차단 시행 날짜 ||</span>
			<span>차단 사유 ||</span>
		</div>
		<c:forEach items="${list}" var="i">
			<div id="world">
				<span>${i.id} ||</span>
				<span>${i.addedDate} ||</span>
				<span>${i.reason} ||</span>
				<button class="unblock" id="hello">차단 해제</button>
			</div>
		</c:forEach>
	</div>
	
	<script>
	$(".unblock").on("click", () => {
		console.log($(this).attr("id"));
	})
// 	$(".unblock").click(() => {
// 		console.log(this);
// 		var id = $(this);
// 		console.log(id);
// 		$.ajax({
// 			url: "/admin/unblock",
// 			type: "POST",
// 			data: {
// 				id: id	
// 			}
// 		}).done(e => {
// 			if (e)
// 				$(this).parent().remove();
// 		}).fail(e => {
// 			console.log(e);	
// 		});
// 	});
	</script>
</body>
</html>