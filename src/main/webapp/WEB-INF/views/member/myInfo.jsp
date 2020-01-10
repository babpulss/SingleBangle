<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>회원 정보</title>
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
.moveBtns{
	width:120px;
	height:40px;
	font-size:16px;
}
</style>
</head>
<body>
	<div id="infoContainer">
		<div id="infoHeader">
			<div id="infoTitle">회원정보</div>
			<div id="infoNotice"><b>${infoResult.name}</b>님의 소중한 개인정보입니다.</div>
		</div>
		<br>
		<table id="allInfo">
			<tbody>
				<tr>
					<td class="info1">아이디</td>
					<td class="info2"><b>${infoResult.id}</b></td>
				</tr>
				<tr>
					<td class="info1">비밀번호 확인 질문</td>
					<td class="info2">
						<select id="pwHint" name="pwHint" size="1" disabled>
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
					</td>
				</tr>
				<tr>
					<td class="info1">비밀번호 확인 답변</td>
					<td class="info2">${infoResult.pwAnswer}</td>
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
			<button type="button" class="btns moveBtns" id="modifyBtn">정보 수정</button>
		</div>
	</div>

	<script>
		// 선택했던 비밀번호 확인 질문 유지하기
		$("#pwHint>option[value=${infoResult.pwHint}]").attr("selected", true);
	
		// 정보 수정 페이지로 이동
		$("#modifyBtn").on("click", function(){
			location.href="${pageContext.request.contextPath}/member/modifyInfo.mem";
		})
	</script>
</body>
</html>