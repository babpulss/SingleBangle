<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <title>정보 수정</title>
        
        <link rel="stylesheet" href="/css/nav.css">
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
            #modifyInfo{
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

            .infoVal {
                border: 1px solid #dadada;
                width: 330px;
                height: 40px;
                font-size: 14px;
            }
            #email, #postcode{
                width: 225px;
            }
            .validCheck {
                font-size: 11px;
            }

            #submitContainer {
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
            .infoBtns{
                width: 100px;
                height: 35px;
            }
            .submitBtns{
                width:120px;
                height:40px;
                font-size:16px;
            }
            #cancelBtn{
                background-color: #e05252;
            }
        </style>
    </head>
    <body>
        <c:choose>
            <c:when test="${pwCheckResult==0}">
                <script>
                    alert("비밀번호를 정확히 입력하세요.");
                    location.href="${pageContext.request.contextPath}/member/modifyInfo.mem";
                </script>
            </c:when>
        </c:choose>
        
        <jsp:include page="/resources/jsp/nav.jsp"/>

		<div id="mainWrapper">
	        <br><br><br>
	        <div id="myPageContainer">
	            <div id="myPageHeader">
	                <div id="myPageTitle"><b>정보 수정</b></div>
	                <div id="myPageNotice">아이디와 이름 정보는 수정하실 수 없습니다.</div>
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
	            <form action="${pageContext.request.contextPath}/member/modifyInfoProc.mem" method="post" id="signupFrm"
	                  onsubmit="return validCheck()">
	                <table id="allInfo">
	                    <tbody>
	                        <tr>
	                            <td class="info1">아이디</td>
	                            <td class="info2"><b>${infoResult.id}</b></td>
	                        </tr>
	                        <tr>
	                            <td class="info1">비밀번호</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="password" class="infoVal" id="pw" name="pw" placeholder=" 8~20자 이내 영문, 숫자, 특수문자(!,@,#,$,%,^,&,*) ">
	                                    <br>
	                                    <span class="validCheck" id="pwCheck"></span>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">비밀번호 확인</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="password" class="infoVal" id="pwre" name="pwre" placeholder=" 비밀번호 확인 ">
	                                    <br>
	                                    <span class="validCheck" id="pwreCheck"></span>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">이름</td>
	                            <td class="info2">${infoResult.name} (${infoResult.getRealGender()})</td>
	                        </tr>
	                        <tr>
	                            <td class="info1">전화번호</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="text" class="infoVal" id="phone" name="phone" placeholder=" -없이 숫자만 입력 " value="${infoResult.phone}">
	                                    <br>
	                                    <span class="validCheck" id="phoneCheck"></span>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">이메일</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="text" class="infoVal" id="email" name="email" placeholder=" 이메일 인증 필수 " value="${infoResult.email}">
	                                    <button type="button" class="btns infoBtns" id="emailBtn">이메일 인증</button>
	                                    <br>
	                                    <span class="validCheck" id="emailCheck"></span>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">우편번호</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="text" class="infoVal" id="postcode" name="postcode" placeholder=" 필수 입력 " readonly value="${infoResult.postcode}">
	                                    <button type="button" class="btns infoBtns" id="postcodeBtn" onclick="findPostcode()">우편번호 찾기</button>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">기본주소</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="text" class="infoVal" id="address1" name="address1" placeholder=" 필수 입력 " readonly value="${infoResult.address1}">
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td class="info1">상세주소</td>
	                            <td class="info2">
	                                <div class="info">
	                                    <input type="text" class="infoVal" id="address2" name="address2" placeholder=" 필수 입력 " value="${infoResult.address2}">
	                                </div>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	
	                <div id="submitContainer">
	                    <input type="submit" class="btns submitBtns" id="modifyBtn" value="수정 완료">
	                    <button type="button" class="btns submitBtns" id="cancelBtn">수정 취소</button>
	                </div>
	            </form>
	        </div>
        </div>

        <script>
            var validAll = 0;
            var validPw = 0;
            var validPwre = 0;
            var validPhone = 1;
            var validEmail = 1;
            var validEmailCheck = 1;

            // 비밀번호 유효성 검사
            $("#pw").on("input", function(){
                $("#pwre").val("");
                $("#pwreCheck").html("");
                validPwre = 0;

                var pw = $("#pw").val();
                var pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/;
                var pwResult = pwRegex.exec(pw);

                if(pwResult != null){
                    $("#pwCheck").html("사용 가능한 비밀번호입니다.").css("color", "green");
                    validPw = 1;
                }
                else{
                    $("#pwCheck").html("비밀번호 형식을 확인해주세요.").css("color", "red");
                    validPw = 0;
                }
            })

            // 비밀번호 재입력 검사
            $("#pwre").on("input", function(){
                if(validPw == 0){
                    alert("비밀번호를 먼저 확인해주세요.");
                    $("#pwre").val("");
                    $("#pw").focus();
                }
                else{
                    if($("#pw").val() == $("#pwre").val()){
                        $("#pwreCheck").html("비밀번호가 일치합니다.").css("color", "green");
                        validPwre = 1;
                    }
                    else{
                        $("#pwreCheck").html("비밀번호가 일치하지 않습니다.").css("color", "red");
                        validPwre = 0;
                    }
                }
            })

            // 전화번호 유효성 검사
            $("#phone").on("input", function(){
                var phone = $("#phone").val();
                var phoneRegex = /^0\d{2}\d{3,4}\d{4}$/;
                var phoneResult = phoneRegex.exec(phone);

                if(phoneResult != null){
                    $("#phoneCheck").html("올바른 번호입니다.").css("color", "green");
                    validPhone = 1;
                }
                else{
                    $("#phoneCheck").html("번호를 확인해주세요.").css("color", "red");
                    validPhone = 0;
                }
            })

            // 이메일 유효성 검사
            $("#email").on("input", function(){
                var email = $("#email").val();
                var emailRegex = /^\w+@[a-z]+(\.[a-z]+){1,2}$/;
                var emailResult = emailRegex.exec(email);

                if(emailResult != null){
                    $("#emailCheck").html("올바른 이메일입니다.").css("color", "green");
                    validEmail = 1;
                }
                else{
                    $("#emailCheck").html("이메일을 확인해주세요.").css("color", "red");
                    validEmail = 0;
                }
            })

            // 이메일 인증
            $("#emailBtn").on("click", function(){
                if(validEmail == 1){
                    var emailAddr = $("#email").val();
                    window.open("${pageContext.request.contextPath}/email/emailConfirm.email?email="+emailAddr, "sendEmailView", 
                                "width=550px; height=350px, left=200px, top=100px");
                }
                else{
                    $("#emailCheck").html("이메일을 확인해주세요.").css("color", "red");
                }
            })

            // 우편번호 찾기 (다음 우편번호 서비스)
            function findPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        document.getElementById("postcode").value = data.zonecode;
                        document.getElementById("address1").value = data.roadAddress;
                    }
                }).open();
            }

            // 정보 수정 form 제출하기 전에 전체 검사하기
            function validCheck(){

                for(var i = 0; i < $(".infoVal").length; i++){
                    if($($(".infoVal")[i]).val() == ""){
                        alert("입력하지 않은 정보가 있습니다.");
                        return false;
                    }
                }

                validAll = validPw * validPwre * validPhone * validEmail * validEmailCheck;
                if(validAll != 1){
                    alert("유효하지 않은 정보가 있습니다.");
                    return false;
                }

                return confirm("정보를 수정 하시겠습니까?");
            }

            // 정보 수정 취소하고 메인으로 돌아가기
            $("#cancelBtn").on("click", function(){
                var cancelConfirm = confirm("정보 수정을 취소하시겠습니까?");

                if(cancelConfirm == true){
                    location.href="${pageContext.request.contextPath}/member/myPage.mem";
                }
            })
        </script>
    </body>
</html>