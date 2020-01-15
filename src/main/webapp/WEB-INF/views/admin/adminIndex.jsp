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
	<iframe src="http://localhost:5601/app/kibana#/dashboard/6c95dee0-367b-11ea-b107-e11d867a543d?embed=true&_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-30d,to:now))&_a=(description:'',filters:!(),fullScreenMode:!f,options:(hidePanelTitles:!f,useMargins:!t),panels:!((embeddableConfig:(),gridData:(h:14,i:'62363a5c-c0b3-4f3e-868e-74a7d3dca2a8',w:16,x:0,y:0),id:'4f105850-367b-11ea-b107-e11d867a543d',panelIndex:'62363a5c-c0b3-4f3e-868e-74a7d3dca2a8',type:visualization,version:'7.5.1')),query:(language:kuery,query:''),timeRestore:!t,title:singlebangle,viewMode:view)" height="600" width="800"></iframe>
	</div>
</body>
</html>