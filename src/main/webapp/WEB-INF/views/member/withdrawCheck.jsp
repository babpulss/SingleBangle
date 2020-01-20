<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>회원 탈퇴</title>
</head>
<body>
	<script>
		if(${deleteResult} > 0){
			alert("탈퇴되었습니다. 그 동안 이용해주셔서 감사합니다.");
			location.href="${pageContext.request.contextPath}/";
		}
		else{
			alert("비밀번호를 정확히 입력하세요.");
			location.href="${pageContext.request.contextPath}/member/withdraw.mem";
		}
	</script>
</body>
</html>