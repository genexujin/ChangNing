<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<link href="<c:url value="/resources/user-alert.css" />" rel="stylesheet">



<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>	
	<li class="active">用户登录</li>
</ul> -->

<div class="row">
	<div class="span12 content_title">
		<h2>审计：用户行为跟踪</h2>
	</div>
</div>

<div class="workarea">
	

		<div class="border">
		
			<div class="row">
				 <div class="span5">
				 
				 <table class="table td-no-border">
				  	<tbody>
				  		<tr>
				  			<td style="width:40px"><b>用户</b></td>
				  			<td style="width:50px">徐晋</td>
				  		</tr>
				  		<tr>
				  			<td style="width:40px"><b>登录时间</b></td>
				  			<td style="width:50px">2013-12-01 11:55:51 AM</td>
				  		</tr>
				  		<tr>
				  			<td style="width:40px"><b>登出时间</b></td>
				  			<td style="width:50px">2013-12-01 11:58:11 AM</td>
				  		</tr>
				  		
				  		<tr>
				  			<td style="width:40px"><b>用户角色</b></td>
				  			<td style="width:50px">公证员</td>
				  		</tr>
				  	
				  	</tbody>
				 </table>
		    	  
				  </div>
				
			</div>
			
			
			
		
			<div class="row">
			
				<table class="table table-striped table-bordered table-hover" style="margin-left:25px;width:760px;">
					<thead>
						<tr>
							<th>操作记录</th>														
						</tr>
					</thead>
					<tbody>
						
							<tr>
								<td>2013-12-01 11:55:51 AM &nbsp;&nbsp; 成功登录系统									
								</td>															
							</tr>
							<tr>
								<td>2013-12-01 11:55:55 AM &nbsp;&nbsp; 进入订单查询页面								
								</td>															
							</tr>
							<tr>
								<td>2013-12-01 11:56:12 AM &nbsp;&nbsp; 打开订单号：UAX00000010									
								</td>															
							</tr>
							<tr>
								<td>2013-12-01 11:57:23 AM &nbsp;&nbsp; 确认受理订单号：UAX00000010									
								</td>															
							</tr>
							
							<tr>
								<td>2013-12-01 11:58:11 AM &nbsp;&nbsp; 登出系统									
								</td>															
							</tr>
						
					</tbody>
				</table>
			</div>
		</div>	  
</div>


<%@ include file="footer.jspf"%>