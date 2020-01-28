<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Single Bangle</title>
<link rel="stylesheet" href="/css/nav.css" />
<link rel="stylesheet" href="/css/index/index.css" />
<link rel="stylesheet" href="/css/footer.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<jsp:include page="/resources/jsp/nav.jsp" />
	<!-- 메인 메뉴 -->
	<div id="mainWrapper">
		<div id="firstRow">
			<span>SINGLE BANGLE</span>
			<div class="typing-txt1">
				<ul>
					<li>싱글이</li>
					<li></li>
					<li></li>
				</ul>
			</div>
			<div class="typing-txt2">
				<ul>
					<li>방글할 때까지</li>
					<li>Bangle 할 때까지</li>
					<li>Single Bangle</li>
				</ul>
			</div>
			<div class="typing">
				<ul>
					<li></li>
					<li></li>
					<li></li>
				</ul>
			</div>
		</div>
		<div id="secondRow">
			<div>
				<img id="mainPic" src="/img/index/main.png">
			</div>
		</div>
		<div id="thirdRow">
			<div>
				<div>
					싱글에 의한 <br> 싱글을 위한 <br>
				</div>
			</div>
			<div id="imgBox">
				<div class="imgDiv" style="cursor:pointer;">
					<img src="/img/index/cate_living.png">
					<div class="indexText">Living Point</div>
				</div>
				<div class="imgDiv" style="cursor:pointer;">
					<img src="/img/index/cate_local.png">
					<div class="indexText">
						혼밥/혼술 플레이스<br> 병원 위치검색
					</div>
				</div>
				<div class="imgDiv"  style="cursor:pointer;">
					<img src="/img/index/cate_reMarket.png">
					<div class="indexText">
						쇼핑을 바꾸는 쇼핑<br> Re:Market
					</div>
				</div>
				<c:choose>
            <c:when test="${loginInfo==null}">
                <div class="imgDiv" style="cursor:pointer;">
					<img onclick="alert('로그인 후 이용가능합니다.')" src="/img/index/cate_account.png">
					<div class="indexText">나만의 가계부를 PDF로</div>
				</div>		
            </c:when>
            <c:otherwise>
            <div class="imgDiv" style="cursor:pointer;">
					<img src="/img/index/cate_account.png" onclick="location.href='${pageContext.request.contextPath}/accountBook/accountBook'">
					<div class="indexText">나만의 가계부를 PDF로</div>
				</div>
            </c:otherwise>
        </c:choose>
				
			</div>
		</div>
		<div id="fourthRow">
			<div class="pic1">
				<h1>혼족이란?</h1>
				<br> 혼자 밥을 먹거나 여가생활과 쇼핑을 즐기며, 여행도 홀로 떠나는 등<br> 혼자만의 활동을
				즐기고 다른 사람과 섞이지 않고 취미를 즐기는 사람을 일컫는 말
			</div>
			<div>
				<h2>나를 위한 최고의 선택</h2>
				<br> 누군가는 말합니다. 혼자라 외롭지 않냐고.<br> 그러나, 혼자가 주는 큰 가치, 합리적
				라이프스타일<br> 나를 위한 최고의 선택을 하기에 더 행복합니다.<br> 싱글방글은 혼자인 당신을 위한
				최고의 선물입니다.<br>
			</div>
			<div class="pic2"></div>
			<div class="pic3"></div>
			<div>
				혼자 살 수 밖에 없고,<br> 혼자 살 수 있게 되었고,<br> 혼자 살고 싶다.<br>
			</div>
		</div>
		
	</div>
	
	<jsp:include page="/resources/jsp/footer.jsp" />

</body>
</html>
