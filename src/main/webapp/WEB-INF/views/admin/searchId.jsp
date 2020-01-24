<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 추가</title>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"></script>
  <style>
@font-face {
	font-family: 'BMHANNAAir';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

* {
	font-family: 'BMHANNAAir';
}
.reasonBox {
      width: 100%;
      height: 100px;
      line-height: 100px;
}
.reasonBox span {
	vertical-align: top;
}
.reasonBox textarea {
	height: 100%;
}
.btns {
	display: flex;
	justify-content: center;
}
.btns button {
	margin-left: 10px;
}
  </style>
</head>
<body>
<c:choose>
<c:when test="${empty loginInfo}">
	<script>
		location.href= "/";
	</script>
</c:when>
<c:otherwise>
	<c:choose>
	<c:when test="${!empty checkId}">
		이미 리스트에 동록된 회원입니다.<br>
		다시 확인해 주세요<br>
		<hr>
		<button class="close">확인</button>
	</c:when>
	<c:when test="${!empty dto}">
		<form action="/admin/block" method="post" id="frm">
		<div>블랙리스트 추가 대상: ${dto.id}</div>
		<input type="hidden" name="id" value="${dto.id}">
		<hr>
		<div class="reasonBox">
		<span>제재 사유: </span><textarea id="reason" name="reason" cols=40 rows=6 style="resize: none"></textarea>	
		</div>
		<hr>
		제재 시간 설정: 
		<select id="select" name="blockTime">
			<option value="1">1시간</option>
			<option value="3">3시간</option>
			<option value="6">6시간</option>
			<option value="24">24시간</option>
			<option value="72">3일</option>
			<option value="8760">1년</option>
			<option value="other">기타</option>
		</select>
		<span id="inputOther"></span>
		<div class="btns">
		<button>확인</button>
		<button class="close" type="button">취소</button>
		</div>
		</form>
	</c:when>
	<c:otherwise>
		  존재하지 않는 아이디입니다.<br>
		다시 확인해 주세요	
		<hr>
		<button class="close">확인</button>
	</c:otherwise>
	</c:choose>
	<script>
		$(".close").click(() => {
			window.close();
		})	
		$("#select").on("change", function() {
			var bar = $("#select").val();
			if (bar == "other") {
				$("#select").attr("name", null);
				$("#inputOther").append("<input type='text' id='other'" + 
						"name='blockTime'>")
			} else {
				$("#select").attr("name", "blockTime");
				$("#other").remove();	
			}
			
		})
		$("#frm").on("submit", (e) => {
			var foo = $.trim($("#reason").val());
			if (foo == "") {
				alert("내용을 입력해 주세요");
				return false;
			}
			var bar = $("[name=blockTime]").val();
			if (!$.isNumeric(bar)) {
				alert("숫자만 입력해 주세요");	
				return false;
			}
		})
	</script>

</c:otherwise>
</c:choose>
</body>
</html>