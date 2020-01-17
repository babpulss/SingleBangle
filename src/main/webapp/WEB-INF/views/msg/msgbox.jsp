<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
<div style="margin: auto; width: 300px;">
<div style="text-align: center">쪽지함</div>
<div><div style="width:50%; float:left">보낸사람 </div><div style="width:50%; float:left">내용</div></div>
<c:choose>
	<c:when test="${list.size() == 0 }">
		<div>쪽지함이 비어있습니다.</div>
	</c:when>
	<c:otherwise>
	<c:forEach items="${list }" var="list">
		<div>
		<div style="width:50%; float:left">${list.sender }</div>
		<div style="width:50%; float:left">
		<a href="${pageContext.request.contextPath }/msg/msgDetail.do?seq=${list.seq}">${list.contents }</a></div>
		</div>
	</c:forEach>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>