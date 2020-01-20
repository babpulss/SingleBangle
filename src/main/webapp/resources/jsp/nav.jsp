<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<div class="wrapper">
		<!-- 네비 바 -->
		<div id="topbar">
			<div id="nav" class="sidebar">
				<div class="bar1 sidebar"></div>
				<div class="bar2 sidebar"></div>
				<div class="bar3 sidebar"></div>
			</div>
			<div id="navLogo">
				<a href="/"><img src="/img/index/logos/logo.png"></a>
			</div>
			<c:choose>
				<c:when test="${loginInfo==null}">
					<span id="rightLogin" class="rightSidebar">Login</span>
					<span id="rightJoin" class=""><a
						href="${pageContext.request.contextPath}/member/signUp.mem">Join</a></span>
				</c:when>
				<c:otherwise>
					<span id="rightMyPage"><a
						href="${pageContext.request.contextPath}/member/myPage.mem"
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
<script src="/js/index/index.js"></script>