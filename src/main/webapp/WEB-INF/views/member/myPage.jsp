<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <title>마이 페이지</title>

        <style>
            *{
                box-sizing: border-box;
            }
            body{
                background-color: #f5f5f5;
            }

            #logo{
            	width: 800px;
                margin: auto;
                text-align: center;
            }
            #logo img{
                height: 180px;
            }

            #myPageContainer{
                width: 800px;
                margin: auto;
            }
            #myPageHeader{
                width: 800px;
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
                width: 800px;
                text-align: center;
                margin: auto;
            }
            .myMenu{
                display: inline-block;
                width: 120px;
                text-decoration: none;
                color: #b2b2b2;
            }
            .menuIcon img{
                height: 80px;
            }
            .menuText{
                font-size: 16px;
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
            <c:otherwise>
                <div id="logo">
                    <a href="${pageContext.request.contextPath}/"><img src="/img/index/logos/colorLogo.png"></a>
                </div>
                <br>
                <div id="myPageContainer">
                    <div id="myPageHeader">
                        <div id="myPageTitle"><b>마이 페이지</b></div>
                        <div id="myPageNotice"><b>${loginInfo.id}</b>님의 정보를 관리할 수 있습니다.</div>
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
                                <img src="/img/member/modify_unchecked.png" alt="">
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
                </div>
            </c:otherwise>
        </c:choose>
    </body>
</html>