<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<link href="<c:url value="/resources/user-alert.css" />" rel="stylesheet">


<script type="text/javascript">
	
</script>
<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>	
	<li class="active">用户登录</li>
</ul> -->

<div class="row">
	<div class="span12 content_title">
		<h2>聊天纪录</h2>
	</div>
</div>

<div class="workarea">
	

		<div class="border">
			<div class="row">
				<table class="table table-striped table-bordered table-hover" style="margin-left:25px;width:760px;">
					<thead>
						<tr>
							<th>姓名</th>
							<th>接待人</th>
							<th>开始时间</th>
							<th>结束时间</th>							
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${threads}" var="thread">
							<tr>
								<td><a
									href="<c:url value="/chatDetail.do?threadid=${thread.threadid}"/>">${thread.userName}</a></td>
								<td>${thread.agentName}</td>
								<td><fmt:formatDate value="${thread.threadStart}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><fmt:formatDate value="${thread.threadEnd}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>	  

	
</div>
<%@ include file="footer.jspf"%>