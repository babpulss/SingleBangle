<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>회원가입</title>
<style>
body {
	
}

#signupFrm {
	width: 1000px;
	margin: auto;
}

#signUpHeader{
	width:400px;
	height:80px;
	line-height:40px;
	margin:auto;
	text-align:center;
	color:white;
	background-color:#0085cb;
	border-radius:10px;
}
#signUpTitle{
	font-size:30px;
}
#signUpNotice{
	font-size:12px;
}

.info {
	position: relative;
	left: 50px;
	margin-left: 130px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.label1 {
	/* display: inline-block;
	width: 200px;
	text-align: right; */
	font-size: 12px;
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
.infoBtns{
	width:100px;
	height:25px;
}
.submitBtns{
	width:120px;
	height:40px;
	font-size:16px;
}
</style>
</head>
<body>
	<form action="${pageContext.request.contextPath}/member/signUpProc.mem" method="post" id="signupFrm"
		onsubmit="return validCheck()">
		<div id="signUpHeader">
			<div id="signUpTitle">회원가입</div>
			<div id="signUpNotice">회원가입 후 서비스 이용이 가능합니다.</div>
		</div>
		<div class="info">
			<label class="label1" for="id">아이디</label><br>
			<input type="text" class="infoVal" id="id" name="id" placeholder=" 5~12자 이내 영문(소문자), 숫자">
			<span class="validCheck" id="idCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="pw">비밀번호</label><br>
			<input type="password" class="infoVal" id="pw" name="pw" placeholder=" 8~20자 이내 영문, 숫자, 특수문자(!,@,#,$,%,^,&,*) ">
			<span class="validCheck" id="pwCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="pwre">비밀번호 확인</label><br>
			<input type="password" class="infoVal" id="pwre" name="pwre" placeholder=" 비밀번호 확인 ">
			<span class="validCheck" id="pwreCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="pwHint">비밀번호 확인 질문</label><br>
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
		<div class="info">
			<label class="label1" for="pwAnswer">비밀번호 확인 답변</label><br>
			<input type="text" class="infoVal" id="pwAnswer" name="pwAnswer" placeholder=" 필수 입력 ">
		</div>
		<div class="info">
			<label class="label1" for="name">이름</label><br>
			<input type="text" class="infoVal" id="name" name="name" placeholder=" 한글 이름 ">
			<span class="validCheck" id="nameCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="">성별</label><br>
			<input type="radio" id="male" name="gender" value="M"><label for="male">남</label>
			<input type="radio" id="female" name="gender" value="F"><label for="female">여</label>
		</div>
		<div class="info">
			<label class="label1" for="phone">전화번호</label><br>
			<input type="text" class="infoVal" id="phone" name="phone" placeholder=" -없이 숫자만 입력 ">
			<span class="validCheck" id="phoneCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="email">이메일</label><br>
			<input type="text" class="infoVal" id="email" name="email" placeholder=" 이메일 인증 필수 ">
			<button type="button" class="btns infoBtns" id="emailBtn">이메일 인증</button>
			<span class="validCheck" id="emailCheck"></span>
		</div>
		<div class="info">
			<label class="label1" for="">우편번호</label><br>
			<input type="text" class="infoVal" id="postcode" name="postcode" placeholder=" 필수 입력 " readonly>
			<button type="button" class="btns infoBtns" id="postcodeBtn" onclick="findPostcode()">우편번호 찾기</button>
		</div>
		<div class="info">
			<label class="label1" for="">기본주소</label><br>
			<input type="text" class="infoVal" id="address1" name="address1" placeholder=" 필수 입력 " readonly>
		</div>
		<div class="info">
			<label class="label1" for="address2">상세주소</label><br>
			<input type="text" class="infoVal" id="address2" name="address2" placeholder=" 필수 입력 " >
		</div>
		<div id="submitContainer">
			<input type="submit" class="btns submitBtns" id="submitBtn" value="회원가입">
			<button type="button" class="btns submitBtns" id="cancelBtn">회원가입 취소</button>
		</div>
	</form>

	<script>
		var validAll = 0;
		var validId = 0;
		var validPw = 0;
		var validPwre = 0;
		var validName = 0;
		var validPhone = 0;
		var validEmail = 0;

		// 아이디 유효성 검사
		$("#id").on("input", function(){
			var id = $("#id").val();
			var idRegex = /^[a-z0-9]{5,12}$/;
			var idResult = idRegex.exec(id);

			if(idResult != null){
				
				// 아이디 중복 검사
				$("#id").on("blur", function(){
					$.ajax({
						url:"idDuplCheck.mem",
						type:"post",
						data:{
							id:id
						},
						dataType:"json"
					}).done(function(data){
						if(data.result == 1){
							$("#idCheck").html("중복된 아이디입니다.").css("color", "red");
							validId = 0;
						}
						else{
							$("#idCheck").html("사용 가능한 아이디입니다.").css("color", "green");
							validId = 1;
						}
					}).fail(function(a, b, c){
						console.log(a);
						console.log(b);
						console.log(c);
						alert("비동기 통신 실패");
					});
				})
				
			}
			else{
				$("#idCheck").html("아이디 형식을 확인해주세요.").css("color", "red");
				validId = 0;
			}
		})

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

		// 이름 유효성 검사
		$("#name").on("input", function(){
			var name = $("#name").val();
			var nameRegex = /^[가-힣]{1}[가-힣]{1,4}$/;
			var nameResult = nameRegex.exec(name);

			if(nameResult != null){
				$("#nameCheck").html("올바른 이름입니다.").css("color", "green");
				validName = 1;
			}
			else{
				$("#nameCheck").html("이름을 확인해주세요.").css("color", "red");
				validName = 0;
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
				window.open("${pageContext.request.contextPath}/email/emailConfirm.email", "sendEmailView", 
						"width=500px; height=400px, left=200px, top=100px");
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

			if($("#male").prop("checked") == false && $("#female").prop("checked") == false){
				alert("입력하지 않은 정보가 있습니다.");
				return false;
			}

			validAll = validId * validPw * validPwre * validName * validPhone * validEmail;
			if(validAll != 1){
				alert("유효하지 않은 정보가 있습니다.");
				return false;
			}

			return confirm("회원가입 하시겠습니까?");
		}
		
		// 회원가입 취소하고 메인으로 돌아가기
		$("#cancelBtn").on("click", function(){
			var cancelConfirm = confirm("회원가입을 취소하시겠습니까?");
			
			if(cancelConfirm == true){
				location.href="${pageContext.request.contextPath}/memberHome";
			}
		})
	</script>
</body>
</html>