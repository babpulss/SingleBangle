<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<title>아이디 찾기</title>
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
                height: 60px;
            }
            .findWayText{
                font-size: 18px;
            }
            #findWayId .findWayText{
                margin-left: 7px;
            }

            #findIdFrm{
                width: 600px;
                margin: auto;
            }
            #findIdContainer{
                width: 400px;
                margin: auto;
            }

            #findIdHeader{
                width: 400px;
                height: 80px;
                line-height: 40px;
                margin: auto;
/*
                text-align: center;
                color: white;
                background-color: #0085cb;
*/
                border-radius: 10px;
            }
            #findIdTitle{
                font-size: 32px;
            }
            #findIdNotice{
                font-size: 12px;
                border-bottom: 1px solid black;
            }

            .info{
                margin-top: 15px;
                margin-bottom: 15px;
            }
            .label1{
                display: inline-block;
                margin-bottom: 5px;
                font-size: 14px;
            }
            .infoVal{
                border: 1px solid #dadada;
                width: 100%;
                height: 40px;
                font-size: 14px;
            }

            #submitContainer{
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
                width: 100px;
                height: 40px;
                font-size: 14px;
                margin-bottom: 5px;
            }
            #cancelBtn{
                background-color: #e05252;
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
        <form action="${pageContext.request.contextPath}/member/findIdResult.mem" method="post" id="findIdFrm" onsubmit="return validCheck()">
            <div id="findIdContainer">
                <div id="findIdHeader">
                    <div id=findIdTitle><b>아이디 찾기</b></div>
                    <div id="findIdNotice">회원정보에 등록한 이름과 전화번호를 입력하세요.</div>
                </div>
                <br>
                <div class="info">
                    <label class="label1" for="name"><b>이름</b></label><br>
                    <input type="text" class="infoVal" id="name" name="name">
                </div>
                <div class="info">
                    <label class="label1" for="phone"><b>전화번호</b></label><br>
                    <input type="text" class="infoVal" id="phone" name="phone" placeholder=" '-' 없이 숫자만 입력 ">
                </div>
                <div id="submitContainer">
                    <input type="submit" class="btns" id="submitBtn" value="찾기">
                    <button type="button" class="btns" id="cancelBtn">취소</button>
                </div>
            </div>
        </form>
        
        <script>
        	function validCheck(){
        		for(var i = 0; i < $(".infoVal").length; i++){
    				if($($(".infoVal")[i]).val() == ""){
    					alert("이름과 전화번호를 모두 입력하세요.");
    					return false;
    				}
    			}
        		
        		return true;
        	}
        	
        	$("#cancelBtn").on("click", function(){
        		var cancelConfirm = confirm("아이디 찾기를 취소하시겠습니까?");
        		
        		if(cancelConfirm == true){
	        		location.href="${pageContext.request.contextPath}/";        			
        		}
        	})
        </script>
    </body>
</html>