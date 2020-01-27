<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>혼밥 / 혼술 게시글 삭제</title>
</head>
<body>
	<script>
		if(${deleteResult} > 0){
			alert("글을 삭제하였습니다.");
		}
		else{
			alert("글 삭제에 실패했습니다. 잠시 후 다시 시도하세요");
		}
		location.href="${pageContext.request.contextPath}/restaurant/rstListN.rst";
	</script>
</body>
</html>