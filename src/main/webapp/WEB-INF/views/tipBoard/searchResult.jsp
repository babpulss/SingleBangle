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
	<h2>검색결과</h2>
	<h3>총 ${searchResultSize}의 결과가 있습니다.</h3>
	<table border=1>
		<tr>
			<th>NO</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach items="${searchResult}" var="dto">
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

</body>
</html>