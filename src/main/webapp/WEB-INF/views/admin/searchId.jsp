<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 추가</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<c:choose>
	<c:when test="${!empty searchedId}">
		<div>블랙리스트 추가 대상: ${id}</div>
		<div>제재 사유: <textarea style="resize: none"></textarea>	</div>
		<button>확인</button>
		<button class="close" type="button">취소</button>
	</c:when>
	<c:otherwise>
		 아이디가 존재하지 않습니다<br>
		다시 확인해 주세요	
		<button class="close">확인</button>
	</c:otherwise>
	</c:choose>
	<script>
		$(".close").click(() => {
			window.close();
		})	
	</script>
</body>
</html>