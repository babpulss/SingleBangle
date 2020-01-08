<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Home</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<style>
	*{
		box-sizing:border-box;
	}
	
	#login_box{
		border:2px solid #0085cb;
		border-radius:5px;
		width:250px;
		text-align:center;
		margin:auto;
	}
	
	.info{
		width:100%;
		height:30px;
		border:1px solid #bcbcbc;
		text-align:center;
		font-size:15px;
	}
	
	#mainpage{
		border:2px solid #0085cb;
		border-radius:5px;
		width:250px;
		text-align:center;
		margin:auto;
	}
	
	.btns{
		width:90px;
		height:30px;
		color:#0085cb;
		background-color:white;
		border:1px solid #0085cb;
		border-radius:3px;
	}
	.btns:hover{
		color:white;
		background-color:#0085cb;
		cursor:pointer;
	}
</style>
</head>
<body>

	<c:choose>
		<c:when test="${loginInfo==null}">
			<div id="login_box">
				<form action="${pageContext.request.contextPath}/member/login.mem" method="post" id="frm">
					<h3>Login</h3>
					<input type="text" class="info" id="id" name="id" placeholder="Input your ID">
					<br>
					<input type="password" class="info" id="pw" name="pw" placeholder="Input your PW">
					<br><br>
					<input type="submit" class="btns" id="login" value="Login">
					<button type="button" class="btns" id="signUp">Sign up</button>
					<br><br>
				</form>
			</div>			
		</c:when>
		<c:otherwise>
			<div id="mainpage">
				<h3>${loginInfo.id}님 환영합니다.</h3>
				<button class="btns" id="myInfo">내 정보</button>
				<button class="btns" id="modify">정보 수정</button>
				<br><br>
				<button class="btns" id="logout">로그아웃</button>
				<button class="btns" id="withdraw">회원 탈퇴</button>
				<br><br>
			</div>
		</c:otherwise>
	</c:choose>
	
	
	<script>
		$("#signUp").on("click", function(){
			location.href="${pageContext.request.contextPath}/member/signUp.mem";
		});
		
		$("#myInfo").on("click", function(){
			location.href="${pageContext.request.contextPath}/member/myInfo.mem";
		});
		
		$("#modify").on("click", function(){
			//location.href="${pageContext.request.contextPath}/member/modifyInfo.mem";
		});
		
		$("#logout").on("click", function(){
            var logoutConfirm = confirm("정말 로그아웃 하시겠습니까?");

            if(logoutConfirm == true){
                location.href="${pageContext.request.contextPath}/member/logout.mem";
            }
        });
		
		$("#withdraw").on("click", function(){
			var memberoutConfirm = confirm("정말 탈퇴하시겠습니까?");
			
			if(memberoutConfirm == true){
				location.href="${pageContext.request.contextPath}/member/withdraw.mem";
			}
		});
	</script>
</body>
</html>