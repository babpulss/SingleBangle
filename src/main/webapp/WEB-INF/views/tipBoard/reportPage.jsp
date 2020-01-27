<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<style>
@font-face {
		font-family: 'BMHANNAAir';
		src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.0/BMHANNAAir.woff')
		format('woff');
		font-weight: normal;
		font-style: normal;
	}	

	*{
	font-family: 'BMHANNAAir';
	font-size: 17px;
	}
	
	#reportForm{
	width: 400px;
	height: 300px;
	background-color: #f0efc7;
	}
	#reportBtns{
	text-align:center;
	}
	.reportIndex{
	width: 100px;
	text-align:right;
	display: inline-block;
	}
</style>
<body>
	<div id="reportForm">
	<div style="text-align:center;"><img src="/img/tipBoard/reportAlert.png" style="width:20px; margin-top:40px; margin-right:5px;"><h3 style="display:inline-block; text-align:center;">신고하신 게시글은 관리자 확인 후 삭제 조치됩니다.</h3></div>
	<form action="reportProc.bo" method="post" id="reportForm">
		<span class="reportIndex">제   목</span> <input type="text" value="${title}" readonly="readonly" style="width:200px"><br><br>
		<span class="reportIndex">작성자</span> <input type="text" value="${writer}" readonly="readonly" style="width:200px"><br><br>
		<span class="reportIndex">신고자</span> <input type="text" value="${loginInfo.id}" name="reporter" readonly="readonly" style="width: 200px;"><br><br>
		<input type="text" value="${url}" name="url" hidden>
		<hr style="width:250px; color:gray">
		<span class="reportIndex">신고사유</span>  <select name="reportReason">
			<option value="1">영리목적/홍보성</option>
			<option value="2">불법정보</option>
			<option value="3">음란성/선정성</option>
			<option value="4">욕설/인신공격</option>
			<option value="5">개인정보노출</option>
			<option value="6">같은 내용의 반복 게시 (도배)</option>
		</select>
		<br><br>
		<div id="reportBtns">
	<button type="submit" id="doReport">신고</button>
	<button type="button" onclick="window.close()" id="cancelReport">취소</button>
		</div>
	</form>
	</div>
	
</body>
</html>