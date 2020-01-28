<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>re마켓</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/css/nav.css"/>
<link rel="stylesheet" href="/css/index/index.css"/>
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
      <link rel="stylesheet" href="/css/footer.css">
	<script>
		$(function(){
			$("#boardfrm").on("submit", function(){
				$("#content").val($(".note-editable").html());
			})
		})
	</script>
<style>
	
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
            text-align: center;
        }
        .bRow:last-child {
            border-radius: 0 0 10px 10px;
            background-color: #e05252;
            height: 50px;
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
        .note-toolbar card-header{
        	z-index : 1;
        }
</style>
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
<form action="write.do" method="post" id="frm" enctype="multipart/form-data" id="boardfrm">
<div style="width: 700px; margin: auto; position: relative; top: 80px;">
<input style="width: 100%; border: none; border-bottom: 1px solid black" type="text" name="title" id="title" placeholder="제목을 입력하세요" required="required">
<br><input style="width: 30%; border: none; border-bottom: 1px solid black" type="text" name="price" id="price" placeholder="가격을 입력하세요" required="required">원
<select name="category">
	<option>디지털/가전</option>
	<option>가구/인테리어</option>
	<option>생활/가공식품</option>
	<option>의류</option>
	<option>잡화</option>
	<option>뷰티</option>
	<option>스포츠/레저</option>
	<option>게임/취미</option>
	<option>기타</option>	
</select><br>
<textarea style="display:none;" name="content" id="content"></textarea>
<div id="summernote"></div>
	 <div style="text-align: right;">
	 <button type="button" id="confirm">제출</button></div>
	 </div>
</form>
<jsp:include page="/resources/jsp/footer.jsp" />
    <script>
      $('#summernote').summernote({
    	  height: 500,
    	  placeholder: "내용을 입력하세요"
      })
      
      $("#price").on("focusout",function(){
    	  var regex = /^[0-9]*$/;
    	  var data = $("#price").val();
          var result = regex.exec(data);
          
    	  if(data != "" && result == null){
    		  $("#price").val("");
    	  	alert("가격은 숫자만 입력이 가능합니다.");
    	  }
      })
      
      $("#price").on("focusout", function(){
    	  var regex = /^\d.{1,6}$/;
          var data = $("#price").val();
          var result = regex.exec(data);
          
          if(data != "" && result == null){
        	  $("#price").val("");
        	  alert("가격은 1000만원을 넘을 수 없습니다.");
          }
      })
      
      $("#title").on("focusout",function(){
    	  var regex = /^[a-z가-힣ㄱ-ㅎ0-9!@#$%^&*(.)(-)_=(+)].{0,50}$/;
    	  var data = $("#title").val();
    	  var result = regex.exec(data);
    	  if($("#title").val() != "" && result == null){
    		  $("#title").val("");
    		  alert("사용가능한 글자수를 초과하였습니다 \n 제목은 최대 50자까지 사용가능합니다.");
    	  }
      })
           
      $("#confirm").on("click",function(){
    	  $("#content").val($(".note-editable").html());
    	  var regex = /<img.*/;
          var data = $("#content").val();
          var result = regex.exec(data);
    	  if($("#content").val() == "" || result == null || $("#price").val()=="" || $("#title").val() == ""){
    	  	alert("내용을 모두 입력해주세요. \n (이미지는 반드시 한장 이상 첨부해야합니다.)");
    	  	return;
    	  }else {
    		 $("#frm").submit();
    	  }
    		  
      })
    </script>
</body>
</html>