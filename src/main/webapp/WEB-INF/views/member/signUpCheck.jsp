<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>회원가입</title>
</head>
<body>
	<script>
		if(${signUpResult > 0}){
			alert("회원가입 되었습니다. 로그인 후 이용해주세요.");
			location.href="${pageContext.request.contextPath}/";			
		}
		else{
			alert("회원가입에 실패했습니다. 다시 시도해주세요.");
			location.href="${pageContext.request.contextPath}/member/signUp.mem";
		}
	</script>
</body>
</html>