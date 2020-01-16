<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지에 오신 것을 환영합니다</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<div class="list">
		<a href="${pageContext.request.contextPath}/">사용자 페이지 메인</a>
		<a href="${pageContext.request.contextPath}/admin">관리자 페이지 메인</a>
		<a href="${pageContext.request.contextPath}/admin/viewBlackList">블랙리스트 조회</a>
		<a href="${pageContext.request.contextPath}/admin/viewReporting">신고접수 확인 조회</a>
	</div>
	<!-- 	결과물 출력 섹션 -->
	<div id="screen">
	<iframe src="http://192.168.60.18:5601/s/singlebangle/app/kibana#/dashboard/92cedc90-373b-11ea-b62f-9b0b72408aaf?embed=true&_g=(refreshInterval:(pause:!t,value:0),time:(from:now-1y,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),panels:!((embeddableConfig:(title:'%EB%A6%AC%EB%B9%99%ED%8F%AC%EC%9D%B8%ED%8A%B8+%ED%98%84%ED%99%A9%ED%8C%90'),gridData:(h:15,i:be4e8f59-66b9-451b-ae2e-b4e4fa864de9,w:10,x:0,y:0),id:'29b5f450-373b-11ea-b62f-9b0b72408aaf',panelIndex:be4e8f59-66b9-451b-ae2e-b4e4fa864de9,title:'%EB%A6%AC%EB%B9%99%ED%8F%AC%EC%9D%B8%ED%8A%B8+%ED%98%84%ED%99%A9%ED%8C%90',type:visualization,version:'7.5.1'),(embeddableConfig:(title:'%EC%A1%B0%ED%9A%8C%EC%88%98+%EB%A7%8E%EC%9D%80+%EA%B2%8C%EC%8B%9C%EB%AC%BC'),gridData:(h:15,i:f7868c75-c7af-4216-ba91-633be02fe5bb,w:38,x:10,y:0),id:'0cea1540-3745-11ea-b62f-9b0b72408aaf',panelIndex:f7868c75-c7af-4216-ba91-633be02fe5bb,title:'%EC%A1%B0%ED%9A%8C%EC%88%98+%EB%A7%8E%EC%9D%80+%EA%B2%8C%EC%8B%9C%EB%AC%BC',type:visualization,version:'7.5.1'),(embeddableConfig:(),gridData:(h:15,i:c73785c7-2b68-49d8-8747-d2b91fcf1ec1,w:19,x:0,y:15),id:'8fdd28f0-373d-11ea-b62f-9b0b72408aaf',panelIndex:c73785c7-2b68-49d8-8747-d2b91fcf1ec1,type:visualization,version:'7.5.1')),query:(language:kuery,query:''),timeRestore:!t,title:singlebangle-temp,viewMode:view)" height="1000" width="100%"></iframe>
	</div>
</body>
</html>