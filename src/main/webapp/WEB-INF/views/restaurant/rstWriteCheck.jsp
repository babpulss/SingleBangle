<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>혼밥 / 혼술 글 작성</title>
</head>
<body>
	<script>
		if(${insertResult} > 0){
			alert("글을 작성하였습니다.");
		}
		else{
			alert("글 작성에 실패했습니다. 잠시 후 다시 시도하세요");
		}
		location.href="${pageContext.request.contextPath}/restaurant/rstListY.rst";
	</script>
</body>
</html>