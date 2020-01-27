<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <title>정보 수정</title>
		
		<link rel="stylesheet" href="/css/nav.css">
		<link rel="stylesheet" href="/css/footer.css">
        <style>
            *{
                box-sizing: border-box;
            }
            body{
                background-color: #f5f5f5;
            }

            #myPageContainer{
                width: 500px;
                margin: auto;
            }
            #myPageHeader{
                width: 500px;
                height: 80px;
                line-height: 40px;
                margin: auto;
            }
            #myPageTitle{
                font-size: 32px;
            }
            #myPageNotice{
                font-size: 12px;
                border-bottom: 1px solid black;
            }

            #menuContainer{
                width: 500px;
                text-align: center;
                margin: auto;
            }
            .myMenu{
                display: inline-block;
                width: 120px;
                text-decoration: none;
                color: #b2b2b2;
            }
            #modifyInfo{
                color: #0085cb;
            }
            .menuIcon img{
                height: 80px;
            }
            .menuText{
                font-size: 16px;
            }

            #pwCheckContainer{
                border: 1px solid #b2b2b2;
                width: 400px;
                margin: auto;
            }
            #pwCheckHeader{
                width: 400px;
                height: 80px;
                line-height: 40px;
                margin: auto;
                text-align: center;
            }
            #pwCheckTitle{
                font-size: 32px;
                margin-top: 15px;
            }
            #pwCheckNotice{
                font-size: 12px;
                border-bottom: 1px solid #b2b2b2;
            }

            #inputPw{
                margin-top: 15px;
                margin-bottom: 15px;
                text-align: center;
            }
            #pw{
                border: 1px solid #dadada;
                width: 250px;
                height: 40px;
                font-size: 14px;
            }
            #submitBtn{
                border: none;
                cursor: pointer;
                color: white;
                background-color: #0085cb;
                width: 250px;
                height: 40px;
                font-size: 14px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
    	<c:choose>
            <c:when test="${loginInfo==null}">
                <script>
                    alert("로그인 후 이용하실 수 있습니다.");
                    location.href="${pageContext.request.contextPath}/member/login.mem";
                </script>		
            </c:when>
        </c:choose>
    	
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    	
		<br><br><br>
    	<div id="mainWrapper">
	        <div id="myPageContainer">
	            <div id="myPageHeader">
	                <div id="myPageTitle"><b>정보 수정</b></div>
	                <div id="myPageNotice"><b>${loginInfo.name}</b>님의 개인정보를 <b>수정</b>하실 수 있습니다.</div>
	            </div>
	            <br><br><br>
	            <div id="menuContainer">
	                <a href="${pageContext.request.contextPath}/member/myInfo.mem" class="myMenu" id="myInfo">
	                    <div class="menuIcon">
	                        <img src="/img/member/info_unchecked.png" alt="">
	                    </div>
	                    <div class="menuText">
	                        <b>내 정보</b>
	                    </div>
	                </a>
	                <a href="${pageContext.request.contextPath}/member/modifyInfo.mem" class="myMenu" id="modifyInfo">
	                    <div class="menuIcon">
	                        <img src="/img/member/modify_checked.png" alt="">
	                    </div>
	                    <div class="menuText">
	                        <b>정보 수정</b>
	                    </div>
	                </a>
	                <a href="${pageContext.request.contextPath}/member/myScrap.mem?currentPage=1" class="myMenu" id="myScrap">
	                    <div class="menuIcon">
	                        <img src="/img/member/bookmark01_unchecked.png" alt="">
	                    </div>
	                    <div class="menuText">
	                        <b>스크랩</b>
	                    </div>
	                </a>
	                <a href="${pageContext.request.contextPath}/member/withdraw.mem" class="myMenu" id="withdraw">
	                    <div class="menuIcon">
	                        <img src="/img/member/withdraw_unchecked.png" alt="">
	                    </div>
	                    <div class="menuText">
	                        <b>회원 탈퇴</b>
	                    </div>
	                </a>
	            </div>
	            <br><br><br>
	            <div id="pwCheckContainer">
	                <div id="pwCheckHeader">
	                    <div id="pwCheckTitle">비밀번호 확인</div>
	                    <div id="pwCheckNotice">회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.</div>
	                </div>
	                <br>
	                <div id="inputPw">
	                    <form action="${pageContext.request.contextPath}/member/modifyInfoForm.mem" method="post">
	                        <input type="password" id="pw" name="pw" placeholder=" 비밀번호 ">
	                        <br><br>
	                        <input type="submit" id="submitBtn" value="확인">
	                    </form>
	                </div>
	            </div>
	        </div>
		</div>
		<br><br><br>
		
		<jsp:include page="/resources/jsp/footer.jsp" />
    </body>
</html>