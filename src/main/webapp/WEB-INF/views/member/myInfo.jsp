<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <title>내 정보</title>

        <style>
            *{
                box-sizing: border-box;
            }
            body {
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
            #myInfo{
                color: #0085cb;
            }
            .menuIcon img{
                height: 80px;
            }
            .menuText{
                font-size: 16px;
            }

            #allInfo{
                margin: auto;
            }
            #allInfo tr{
                height: 40px;
            }
            .info1{
                width: 160px;
                background-color: #e0e0e0;
                padding-right: 10px;
                text-align: right;
            }
            .info2{
                min-width: 400px;
                padding-left: 15px;
            }
            #pwHint {
                height: 30px;
            }

            #btnContainer {
                text-align: center;
                margin-top: 50px;
                margin-bottom: 15px;
            }
            .btns{
                border:none;
                border-radius:5px;
                cursor:pointer;
                color:white;
                background-color:#0085cb;
            }
            #modifyBtn{
                width:120px;
                height:40px;
                font-size:16px;
            }
        </style>
    </head>
    <body>
        <div id="logo">
            <a href="${pageContext.request.contextPath}/"><img src="/img/index/logos/colorLogo.png"></a>
        </div>
        <br>
        <div id="myPageContainer">
            <div id="myPageHeader">
                <div id="myPageTitle"><b>내 정보</b></div>
                <div id="myPageNotice"><b>${infoResult.name}</b>님의 소중한 개인정보입니다.</div>
            </div>
            <br><br><br>
            <div id="menuContainer">
                <a href="${pageContext.request.contextPath}/member/myInfo.mem" class="myMenu" id="myInfo">
                    <div class="menuIcon">
                        <img src="/img/member/info_checked.png" alt="">
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
                <a href="${pageContext.request.contextPath}/member/myScrap.mem?id=${loginInfo.id}" class="myMenu" id="myScrap">
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
            <table id="allInfo">
                <tbody>
                    <tr>
                        <td class="info1">아이디</td>
                        <td class="info2"><b>${infoResult.id}</b></td>
                    </tr>
                    <tr>
                        <td class="info1">이름</td>
                        <td class="info2">${infoResult.name} (${infoResult.getRealGender()})</td>
                    </tr>
                    <tr>
                        <td class="info1">전화번호</td>
                        <td class="info2">${infoResult.phone}</td>
                    </tr>
                    <tr>
                        <td class="info1">이메일</td>
                        <td class="info2">${infoResult.email}</td>
                    </tr>
                    <tr>
                        <td class="info1">우편번호</td>
                        <td class="info2">${infoResult.postcode}</td>
                    </tr>
                    <tr>
                        <td class="info1">기본주소</td>
                        <td class="info2">${infoResult.address1}</td>
                    </tr>
                    <tr>
                        <td class="info1">상세주소</td>
                        <td class="info2">${infoResult.address2}</td>
                    </tr>
                </tbody>
            </table>

            <div id="btnContainer">
                <button type="button" class="btns" id="modifyBtn">정보 수정</button>
            </div>
        </div>

        <script>

            // 정보 수정 페이지로 이동
            $("#modifyBtn").on("click", function(){
                location.href="${pageContext.request.contextPath}/member/modifyInfo.mem";
            })
        </script>
    </body>
</html>