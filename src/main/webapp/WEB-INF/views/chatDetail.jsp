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
		<h2>聊天纪录详情</h2>
	</div>
</div>

<div class="workarea">
	

		<div class="border">
		   <div class="row" style="padding-left:25px;">
		   		<a class="btn" onclick="history.back(-1)">返回</a>
		   		<a class="btn" id="emailBtn" style="display:${thread.agentName!=null?'none':'inline'};">邮件回复</a>
		   		<a class="btn" id="callBtn" style="display:${thread.agentName!=null?'none':'inline'};">电话回复</a>
		   </div>
			<div class="row">
				 <div class="span5">
				 
				 <table class="table td-no-border">
				  	<tbody>
				  		<tr>
				  			<td style="width:40px"><b>客户</b></td>
				  			<td style="width:50px">${thread.userName} (${thread.mobile})</td>
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
			
			<div id="emailInputArea" class="row" style="display:none;">
			<div class="span10">
				 <table class="table table-striped table-bordered table-hover" style="margin-left:10px;">
				  	<tbody>
				  		<tr>
				  			<td style="width:20px"></td>
				  			<td style="width:70px"><b>请编辑邮件内容, 邮件将发送至：${toEmail}</b></td>
				  		</tr>
				  		<tr>
				  			<td style="width:20px"><b>邮件主题(不超过100字)</b></td>
				  			<td style="width:70px"><input id="subjectText" style="width:90%;" maxlength="100"/></td>
				  		</tr>
				  		<tr>
				  			<td style="width:20px"><b>邮件正文(不超过500字)</b></td>
				  			<td style="width:70px"><textarea id="bodyText" style="width:90%;"  rows="6" cols="100" maxlength="500"> </textarea></td>
				  		</tr>
				  		
				  		<tr>
				  			<td style="width:20px"></td>
				  			<td style="width:70px"><a id="emailSendBtn" class="btn">发送</a></td>
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

<script>
	//alert('${encodedName}');
	var toEmail = '${toEmail}';
	
	$("#emailBtn").click(function(){
		$("#emailInputArea").toggle();
	}
	);
	
	$("#emailSendBtn").click(function(){
		if ($("#subjectText").val() == null || $("#bodyText").val() == null) {
			alert("请输入邮件主题和内容！");
		} else {
			$("#emailSendBtn").val("发送中...");
			$.ajax({
				type : "post",
				url : "/ChangNing/sendEmail.do",
				data : {
					to : toEmail,
					subject : $("#subjectText").val(),
					body : $("#bodyText").val(),
					threadid:'${thread.threadid}'
				},
				async : false,
				success : function(data) {
					//alert(data);
					var result = jQuery.parseJSON(data);
					if (result.success == '1') {
						$("#emailInputArea").hide();
						alert('邮件已发送');
						location.reload();
					} else {
						$("#emailSendBtn").val("发送");
						alert('邮件发送失败！');
					}

				}
			});
		}
	}
	);
	
	$("#callBtn").click(function(){
		
			$.ajax({
				type : "post",
				url : "/ChangNing/recordCall.do",
				data : {
					threadid:'${thread.threadid}'
				},
				async : false,
				success : function(data) {
					//alert(data);
					var result = jQuery.parseJSON(data);
					if (result.success == '1') {
						$("#emailInputArea").hide();
						alert('已记录电话联系');
						location.reload();
					} else {
						$("#emailSendBtn").val("发送");
						alert('记录电话联系失败！');
					}

				}
			});
		}
	);
			
</script>

<%@ include file="footer.jspf"%>