<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
		<title>비밀번호 찾기</title>
		
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
                    <div id="findPwNotice">회원정보에 등록한 아이디, 비밀번호 찾기 답변과 이메일을 입력하세요.</div>
                </div>
                <br>
                <div class="info">
                    <label class="label1" for="id"><b>아이디</b></label><br>
                    <input type="text" class="infoVal" id="id" name="id">
                </div>
                <div class="info">
                    <label class="label1" for="pwHint"><b>비밀번호 찾기 질문</b></label><br>
                    <select class="infoVal" id="pwHint" name="pwHint" size="1">
                        <option value="hint1">기억에 남는 추억의 장소는?</option>
                        <option value="hint2">자신의 인생 좌우명은?</option>
                        <option value="hint3">자신의 보물 1호는?</option>
                        <option value="hint4">가장 기억에 남는 선생님 성함은?</option>
                        <option value="hint5">타인이 모르는 자신만의 신체 비밀은?</option>
                        <option value="hint6">추억하고 싶은 날짜는?</option>
                        <option value="hint7">받았던 선물 중 기억에 남는 독특한 선물은?</option>
                        <option value="hint8">유년시절 가장 생각나는 친구 이름은?</option>
                        <option value="hint9">인상 깊게 읽은 책 이름은?</option>
                        <option value="hint10">읽은 책 중에서 좋아하는 구절은?</option>
                        <option value="hint11">자신이 두 번째로 존경하는 인물은?</option>
                        <option value="hint12">친구들에게 공개하지 않은 어릴 적 별명은?</option>
                        <option value="hint13">초등학교 때 기억에 남는 짝꿍 이름은?</option>
                        <option value="hint14">다시 태어나면 되고 싶은 것은?</option>
                        <option value="hint15">내가 좋아하는 캐릭터는?</option>
                    </select>
                </div>
                <div class="info">
                    <label class="label1" for="pwAnswer"><b>비밀번호 찾기 답변</b></label><br>
                    <input type="text" class="infoVal" id="pwAnswer" name="pwAnswer" placeholder=" 회원정보에 등록한 답변 ">
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