<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Test Page</title>
</head>
<body>

	<p>Test page!</p>
	<br />
	<p>The model says ${theKey}</p>
	<br />
	<p>The contact number is: ${testSize}</p>

    <p>The descriptions for all the tests are: </p>
    <ul>    
		<c:forEach var="test" items="${tests}">
	        <li><c:out value="${test.description}"></c:out></li>
		</c:forEach>
	</ul>
	
	<br/>
	<p>After update: </p>
	<c:forEach var="test" items="${tests2}">
        <ul><c:out value="${test.description}"></c:out></ul>
	</c:forEach>
	
	<br/>
	<p>Now delete one: </p>
	<c:forEach var="test" items="${tests3}">
        <ul><c:out value="${test.description}"></c:out></ul>
	</c:forEach>
	
	<br/>
	<p>Now insert one: </p>
	<c:forEach var="test" items="${tests4}">
        <ul><c:out value="${test.description}"></c:out></ul>
	</c:forEach>
	
	<a href="createUser.do">Create User</a>

</body>
</html>