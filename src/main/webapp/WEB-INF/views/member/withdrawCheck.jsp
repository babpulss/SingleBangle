<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<script>
		if(${deleteResult} > 0){
			alert("탈퇴되었습니다. 그 동안 이용해주셔서 감사합니다.");
		}
		else{
			alert("탈퇴에 실패했습니다. 다시 시도해주세요.");
		}
		location.href="${pageContext.request.contextPath}/";
	</script>
</body>
</html>