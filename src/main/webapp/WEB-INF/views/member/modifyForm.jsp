<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>정보 수정</title>
<style>
body {
	
}

#infoContainer {
	width: 1000px;
	margin: auto;
}

#infoHeader{
	width: 400px;
	height: 80px;
	line-height: 40px;
	margin: auto;
	text-align: center;
	color: white;
	background-color: #0085cb;
	border-radius: 10px;
}
#infoTitle{
	font-size: 30px;
}
#infoNotice{
	font-size: 12px;
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
	padding-left: 15px;
}
.info2{
	min-width: 400px;
	padding-left: 15px;
}

.info input[type="text"], .info input[type="password"] {
	width: 275px;
	height: 25px;
	font-size: 12px;
}
#pwHint {
	height: 30px;
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
.submitBtns{
	width:120px;
	height:40px;
	font-size:16px;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/member/modifyInfoProc.mem" method="post" id="signupFrm"
		onsubmit="return validCheck()">
		<div id="infoHeader">
			<div id="infoTitle">정보 수정</div>
			<div id="infoNotice">아이디와 이름 외의 정보만 수정 가능합니다.</div>
		</div>
		<br>
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
					<td class="info1">비밀번호 확인 질문</td>
					<td class="info2">
						<div class="info">
							<select id="pwHint" name="pwHint" size="1">
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
					</td>
				</tr>
				<tr>
					<td class="info1">비밀번호 확인 답변</td>
					<td class="info2">
						<div class="info">
							<input type="text" class="infoVal" id="pwAnswer" name="pwAnswer" placeholder=" 필수 입력 " value="${infoResult.pwAnswer}">
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
	
	<script>
		var validAll = 0;
		var validPw = 0;
		var validPwre = 0;
		var validPhone = 1;
		var validEmail = 1;
		
		// 비밀번호 유효성 검사
		$("#pw").on("input", function(){
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
	
		// 우편번호 찾기 (다음 우편번호 서비스)
		function findPostcode() {
			new daum.Postcode({
				oncomplete: function(data) {
					document.getElementById("postcode").value = data.zonecode;
					document.getElementById("address1").value = data.roadAddress;
				}
			}).open();
		}
	
		// 회원가입 form 제출하기 전에 전체 검사하기
		function validCheck(){
	
			for(var i = 0; i < $(".infoVal").length; i++){
				if($($(".infoVal")[i]).val() == ""){
					alert("입력하지 않은 정보가 있습니다.");
					return false;
				}
			}
	
			validAll = validPw * validPwre * validPhone * validEmail;
			if(validAll != 1){
				alert("유효하지 않은 정보가 있습니다.");
				return false;
			}
	
			return confirm("정보를 수정 하시겠습니까?");
		}
		
		// 회원가입 취소하고 메인으로 돌아가기
		$("#cancelBtn").on("click", function(){
			var cancelConfirm = confirm("정보 수정을 취소하시겠습니까?");
			
			if(cancelConfirm == true){
				location.href="${pageContext.request.contextPath}/memberHome";
			}
		})
	</script>
</body>
</html>