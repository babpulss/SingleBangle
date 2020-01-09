<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>정보 수정</title>
</head>
<body>
	<script>
		if(${updateResult > 0}){
			alert("회원님의 정보가 수정되었습니다.");
			location.href="${pageContext.request.contextPath}/memberHome";
		}
		else{
			alert("정보수정에 실패했습니다. 다시 시도해주세요.");
			location.href="${pageContext.request.contextPath}/member/modifyInfo.mem";
		}
	</script>
</body>
</html>