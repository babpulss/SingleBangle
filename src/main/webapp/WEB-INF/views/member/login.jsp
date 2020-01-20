<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
        <title>로그인</title>

        <style>
            @font-face {
                font-family: 'BMHANNAAir';
                src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff') format('woff');
                font-weight: normal;
                font-style: normal;
            }

            body{
                background-color: #aaaaaa;
            }

            #loginContainer{
                width: 300px;
                margin: auto;
            }
            #loginFrm {
                border-radius: 5px;
                width: 300px;
                height: 300px;
                position: absolute;
                top: 20%;
                animation-name: fadeInDown;
                animation-duration: 1s;
                text-align: center;
                font-size: 20px;
                background-color: #f5f5f5;
            }

            #loginTitle{
                font-family: 'BMHANNAAir';
                font-size: 24px;
            }

            .loginVal{
                border: 1px solid #dadada;
                width: 90%;
                height: 40px;
                text-align: center;
                font-size: 16px;
            }

            #loginBtnBox{
                margin-top:30px;
            }
            #loginBtn{
                border: none;
                width: 90%;
                height: 40px;
                margin-bottom:5px;
                cursor: pointer;
                font-size: 16px;
                color: white;
                background-color: #0085cb;
            }

            #joinBox{
                margin-top: 10px;
                font-size: 12px;
            }
            #joinBox>a{
                color: #0085cb;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div id="loginContainer">
            <form action="${pageContext.request.contextPath}/member/loginProc.mem" method="post" id="loginFrm">
                <br>
                <div id="loginTitle"><b>싱글방글 로그인</b></div>
                <br>
                <div id="loginInfoBox">
                    <input type="text" class="loginVal" id="id" name="id" placeholder=" ID"><br>
                    <input type="password" class="loginVal" id="pw" name="pw" placeholder=" PASSWORD"><br>
                </div>
                <div id="loginBtnBox">
                    <button class="loginBtns" id="loginBtn">Login</button>
                </div>
                <div id="joinBox">
                    <a href="${pageContext.request.contextPath}/member/findId.mem">아이디 찾기</a> | 
                    <a href="${pageContext.request.contextPath}/member/findPw.mem">비밀번호 찾기</a> | 
                    <a href="${pageContext.request.contextPath}/member/signUp.mem">회원가입</a>
                </div>
            </form>
        </div>
    </body>
</html>