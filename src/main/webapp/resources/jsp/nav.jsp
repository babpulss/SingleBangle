<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://kit.fontawesome.com/20f9547eb6.js"></script>
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
					<span id="note" style="position: relative; right: 170px; top: 5px;">
					<a href="${pageContext.request.contextPath }/msg/msgList.do?receiver=${loginInfo.id}">
					<img style="width: 20px; height: 20px;" src="/img/msg/msg.png">
					</a></span>
					<c:choose>
						<c:when test="${notRead > 0 }">
							<span class="blinkEle"style="position: fixed; z-index:500 ;right: 150px; top: 13px; font-size: 10px; color: red;">new!</span>
						</c:when>
					</c:choose>
					<span id="rightLogout"><a
						href="${pageContext.request.contextPath}/member/logout.mem"
						id="logoutBtn">Logout</a></span>
				</c:otherwise>
			</c:choose>
		</div>
		<nav id="sidebar" class="main-menu sidebar">
			<ul id="navBar" class="sidebar">
				<li class="sidebar"><a href="/notice"> <i
	style="line-height: 50px" class="fa fa-exclamation"></i> <span
						class="nav-text sidebar"> 공지사항 </span>
				</a></li>
				<li class="has-subnav sidebar"><a
					href="${pageContext.request.contextPath}/board/boardList.bo"> <i
						style="line-height: 50px" class="fa fa-archive"></i> <span class="nav-text sidebar">
							리빙포인트 </span>
				</a></li>
				<li class="has-subnav sidebar"><a
					href="#"><i
						style="line-height: 50px; cursor: default" class="fa fa-map-marker sidebar"></i> <span style="cursor: default;" class="nav-text sidebar">
							우리동네 </span>
				</a>
				<div class="submenu">
					<a href="${pageContext.request.contextPath}/restaurant/rstListY.rst"><div class="sidebar"><span id="submenuSpan"></span><i class="fas fa-utensils sidebar"></i> 혼밥 / 혼술</div></a>
					<a href="${pageContext.request.contextPath}/hosp/hospList.hp"><div class="sidebar"><span id="submenuSpan"></span><i class="far fa-hospital sidebar"></i> 병원 검색</div></a>
				</div>
				</li>
				<li class="has-subnav sidebar"><a href="#"> <i
						style="line-height: 50px" class="fa fa-book"></i> <span class="nav-text sidebar">
							문화생활 </span>
				</a> </li> 
				<li class="has-subnav sidebar"><a href="#"> <i
						style="line-height: 50px" class="fa fa-home"></i> <span class="nav-text sidebar">
							랜선집들이 </span>
				</a></li>
				<li><a
					href="${pageContext.request.contextPath }/market/boardList.do">
						<i style="line-height: 50px" class="fa fa-comments"></i> <span class="nav-text">
							re마켓 </span>
				</a></li>
				<c:if test="${!empty loginInfo}">
				<li class="has-subnav sidebar" id="account"><a href="${pageContext.request.contextPath }/accountBook/accountBook"> <i
						style="line-height: 50px" class="fa fa-dollar fa-2x"></i> <span class="nav-text"> 가계부
					</span>
				</a></li>
				</c:if>
				<c:if test="${!empty loginInfo}">
				<li class="has-subnav sidebar" id="myPageBtn"><a href="${pageContext.request.contextPath }/member/myPage.mem"> <i
						style="line-height: 50px" class="fa fa-portrait fa-2x"></i> <span class="nav-text">마이 페이지 
					</span>
				</a></li>
				</c:if>
				<c:if test="${loginInfo.adminCheck eq \"Y\"}">
				<li class="has-subnav sidebar" id="account"><a href="${pageContext.request.contextPath }/admin"> <i
						style="line-height: 50px" class="fa fa-user-cog fa-2x"></i> <span class="nav-text"> 관리자 페이지 
					</span>
				</a></li>
				</c:if>
			</ul>
		</nav>

		<!-- 오른쪽 메뉴바 -->
		<div id="rightSidebar" class="rightSidebar">
			<br>
			<div id="loginTitle">
				<b>싱글방글 로그인</b>
			</div>
			<br>
			
			<c:choose>
				<c:when test="${loginInfo==null}">
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
				</c:when>
			</c:choose>
		</div>
	</div>
	<script>
	setInterval(function(){
		  $(".blinkEle").toggle();
		}, 250);
	</script>
<script src="/js/index/index.js"></script>