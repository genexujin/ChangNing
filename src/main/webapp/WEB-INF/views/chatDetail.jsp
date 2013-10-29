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
		<h2>聊天纪录详情</h2>
	</div>
</div>

<div class="workarea">
	

		<div class="border">
		   <div class="row" style="padding-left:25px;">
		   		<a class="btn" onclick="history.back(-1)">返回</a>
		   </div>
			<div class="row">
				 <div class="span5">
				 
				 <table class="table td-no-border">
				  	<tbody>
				  		<tr>
				  			<td style="width:40px"><b>客户</b></td>
				  			<td style="width:50px">${thread.userName}</td>
				  		</tr>
				  		<tr>
				  			<td style="width:40px"><b>接待人</b></td>
				  			<td style="width:50px">${thread.agentName}</td>
				  		</tr>
				  		<tr>
				  			<td style="width:40px"><b>接待开始时间</b></td>
				  			<td style="width:50px"><fmt:formatDate value="${thread.threadStart}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
				  		</tr>
				  		
				  		<tr>
				  			<td style="width:40px"><b>接待结束时间</b></td>
				  			<td style="width:50px"><fmt:formatDate value="${thread.threadEnd}"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
				  		</tr>
				  	
				  	</tbody>
				 </table>
		    	  
				  </div>
				
			</div>
		
			<div class="row">
			
				<table class="table table-striped table-bordered table-hover" style="margin-left:25px;width:760px;">
					<thead>
						<tr>
							<th>交谈详情</th>														
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${messages}" var="msg">
							<tr>
								<td><fmt:formatDate value="${msg.msgTime}"
										pattern="yyyy-MM-dd HH:mm:ss" /> &nbsp;  
										<font color="${msg.ikind==1?'#b11e23':'#4f4f4f'}">${msg.tname}</font>
										:&nbsp; ${msg.content}										
								</td>
															
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>	  
</div>

<%@ include file="footer.jspf"%>