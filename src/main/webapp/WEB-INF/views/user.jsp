<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Test Page</title>
</head>
<body>

	<p>User created!</p>
	<br />
	<p>The user info is:</p>
	<br />
	<p>&nbsp;&nbsp;The id: ${user.id}</p>
	<p>&nbsp;&nbsp;The name: ${user.name}</p>
	<p>&nbsp;&nbsp;The birth date: ${user.birthDate}</p>
	<p>&nbsp;&nbsp;The mobile: ${user.mobile}</p>
	<p>&nbsp;&nbsp;The email: ${user.email}</p>
	<p>&nbsp;&nbsp;The credential type: ${user.credentialType}</p>
	<p>&nbsp;&nbsp;The user's orders: </p>
	<ul>  
		<c:forEach var="order" items="${user.orders}">
	        <li>Order id: <c:out value="${order.id}"></c:out></li>
		</c:forEach>
	</ul>
		
</body>
</html>