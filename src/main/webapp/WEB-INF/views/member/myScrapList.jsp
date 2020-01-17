<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<style>
	div{
	border:1px solid black;
	}
</style>
</head>
<body>
	<h3>My Scrap List</h3>
	<div id="scrapBox">
		<div class="row">
			<div class="col-1">글번호</div>
			<div class="col-2">카테고리</div>
			<div class="col-7">제목</div>
			<div class="col-2">스크랩날짜</div>
		</div>
		<c:forEach items="${myScrapList}" var="dto">
			<div class="row">
				<div class="col-1">${dto.rootSeq}</div>
				<div class="col-2">${dto.category}</div>
				<div class="col-7"><a href="${pageContext.request.contextPath}/board/detailView.bo?seq=${dto.rootSeq}">${dto.title}</a></div>
				<div class="col-2">${dto.scrapDate}</div>
			</div>
		</c:forEach>
	</div>
	<button id="toMyPage">돌아가기</button>
	
	<script>
		$("#toMyPage").on("click",function(){
			location.href = "${pageContext.request.contextPath}/member/myPage";
		})
	</script>
</body>
</html>