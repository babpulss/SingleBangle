<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
<style>
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
        }
        .bRow>span:nth-child(3) {
            flex-basis: 10%;
            text-align: left;
        }
        .bRow a {
            text-decoration: none;
        }
        .bRow>span:nth-child(4) {
            flex-basis: 20%;
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
            width: 300px;
            height: 30px;
            border-radius: 10px;
            border: 1px solid gray;
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
        .pageNavi{
        	text-decoration: none;
        }
        .pageNavi:hover {
        	color: pink;
        }
        .titleList:hover{
        	color: #de8c98;
        }
</style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
<div id="mainWrapper">
<br><br>
	<h1 style="text-align:center;">검색결과</h1><br>
	<h3 style="text-align:center;">총 ${searchResultSize}건의 게시물이 있습니다.</h3>
	
		<div id="board">
        <div id="bHeader" class="bRow">
            <span>카테고리</span>
            <span>제목</span>
            <span>작성자</span>
            <span>작성일</span>
            <span>조회수</span>
        </div>
        <c:choose>
        <c:when test="${searchResultSize != 0}">
     <c:forEach items="${searchResult}" var="dto">
        <div class="bRow">
				<span> 
				<c:choose>
						<c:when test="${dto.category == 1}">요리</c:when>
						<c:when test="${dto.category == 2}">청소</c:when>
						<c:when test="${dto.category == 3}">건강</c:when>
						<c:when test="${dto.category == 4}">동식물</c:when>
						<c:otherwise>기타</c:otherwise>
				</c:choose>
				</span> 
			<span><a href="${pageContext.request.contextPath}/board/detailView.bo?seq=${dto.seq}">${dto.title}</a></span>
            <span>${dto.writer}</span>
            <span>${dto.getFormedDate()}</span>
            <span>${dto.viewCount}</span>
        </div>
     </c:forEach>
     </c:when>
     <c:otherwise><br><p style="text-align:center;">해당 검색어가 포함된 게시물이 없습니다.</p><br></c:otherwise>
     </c:choose>   
        <div class="bRow" style="height:20px"></div>
   </div>
  <form action="tipSearch.bo" method="get">
	<div id="btns">
		<button type="button" id="btnToBack">메인</button>
		<div>
		<select id="searchType" name="tipCategory">
			<option value="title">제목</option>
			<option value="contents">본문</option>
			<option value="both">제목+본문</option>
		</select> 
			<input type="text" placeholder="  search"  name="searchInput">
			<button type="submit">검색</button>
		</div>
		<button type="button" id="btnToWrite">글쓰기</button>
	</div>
</form>
	<br>
	<div id="paging" style="text-align:center;">${getNavi} </div>
	<br>
</div>

<script>
$("#btnToWrite").on("click",function() {
	location.href = "${pageContext.request.contextPath}/board/toBoardWrite.bo";
})
$("#btnToBack").on("click", function() {
	location.href = "${pageContext.request.contextPath}/";
})
</script>
</body>
</html>