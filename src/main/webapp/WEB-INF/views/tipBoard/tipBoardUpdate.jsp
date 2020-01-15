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

</head>
<body>
	<form action="${pageContext.request.contentType}/board/updateTip.bo?seq=${dtoB.seq}" method="post" id="frm" onsubmit="return boardWriteCheck()">
	<h3 id="header">글 수정</h3>
	<div id="wirteBox">
		제목: <input type="text" id="title" name="title" size="50" value="${dtoB.title }" required>
		<br>
		카테고리: <select id="selectCategory" name="category">
			<option value="1">청소</option>
			<option value="2">요리</option>
			<option value="3">동식물</option>
			<option value="4">건강</option>
			<option value="5">기타</option>
		</select>
		<br>
		내용<br>
		<textarea rows="30" cols="50" name="contents" id="contents" style="resize:none;" hidden></textarea>
		<br>
		<div id="btns">
			<input type="submit" id="btnSubmit" value="완료">
			<button type="button" id="btnCancel">취소</button>
		</div>
	</div>
	</form>
		<div id="summernote"></div>
    <script>

    $("#selectCategory").val("${dtoB.category}");
    $(document).ready(function(){
	    $(".note-editable").html('${dtoB.contents}');    	
    })
    
    $("#btnCancel").on("click",function(){
    	location.href = "${pageContext.request.contextPath}/board/detailView.bo";
    });
    $('#summernote').summernote({
        tabsize: 2,
        height: 100,
        width: 700
    });
	
    $("#frm").on("submit",function(){
		$("#contents").val($(".note-editable").html());
	});
    </script>
</body>
</html>