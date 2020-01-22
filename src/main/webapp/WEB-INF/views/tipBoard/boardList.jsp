<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<h2>BoardList</h2>
	<table border=1>
		<tr>
			<th>NO</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.seq}</td>
				<td><c:choose>
						<c:when test="${dto.category == 1}">요리</c:when>
						<c:when test="${dto.category == 2}">청소</c:when>
						<c:when test="${dto.category == 3}">건강</c:when>
						<c:when test="${dto.category == 4}">동식물</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose></td>
				<td><a
					href="${pageContext.request.contextPath}/board/detailView.bo?seq=${dto.seq}">${dto.title}</a></td>
				<td>${dto.writer}</td>
				<td>${dto.writeDate}</td>
				<td>${dto.viewCount}</td>
			</tr>
		</c:forEach>
	</table>

	<br>
	<button type="button" id="btnToWrite">글쓰기</button>
	<button type="button" id="btnToBack">돌아가기</button>
	<br>
	<br>
	<form action="tipSearch.bo" method="post">
	<div class="searchBox">
		<select id="searchType" name="tipCategory">
			<option value="title">제목</option>
			<option value="contents">본문</option>
			<option value="both">제목+본문</option>
		</select> 
		<input type="text" id="searchInput" name="searchInput">
		<button type="submit" id="btnSearch">검색</button>
	</div>
	</form>
	${getNavi}

	<script>
		$("#btnToWrite").on("click",function() {
			location.href = "${pageContext.request.contextPath}/board/toBoardWrite.bo";
		})
		$("#btnToBack").on("click", function() {
			location.href = "${pageContext.request.contextPath}/member/myPage.mem";
		})
	</script>
</body>
</html>