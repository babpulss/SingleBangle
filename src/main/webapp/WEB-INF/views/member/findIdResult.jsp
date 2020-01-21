<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <title>아이디 찾기 결과</title>
        
        <style>
            *{
                box-sizing: border-box;
            }
            body {
                background-color: #f5f5f5;
            }

            #findWayContainer{
                width: 400px;
                height: 60px;
                margin: auto;
            }
            .findWay{
                display: inline-block;
                width: 45%;
                height: 60px;
                line-height: 60px;
                text-decoration: none;
            }
            #findWayId{
                color: #0085cb;
            }
            #findWayPw{
                color: #b2b2b2;
            }

            .findWay div{
                float: left;
            }
            .findWayIcon img{
                width: 60px;
                height: 60px;
            }
            .findWayText{
                font-size: 18px;
            }
            #findWayId .findWayText{
                margin-left: 7px;
            }

            #findIdContainer{
                border: 1px solid #b2b2b2;
                width: 400px;
                margin: auto;
            }

            #findIdHeader{
                width: 400px;
                height: 80px;
                line-height: 40px;
                margin: auto;
                text-align: center;
            }
            #findIdTitle{
                font-size: 32px;
                margin-top: 15px;
            }
            #findIdNotice{
                font-size: 12px;
                border-bottom: 1px solid #b2b2b2;
            }

            #idList{
                margin-top: 15px;
                margin-bottom: 15px;
                text-align: center;
            }

            #toLoginContainer{
                text-align: center;
                margin-top: 50px;
                margin-bottom: 50px;
            }
            .btns{
                border: none;
                border-radius: 5px;
                cursor: pointer;
                color: white;
                background-color: #0085cb;
                width: 140px;
                height: 40px;
                font-size: 14px;
                margin-bottom: 5px;
            }
        </style>
    </head>
    <body>
        <div id="findWayContainer">
            <a href="${pageContext.request.contextPath}/member/findId.mem" class="findWay" id="findWayId">
                <div class="findWayIcon"><img src="/img/member/id_checked.png"></div>
                <div class="findWayText"><b>아이디 찾기</b></div>
            </a>
            <a href="${pageContext.request.contextPath}/member/findPw.mem" class="findWay" id="findWayPw">
                <div class="findWayIcon"><img src="/img/member/pw_unchecked.png"></div>
                <div class="findWayText"><b>비밀번호 찾기</b></div>
            </a>
        </div>
        <br><br><br>
        <div id="findIdContainer">
            <div id="findIdHeader">
                <div id=findIdTitle><b>아이디 찾기 결과</b></div>
                <div id="findIdNotice">입력하신 정보와 일치하는 아이디 목록입니다.</div>
            </div>
            <br>
            <div id="idList">
            	<c:choose>
					<c:when test="${findIdResult.size() > 0}">
						<c:forEach items="${findIdResult}" var="id">
							<b>${id}</b><br>						
						</c:forEach>
					</c:when>
					<c:otherwise>
						입력하신 정보와 일치하는 아이디가 없습니다.<br>
					</c:otherwise>
				</c:choose>
            </div>
            <div id="toLoginContainer">
            	<c:choose>
					<c:when test="${fn:length(findIdResult) != 0}">
		                <button type="button" class="btns" id="toLogin">로그인하러 가기</button>
		                <button type="button" class="btns" id="toFindPw">비밀번호 찾기</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btns" id="toFindId">아이디 다시 찾기</button>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
        
        <script>
        	$("#toLogin").on("click", function(){
        		location.href="${pageContext.request.contextPath}/member/login.mem";
        	})
        	
        	$("#toFindPw").on("click", function(){
        		location.href="${pageContext.request.contextPath}/member/findPw.mem";
        	})
        	
        	$("#toFindId").on("click", function(){
        		location.href="${pageContext.request.contextPath}/member/findId.mem";
        	})
        </script>
    </body>
</html>