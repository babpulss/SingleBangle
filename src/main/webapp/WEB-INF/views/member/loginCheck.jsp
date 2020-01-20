<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>로그인</title>

</head>
<body>
	<script>
		if(${loginResult} > 0){
			alert("로그인 되었습니다.");
			location.href="${pageContext.request.contextPath}/";
		}
		else{
			alert("아이디 또는 비밀번호를 확인해주세요.");
			location.href="${pageContext.request.contextPath}/member/login.mem";
		}
	</script>
</body>
</html>