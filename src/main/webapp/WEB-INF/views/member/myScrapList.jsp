<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <title>스크랩 목록</title>
        
        <link rel="stylesheet" href="/css/nav.css">
        <style>
            *{
                box-sizing: border-box;
            }
            body{
                background-color: #f5f5f5;
            }

            #myPageContainer{
                width: 500px;
                margin: auto;
            }
            #myPageHeader{
                width: 500px;
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
                width: 500px;
                text-align: center;
                margin: auto;
            }
            .myMenu{
                display: inline-block;
                width: 120px;
                text-decoration: none;
                color: #b2b2b2;
            }
            .myMenu:hover{
            	text-decoration: none;
            	color: #b2b2b2;
            }
            #myScrap{
                color: #0085cb;
            }
            .menuIcon img{
                height: 80px;
            }
            .menuText{
                font-size: 16px;
            }
            
            #scrapContainer{
            	width: 80%;
            	min-width: 500px;
            	margin: auto;
            }
            .pagination {
            	text-align: center;
            }
        </style>
    </head>
    <body>
    	<jsp:include page="/resources/jsp/nav.jsp"/>
    	
	    <br><br><br>
    	<div id="mainWrapper">
	        <div id="myPageContainer">
	            <div id="myPageHeader">
	                <div id="myPageTitle"><b>스크랩 목록</b></div>
	                <div id="myPageNotice"><b>${loginInfo.id}</b>님이 스크랩하신 글 목록입니다.</div>
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
	                        <img src="/img/member/modify_unchecked.png" alt="">
	                    </div>
	                    <div class="menuText">
	                        <b>정보 수정</b>
	                    </div>
	                </a>
	                <a href="${pageContext.request.contextPath}/member/myScrap.mem?currentPage=1" class="myMenu" id="myScrap">
	                    <div class="menuIcon">
	                        <img src="/img/member/bookmark01_checked.png" alt="">
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
	        </div>
	        
	        <br><br><br>
	        <div id="scrapContainer">
		        <h3>My Scrap List</h3>
		        <div id="scrapBox">
		            <div class="row">
		                <div class="col-1">글번호</div>
		                <div class="col-2">카테고리</div>
		                <div class="col-7">제목</div>
		                <div class="col-2">스크랩날짜</div>
		            </div>
		            <c:forEach items="${myScrapList}" var="dto">
		                <div class="row">
		                    <div class="col-1">${dto.rootSeq}</div>
		                    <div class="col-2">${dto.category}</div>
		                    <div class="col-7"><a href="${pageContext.request.contextPath}/board/detailView.bo?seq=${dto.rootSeq}">${dto.title}</a></div>
		                    <div class="col-2">${dto.scrapDate}</div>
		                </div>
		            </c:forEach>
					<div class="pagination">${pagination}</div>
		        </div>
		        <button id="toMyPage">돌아가기</button>
	        </div>
		</div>
		<br><br><br>
        
        <script>
            $("#toMyPage").on("click",function(){
                location.href = "${pageContext.request.contextPath}/member/myPage.mem";
            })
        </script>
    </body>
</html>