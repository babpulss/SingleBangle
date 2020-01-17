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
				<img src="img/index/logo.png">
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
				<li class="has-subnav sidebar"><a href="${pageContext.request.contextPath}/board/boardList.bo"> <i
						class="fa fa-archive fa-2x"></i> <span class="nav-text sidebar">
							리빙포인트 </span>
				</a></li>
				<li class="has-subnav"><a href="${pageContext.request.contextPath}/hosp/hospList.hp"> <i
						class="fa fa-map-marker fa-2x"></i> <span class="nav-text">
							우리동네 </span>
				</a></li>
				<li class="has-subnav"><a href="#"> <i
						class="fa fa-book fa-2x"></i> <span class="nav-text"> 문화생활
					</span>
				</a></li>
				<li><a href="#"> <i class="fa fa-home fa-2x"></i> <span
						class="nav-text"> 랜선집들이 </span>
				</a></li>
				<li><a href="#"> <i class="fa fa-comments fa-2x"></i> <span
						class="nav-text"> re마켓 </span>
				</a></li>
				<li><a href="#"> <i class="fa fa-dollar fa-2x"></i> <span
						class="nav-text"> 가계부 </span>
				</a></li>
			</ul>
		</nav>

		<!-- 오른쪽 메뉴바 -->
		<div id="rightSidebar" class="rightSidebar">
			<form action="${pageContext.request.contextPath}/member/login.mem"
				method="post">
				<ul class="rightSidebar">
					<li class="rightSidebar">ID: <input type="text"
						class="rightSidebar" name="id" id="id"><br>
					</li>
					<li class="rightSidebar">PW: <input type="password"
						class="rightSidebar" name="pw" id="pw"><br>
					</li>
					<li class="rightSidebar">
						<button id="login">Login</button>
						<button type="button" id="joinBtn">Join</button>
					</li>
					<li class="rightSidebar">hello</li>
					<li class="rightSidebar">hello</li>
					<li class="rightSidebar">hello</li>
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
					싱글을 위한 <br>싱글에 의한
				</div>
			</div>
			<div id="imgBox">
				<div class="imgDiv">
					<img src="/img/index/cate_living.png"> Riders on the storm<br>
					Riders on the storm<br> Riders on the storm<br>
					<div></div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_local.png">
					<div>
						foo<br> foo<br>
					</div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_reMarket.png">
					<div>bar bar bar bar bar bar bar bar bar bar bar bar bar bar
						bar bar bar</div>
				</div>
				<div class="imgDiv">
					<img src="/img/index/cate_account.png">
					<div>
						Recoder <br>
					</div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<div id="fourthRow">
			<div class="col-12"></div>
			<div id="psWrapper">
				<div class="d1 a1"></div>
				<div class="d2 b1">어쩌구 저쩌구</div>
				<div class="d2 b2">여기가 메인입니당</div>
				<div class="d1 a2"></div>
				<div class="d1 a3"></div>
				<div class="d2 b3">메롱</div>
			</div>
		</div>
		<div id="footer">
			<div>
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
			</div>
			<div>
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
			<div id="footer3"><strong>ⓒ 2020 · SingleBanlge</strong></div>
		</div>
	</div>

	<script src="/js/index/index.js"></script>
	
	<script>
		// 회원가입 페이지로 이동
		$("#joinBtn").on("click", function(){
			location.href="${pageContext.request.contextPath}/member/signUp.mem";
		})
	</script>
</body>
</html>