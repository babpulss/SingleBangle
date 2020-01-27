<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.15/dist/summernote.min.js"></script>
<title>post Notice</title>
<link rel="stylesheet" href="/css/nav.css">
<style>
#bHeader {
	background-color: #0085cb;
	border-radius: 10px 10px 0 0;
	height: 40px;
	margin-top: 80px;
}

#bTitles span {
	margin-left: 10px;
	width: 50px;
	display: inline-block;
}

#id {
	border: none;
	border-bottom: 1px solid black;
	width: 80%;
	margin-bottom: 10px;
}

#title {
	border: none;
	border-bottom: 1px solid black;
	width: 80%;
	margin-bottom: 10px;
}

#bFooter {
	border-radius: 0 0 10px 10px;
	background-color: #dce3e8;
	height: 20px;
}

#btns {
	margin: 20px 110px 0 110px;
	display: flex;
	justify-content: center;
}

#btns>button:first-child, #btns>div>button {
	border: none;
	width: 50px;
	height: 30px;
	border-radius: 10px;
	margin-right: 20px;
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

#summernote {
	border: 1px solid black;
}

@media ( max-width : 600px ) {
	#bHeader {
		border-radius: 0;
	}
	#bFooter {
		border-radius: 0;
	}
}
</style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
	<div id="mainWrapper">
		<form id="frm" action="/notice/postNotice" method="post">
			<div id="bHeader"></div>
			<div id="bTitles">
				<div>
					<span>Title: </span><input type="text" id="title" name="title" value="${dto.title}">
				</div>
			</div>
			<div id="summernote"></div>
			<input type="hidden" id="contents" name="contents">
			<div id="btns">
				<button type="button" id="toList">목록</button>
				<button>수정 완료</button>
			</div>
			<div id="bFooter"></div>
		</form>
	</div>
	<script>
    $(document).ready(function() {
        $('#summernote').summernote({
            height: 500,
            lang: "ko-KO",
            airMode: true
        });
		$(".note-editable").html("${dto.contents}");
    });
    $("#frm").on("submit", function() {
        var content = $(".note-editable").html();
        if (content.trim() == "") {
            alert('editor content is empty');
            return false;
        }

        $("#contents").val(content);
    });
    $("#toList").click(() => {
    	location.href="/notice";
    })
  </script>
</body>
</html>