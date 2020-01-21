<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
        <title>혼밥/혼술</title>
        
        <link rel="stylesheet" href="/css/nav.css">
        <style>
            /* 메뉴 폰트 */
            @font-face {
                font-family: 'BMHANNAAir';
                src:
                    url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff')
                    format('woff');
                font-weight: normal;
                font-style: normal;
            }
            html, body { margin: 0px; padding: 0px;}
            * {
                box-sizing: border-box; 
                font-family: 'BMHANNAAir';
            }
            #board {
                margin: 65px 110px 0 110px;
            }
            #bHeader {
                background-color: #0085cb;
                border-radius: 10px 10px 0 0;
            }
            .bRow {
                display: flex;
                justify-content: flex-start;
                align-items: center;
            }
            .bRow * {
                line-height: 50px;
                text-align: center;
            }
            .bRow>span:first-child {
                flex-basis: 10%;
            }
            .bRow>span:nth-child(2) {
                flex-basis: 50%;
                text-align: left;
            }
            .bRow>span:nth-child(3) {
                flex-basis: 20%;
            }
            .bRow a {
                text-decoration: none;
            }
            .bRow>span:nth-child(4) {
                flex-basis: 10%;
            }
            .bRow>span:last-child {
                flex-basis: 10%;
            }
            .bRow:last-child {
                border-radius: 0 0 10px 10px;
                background-color: #e05252;
            }
            #btns {
                margin: 20px 110px 0 110px;
                display: flex;
                justify-content: space-between;
            }
            #btns>button:first-child, #btns>div>button {
                border: none;
                width: 50px;
                height: 30px;
                border-radius: 10px;
            }
            #btns>div>input {
                width: 100px;
                height: 30px;
                border-radius: 10px;
            }
            #btns>button:last-child {
                border: none;
                width: 80px;
                height: 30px;
                border-radius: 10px;
            }
            @media ( max-width: 600px ) {
                #board {
                    margin: 65px 0 0 0;
                }
                #bHeader {
                    border-radius: 0;
                }
                .bRow>span:first-child {
                    display: none;
                }
                #btns {
                    margin: 20px 0 0 0;
                }
            }
        </style>
    </head>
    <body>
	    <jsp:include page="/resources/jsp/nav.jsp"/>
	    
	    <br><br><br>
	    <div id="mainWrapper">
	        <div id="board">
	            <div id="bHeader" class="bRow">
	                <span>번호</span>
	                <span>제목</span>
	                <span>작성자</span>
	                <span>작성일</span>
	                <span>조회수</span>
	            </div>
	            
	            <c:forEach items="${list}" var="dto">
		            <div class="bRow">
		                <span>${dto.seq}</span>
		                <span><a href="${pageContext.request.contextPath}/restaurant/rstDetail.rst?seq=${dto.seq}">${dto.title}</a></span>
		                <span>${dto.writer}</span>
		                <span>${dto.getFormedDate1()}</span>
		                <span>${dto.viewCount}</span>
		            </div>
	            </c:forEach>
	            
	            <div class="bRow" style="height:20px"></div>
	        </div> 
	        <div id="btns">
	            <button type="button" style="color:white; background-color:white;">목록</button>
	            <div>
	                <input type="text" placeholder="search">
	                <button type="button" id="searchBtn">검색</button>
	            </div>
	            <button type="button" id="writeBtn">글쓰기</button>
	        </div>
		</div>
	
        <script>
        	$("#writeBtn").on("click", function(){
        		location.href="${pageContext.request.contextPath}/restaurant/rstWrite.rst";
        	})
        </script>
    </body>
</html>