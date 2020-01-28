<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
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
        .note-toolbar{
        z-index: 1;
        }
        #writeForm{
        width:700px;
        margin:auto;
        }
        .note-editable{
        min-height: 500px;
        }
        #frm{
        width:700px;
        }
        .writeIndex{
        width:60px;
        display:inline-block;
        text-align:right;
        }
        #writeTitle{
        width:700px;
        heignt:300px;
        background-color: #dfeaeb;
        font-size: 20px;
        text-align:right;
        padding: 10px;
        }
        #writeBtns button{
        width:150px;
        border-radius: 10px;
        shadow:none;
        background-color: none;
   		border: 1px solid #c8cccc;
        }
</style>
<script>
	$(function(){
		$("#frm").on("submit",function(){
			$("#contents").val($(".note-editable").html());
		});
	})
</script>
</head>
<body>
	<c:choose>
            <c:when test="${loginInfo==null}">
                <script>
                    alert("로그인 후 이용하실 수 있습니다.");
                    location.href="${pageContext.request.contextPath}/member/login.mem";
                </script>      
            </c:when>
       </c:choose>

<jsp:include page="/resources/jsp/nav.jsp"/>
<br>
<div id="mainWrapper">
	<div id="writeForm">
		<form action="writeProc.bo" method="post" id="frm">
		<div id="writeTitle">리빙포인트 게시글 작성 </div>
		<hr>
		<span class="writeIndex">카테고리</span>  <select id="selectCategory" name="category">
			<option value="1">청소</option>
			<option value="2">요리</option>
			<option value="3">건강</option>
			<option value="4">동식물</option>
			<option value="5">기타</option>
		</select> &nbsp;&nbsp;
		<input type="text" name="title" style="width:400px; border:none; border-bottom: 1px solid #c5c7c9;" placeholder="  게시글 제목을 입력하세요.">
		<br><br>
		<textarea id="contents" name="contents" hidden></textarea>
		<div id="summernote"></div>
		<br>
		<div style="text-align:center;" id="writeBtns">
	<button type="submit">전송</button>
	<button type="button" id="backList">취소</button>
		</div>
	</form>
	<br><br>
	</div>
	</div>
    <script>
      $('#summernote').summernote({
    	  placeholder: ' 당신의 싱글생활 꿀팁을 공유해주세요!',
          tabsize: 2,
          height: 100,
          width: 700
      });
      
      $("#backList").on("click",function(){
    	  location.href = "${pageContext.request.contextPath}/board/boardList.bo";
      })
    </script>
</body>
</html>
