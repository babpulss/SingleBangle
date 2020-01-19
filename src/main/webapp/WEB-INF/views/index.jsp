<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Single Bangle</title>
<link rel="stylesheet" href="/css/index/index.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="wrapper">
		<!-- 네비 바 -->
		<div id="topbar">
			<div id="nav" class="sidebar">
				<div class="bar1 sidebar"></div>
				<div class="bar2 sidebar"></div>
				<div class="bar3 sidebar"></div>
			</div>
			<div id="logo">
				<img src="img/index/logos/logo.png">
			</div>
			<c:choose>
				<c:when test="${loginInfo==null}">
					<span id="rightLogin" class="rightSidebar">Login</span>
					<span id="rightJoin" class=""><a
						href="${pageContext.request.contextPath}/member/signUp.mem">Join</a></span>
				</c:when>
				<c:otherwise>
					<span id="rightMyPage"><a
						href="${pageContext.request.contextPath}/member/myPage"
						id="myPageBtn">My Page</a></span>
					<span id="rightLogout"><a
						href="${pageContext.request.contextPath}/member/logout.mem"
						id="logoutBtn">Logout</a></span>
				</c:otherwise>
			</c:choose>
		</div>
		<nav id="sidebar" class="main-menu sidebar">
			<ul id="navBar" class="sidebar">
				<li class="sidebar"><a href="#"> <i
						class="fa fa-exclamation fa-3x"></i> <span
						class="nav-text sidebar"> 공지사항 </span>
				</a></li>
				<li class="has-subnav sidebar"><a
					href="${pageContext.request.contextPath}/board/boardList.bo"> <i
						class="fa fa-archive fa-2x"></i> <span class="nav-text sidebar">
							리빙포인트 </span>
				</a></li>
				<li class="has-subnav sidebar"><a
					href="${pageContext.request.contextPath}/hosp/hospList.hp"> <i
						class="fa fa-map-marker fa-2x"></i> <span class="nav-text sidebar">
							우리동네 </span>
				</a></li>
				<li class="has-subnav sidebar"><a href="#"> <i
						class="fa fa-book fa-2x"></i> <span class="nav-text sidebar">
							문화생활 </span>
				</a></li>
				<li class="has-subnav sidebar"><a href="#"> <i
						class="fa fa-home fa-2x"></i> <span class="nav-text sidebar">
							랜선집들이 </span>
				</a></li>
				<li><a
					href="${pageContext.request.contextPath }/market/boardList.do">
						<i class="fa fa-comments fa-2x"></i> <span class="nav-text">
							re마켓 </span>
				</a></li>
				<li class="has-subnav sidebar"><a href="#"> <i
						class="fa fa-dollar fa-2x"></i> <span class="nav-text"> 가계부
					</span>
				</a></li>
			</ul>
		</nav>

		<!-- 오른쪽 메뉴바 -->
		<div id="rightSidebar" class="rightSidebar">
			<br>
			<div id="loginTitle">
				<b>싱글방글 로그인</b>
			</div>
			<br>

			<form action="${pageContext.request.contextPath}/member/loginProc.mem" method="post">
				<ul class="rightSidebar">
					<li class="rightSidebar"><input type="text"
						class="rightSidebar loginVal" id="id" name="id" placeholder=" ID"><br>
					</li>
					<li class="rightSidebar"><input type="password"
						class="rightSidebar loginVal" id="pw" name="pw"
						placeholder=" PASSWORD"><br></li>
					<li class="rightSidebar" id="loginBtnBox">
						<button class="loginBtns" id="loginBtn">Login</button>
					</li>
					<li class="rightSidebar" id="joinBox">
						<a href="${pageContext.request.contextPath}/member/findId.mem">아이디 찾기</a> | 
						<a href="${pageContext.request.contextPath}/member/findPw.mem">비밀번호 찾기</a> | 
						<a href="${pageContext.request.contextPath}/member/signUp.mem">회원가입</a>
					</li>
				</ul>
			</form>
		</div>
	</div>

	<!-- 메인 메뉴 -->
	<div id="mainWrapper">
		<div id="firstRow">
			<span>SINGLE BANGLE</span><br> <span>싱글이</span><br> <span>방글할때까지</span>
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
				<div class="imgDiv">
					<img src="/img/index/cate_living.png">
					<div class="indexText">Living Point</div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_local.png">
					<div class="indexText">
						혼밥/혼술 플레이스<br> 병원 위치검색
					</div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_reMarket.png">
					<div class="indexText">
						쇼핑을 바꾸는 쇼핑<br> Re:Market
					</div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_account.png">
					<div class="indexText">나만의 가계부를 PDF로...</div>
				</div>
			</div>
		</div>
		<div id="fourthRow">
			<div class="pic1">
			<h1>혼족이란?</h1><br>
			혼자 밥을 먹거나 여가생활과 쇼핑을 즐기며, 여행도 홀로 떠나는 등<br>
			혼자만의 활동을 즐기고 다른 사람과 섞이지 않고 취미를 즐기는 사람을 일컫는 말
			</div>
			<div>
				<h2>나를 위한 최고의 선택</h2><br> 
				누군가는 말합니다. 혼자라 외롭지 않냐고.<br> 
				그러나, 혼자가 주는 큰 가치, 합리적 라이프스타일<br> 
				나를 위한 최고의 선택을 하기에 더 행복합니다.<br>
				싱글방글은 혼자인 당신을 위한 최고의 선물입니다.<br>
			</div>
			<div class="pic2"></div>
			<div class="pic3"></div>
			<div> 혼자 살 수 밖에 없고,<br> 혼자 살 수 있게 되었고,<br> 혼자 살고 싶다.<br> </div>
		</div>
		<div id="footer">
			<div id="footer1">
				<div>
					<a href="#"><b>이용규칙</b></a>
				</div>
				<div>
					<a href="#"><b>운영알림판</b></a>
				</div>
				<div>
					<a href="#"><b>도움말</b></a>
				</div>
				<div>
					<a href="#"><b>버그신고</b></a>
				</div>
			</div>
			<div id="footer2">
				<div>
					<a href="#">개인정보 처리방침</a>
				</div>
				<div>
					<a href="#">이용약관</a>
				</div>
				<div>
					<a href="#">책임의 한계와 법적고지</a>
				</div>
				<div>
					<a href="#">청소년 보호정책</a>
				</div>
			</div>
		</div>
		<div id="footer3">
			<img src="/img/index/logos/fullLogoColor.png"> <strong>ⓒ
				2020 · SingleBanlge</strong>
		</div>
	</div>

	<script src="/js/index/index.js"></script>

</body>
</html>
