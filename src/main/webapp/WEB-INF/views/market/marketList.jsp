<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Insert title here</title>
<style>
	table{
		border: 1px solid black;
		width : 800px;
		margin: auto;
	}
	th{
		border: 1px solid black;
	}
	td{
		border: 1px solid black;
	}
</style>
</head>
<body>
	<table>
		<tr style="border: 1px solid black"><th>미리보기<th colspan="3">제품상세</tr>
		<c:choose>
			<c:when test="${list == null}">
				<tr><td>게시글이 없습니다.</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${list }" var="list" varStatus="i">
 					<tr><td style="width: 30%;"><a href="${pageContext.request.contextPath}/board/writedetail.do?seq=${list.seq}">
					<img style="width: 250px; height: 100px; text-align: center;" src ="/files/${fileList[i.index]}"></a>
					<td>${list.title }
					<br>${list.place }
					<br>${list.price }원
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<tr><td colspan="2" style="text-align: right;"><button id="write">글쓰기</button></tr>
		<tr><td colspan="2" style="text-align: center;">
		<form action="search.do" method="post">
		<select name="category">
		<option>전체</option>
		<option>디지털/가전</option>
		<option>가구/인테리어</option>
		<option>생활/가공식품</option>
		<option>의류</option>
		<option>잡화</option>
		<option>뷰티</option>
		<option>스포츠/레저</option>
		<option>게임/취미</option>
		<option>기타</option>
		</select>
		<input type="text" name="title">
		<button>검색</button>
		</form>
		</tr>
	</table>
	
	<script>
		$("#write").on("click", function(){
			location.href="${pageContext.request.contextPath}/board/writeboard.do";
		})
	</script>
</body>
</html>