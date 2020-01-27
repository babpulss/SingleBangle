<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<title>비밀번호 찾기</title>
		
		<link rel="stylesheet" href="/css/nav.css">
        <link rel="stylesheet" href="/css/footer.css">
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
                color: #b2b2b2;
            }
            #findWayPw{
                color: #0085cb;
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

            #findPwFrm{
                width: 600px;
                margin: auto;
            }
            #findPwContainer{
                width: 400px;
                margin: auto;
            }

            #findPwHeader{
                width: 400px;
                height: 80px;
                line-height: 40px;
                margin: auto;
            }
            #findPwTitle{
                font-size: 32px;
            }
            #findPwNotice{
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
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    	
    	<br><br><br>
        <div id="mainWrapper">
	        <div id="findWayContainer">
	            <a href="${pageContext.request.contextPath}/member/findId.mem" class="findWay" id="findWayId">
	                <div class="findWayIcon"><img src="/img/member/id_unchecked.png"></div>
	                <div class="findWayText"><b>아이디 찾기</b></div>
	            </a>
	            <a href="${pageContext.request.contextPath}/member/findPw.mem" class="findWay" id="findWayPw">
	                <div class="findWayIcon"><img src="/img/member/pw_checked.png"></div>
	                <div class="findWayText"><b>비밀번호 찾기</b></div>
	            </a>
	        </div>
	        <br><br><br>
	        <form action="${pageContext.request.contextPath}/email/findPwResult.email" method="post" id="findPwFrm" onsubmit="return validCheck()">
	            <div id="findPwContainer">
	                <div id="findPwHeader">
	                    <div id=findPwTitle><b>비밀번호 찾기</b></div>
	                    <div id="findPwNotice">회원정보에 등록한 아이디와 이메일을 입력하세요.</div>
	                </div>
	                <br>
	                <div class="info">
	                    <label class="label1" for="id"><b>아이디</b></label><br>
	                    <input type="text" class="infoVal" id="id" name="id">
	                </div>
	                <div class="info">
	                    <label class="label1" for="email"><b>이메일</b></label><br>
	                    <input type="text" class="infoVal" id="email" name="email">
	                </div>
	                <div id="submitContainer">
	                    <input type="submit" class="btns" id="submitBtn" value="찾기">
	                    <button type="button" class="btns" id="cancelBtn">취소</button>
	                </div>
	            </div>
	        </form>
        </div>
        <br><br><br>
        
        <jsp:include page="/resources/jsp/footer.jsp" />
        
        <script>
	        function validCheck(){
	    		for(var i = 0; i < $(".infoVal").length; i++){
					if($($(".infoVal")[i]).val() == ""){
						alert("아이디, 비밀번호 찾기 답변과 이메일을 모두 입력하세요.");
						return false;
					}
				}
	    		
	    		return true;
	    	}
	    	
	    	$("#cancelBtn").on("click", function(){
	    		var cancelConfirm = confirm("비밀번호 찾기를 취소하시겠습니까?");
	    		
	    		if(cancelConfirm == true){
	        		location.href="${pageContext.request.contextPath}/";        			
	    		}
	    	})
        </script>
    </body>
</html>