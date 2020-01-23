<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/css/nav.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<title>Insert title here</title>
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
        	width: 800px;
            margin: auto;
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
            flex-basis: 20%;
        }
        .bRow>span:nth-child(3) {
            flex-basis: 50%;
            text-align: left;
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
        	width: 800px;
            margin: auto;
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
<div id="mainWrapper"> 
	 <div id="board">
        <div id="bHeader" class="bRow">
            <div style="float: left; width: 40%;">미리보기</div>
            <div style="float: left; width: 60%; text-align: center;">제품상세</div>
        </div>
		<c:choose>
			<c:when test="${list == null}">
				<div class="bRow">게시글이 없습니다.</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${navilist }" var="list" varStatus="i">
					<div class="bRow" style="text-align: center">
 					<div style="width: 40%; height: 100%; float: left"><a href="marketDetail.do?seq=${list.seq}">
					<img style="width: 250px; height: 100px; text-align: center;" src ="/files/${fileList[i.index].sys_name}"></a></div>
					<div style="float:left;">${list.title }
					<br>${list.place }
					<br>${list.price }원</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	
		<div class="bRow" style="height:20px"></div>
	</div>
	<br><div style="text-align: center">${navi }</div>
       <br><div id="btns">
        <div style="float:left; width: 10%; text-align: right;"><button type="button">목록</button></div>
        <div style="float:left; width: 50%; text-align: center;">
          	<form action="search.do" method="post">
			<select name="category">
			<option>전체</option>
			<option>디지털/가전</option>
			<option>가구/인테리어</option>
			<option>생활/가공식품</option>
			<option>의류</option>
			<option>잡화</option>
			<option>뷰티</option>
			<option>스포츠/레저</option>
			<option>게임/취미</option>
			<option>기타</option>
			</select>
			<input type="text" placeholder="search" name="title">
            <button>검색</button>
            </form>
        </div>
        <c:choose>
        	<c:when test="${loginInfo != null}">
        		<div style="float:left; width: 10%;"><button type="button" id="write">글쓰기</button></div>
        	</c:when>
        	<c:otherwise>
        		<div style="float:left; width: 10%;">&nbsp</div>
        	</c:otherwise>
        </c:choose>
        
   </div>
</div>
	<script>
		$("#write").on("click", function(){
			location.href="${pageContext.request.contextPath}/market/writeboard.do";
		})
		
	</script>
</body>
</html>