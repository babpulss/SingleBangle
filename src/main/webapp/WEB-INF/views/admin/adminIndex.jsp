<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지에 오신 것을 환영합니다</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="/css/nav.css">
<style>
#mainWrapper {
	margin-top: 80px;
	font-family: 'BMHANNAAir';
}
</style>
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/>
<div id="mainWrapper">
<div class="list">
	<button id="viewBlackList"> 블랙리스트 조회 </button>
	<button id="viewReporting"> 신고접수 확인 조회 </button>
</div>
	<h1>대쉬보드</h1>
	<!-- 	결과물 출력 섹션 -->
	<div id="screen">
	<iframe src="http://192.168.60.18:5601/s/singlebangle/app/kibana#/dashboard/d2be1710-3ce2-11ea-b532-493c62d14a9f?embed=true&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-2y,to:now))&_a=(description:'%EC%8B%B1%EA%B8%80%EB%B0%A9%EA%B8%80+%EB%8C%80%EC%89%AC%EB%B3%B4%EB%93%9C',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),panels:!((embeddableConfig:(),gridData:(h:11,i:ceba8d60-c876-4c05-8f2a-8f0f922b219d,w:27,x:0,y:0),id:'2d5b6120-3cd7-11ea-b532-493c62d14a9f',panelIndex:ceba8d60-c876-4c05-8f2a-8f0f922b219d,type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:11,i:f394da4c-55d7-452e-9191-d8babbc06c24,w:10,x:27,y:0),id:'347cdac0-3ce0-11ea-b532-493c62d14a9f',panelIndex:f394da4c-55d7-452e-9191-d8babbc06c24,type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:11,i:c5e9c00b-7c07-4b13-acbe-6bd17a0b72ad,w:11,x:37,y:0),id:'2b8a6620-3ce1-11ea-b532-493c62d14a9f',panelIndex:c5e9c00b-7c07-4b13-acbe-6bd17a0b72ad,type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:15,i:'0566caf7-afd2-49a0-8323-0550fbe6d8d3',w:24,x:0,y:11),id:'593af520-3cd8-11ea-b532-493c62d14a9f',panelIndex:'0566caf7-afd2-49a0-8323-0550fbe6d8d3',type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:15,i:'4cdbd570-8c4a-414b-a9c8-805c2eabe4b2',w:24,x:24,y:11),id:'89e15bd0-3ce0-11ea-b532-493c62d14a9f',panelIndex:'4cdbd570-8c4a-414b-a9c8-805c2eabe4b2',type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:16,i:b2b67097-535d-46d5-8c14-bc37272cafef,w:24,x:0,y:26),id:e7efef20-3ce5-11ea-b532-493c62d14a9f,panelIndex:b2b67097-535d-46d5-8c14-bc37272cafef,type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:16,i:'2d960841-de46-43b1-90cb-facc3f33edaf',w:24,x:24,y:26),id:cd401010-3ce0-11ea-b532-493c62d14a9f,panelIndex:'2d960841-de46-43b1-90cb-facc3f33edaf',type:visualization,version:'7.5.1')),query:(language:kuery,query:''),timeRestore:!t,title:SingleBangle,viewMode:view)" height="1200" width="100%"></iframe>
	</div>
</div>
<script>
	$("#viewBlackList").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewBlackList";
	});
	$("#viewReporting").on("click", function() {
		location.href="${pageContext.request.contextPath}/admin/viewReporting";
	});
</script>
</body>
</html>