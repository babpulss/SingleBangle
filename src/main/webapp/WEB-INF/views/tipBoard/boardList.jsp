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
	<h3>board list</h3>
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
				<td>${dto.category}</td>
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
	<div class="searchBox">
		<select id="searchType">
			<option value="title">제목</option>
			<option value="contents">본문</option>
			<option value="writer">작성자</option>
		</select> <input type="text" id="searchInput">
		<button id="btnSearch">검색</button>
	</div>

	<script>
		$("#btnToWrite").on("click",function() {
			location.href = "${pageContext.request.contextPath}/board/toBoardWrite.bo";
						})
		$("#btnToBack").on("click", function() {
			location.href = "${pageContext.request.contextPath}/memberHome;
		})
	</script>
</body>
</html>