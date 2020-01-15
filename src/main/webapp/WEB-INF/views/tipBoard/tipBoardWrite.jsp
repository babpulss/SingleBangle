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
<script>
	$(function(){
		$("#frm").on("submit",function(){
			$("#contents").val($(".note-editable").html());
		});
	})
</script>
</head>
<body>
	<form action="writeProc.bo" method="post" id="frm">
		제목: <input type="text" name="title"><br>
		<select id="selectCategory" name="category">
			<option value="1">청소</option>
			<option value="2">요리</option>
			<option value="3">동식물</option>
			<option value="4">건강</option>
			<option value="5">기타</option>
		</select>
		<textarea id="contents" name="contents" hidden></textarea>
		<input type="submit" value="전송">
	</form>
	<div id="summernote"></div>
    <script>
      $('#summernote').summernote({
    	  placeholder: 'Hello bootstrap 4',
          tabsize: 2,
          height: 100,
          width: 700
      });
    </script>
</body>
</html>
