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


