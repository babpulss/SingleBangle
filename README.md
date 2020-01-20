
<h1> 네비게이션 바를 jsp인클루드 방식으로 포함시키기 </h1>
```html  
<!DOCTYPE html>
<html>
<head>
.
.
.
<link rel="stylesheet" href="/css/nav.css"> // <head>영역에 css를 임포트를 함
</head>
<body>
<jsp:include page="/resources/jsp/nav.jsp"/> // <body> 시작부분에 nav.jsp를 인클루드함
<div id="mainWrapper"> 			    // mainWrapper안에 콘텐츠를 작성
본문 내용 작성 부문
</div>
.
.
.
```  
  
  
<h2>회원 블랙리스트 등록과 신고접수 메서드</h2>

AdminService를 Autowired로 인스턴스 생성 후 아래의 메서드를 호출  
모든 값은 boolean으로 반환

```java
// 블랙리스트 등록 
public boolean blockId(String id, String reason) {
	return blackListService.block(id, reason);
}

// 신고접수
public boolean reporting(String id, String reason, String url) {
	return reportingService.addReporting(id, reason, url);
}
```
<hr>

DB info
- id: recoder
- pw: recoder

Files path info
```java
<mvc:resources mapping="/resources/**" location="/resources/" />
<mvc:resources mapping="/css/**" location="/resources/css"/>
<mvc:resources mapping="/js/**" location="/resources/js"/>
<mvc:resources mapping="/img/**" location="/resources/img/"/>
```

transaction manager info
```java
<bean id="tx" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
	<property name="dataSource" ref="dataSource"/>
</bean>		
```

myBatis mapperLocations info
```
<property name="mapperLocations" value="classpath:/mappers/*mapper.xml"/>
```

