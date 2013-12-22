<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="<c:url value="/bootstrap/css/bootstrap.min.css" />"	rel="stylesheet" />
<link href="<c:url value="/resources/changning.css" />" rel="stylesheet" />

</head>
<body style="background:none">
      	<div class="row">
		  <div class="span10">
		  <c:choose>
        	<c:when test="${not empty message}">
        	  <c:out value="${message}"></c:out>
        	</c:when>
        	<c:otherwise>
              <table class="table table-striped table-bordered table-hover">
	            <thead>
	              <tr>	                
	                <th style="width:60px">备注人</th>
	                <th style="width:150px">时间</th>
	                <th>内容</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach items="${notes}" var="note" >	                
	                  <tr>
	                    <td><c:out value="${note.user.name}"></c:out></td>
	                    <td><font color='blue'><fmt:formatDate value="${note.noteDate}" pattern="yyyy-MM-dd HH:mm:ss"/></font></td>
	                    <td><c:out value="${note.noteContent}"></c:out></td>	                   
	                  </tr>	                
	              </c:forEach>              
	              
	            </tbody>
	          </table>
        	</c:otherwise>
		  </c:choose>
	      </div>	      
	    </div>
</body>
</html>
