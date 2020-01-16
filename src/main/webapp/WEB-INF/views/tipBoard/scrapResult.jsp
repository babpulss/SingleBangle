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
	<script>
		if(${scrapResult} > 0){
			alert("스크랩되었습니다!");
			location.href = "${pageContext.request.contextPath}/board/detailView.bo?seq=${seq}";
		}
	</script>
</body>
</html>