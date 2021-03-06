<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li class="active">用户管理</li>
</ul> -->
 <div class="row">
        <div class="span12 content_title">
          <h2>个人中心</h2>
        </div>
      </div>
<div class="row">
	<div class="span2 well" style="margin-left:22px;width:154px;">
		<ul class="nav nav-list">
			<li><h5>我的菜单</h5>
			<li><a href="orderQuery.do">办证订单管理</a></li>
			<div class="divider"></div>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
					<li><a href="orderRecentActivity.do">办证订单近期活动</a></li>
				</c:when>
			</c:choose>
			<div class="divider"></div>
			<li><a href="reserv_Query.do">预约订单管理</a></li>
			<div class="divider"></div>
			
			<li><a href="enterModify.do">个人信息修改</a></li>
			<div class="divider"></div>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin}">
					<li><a href="enterSlots.do">预约时间段</a></li>
					<div class="divider"></div>
					<li><a href="enterWorkdaySetting.do">工作日设定</a></li>
					<div class="divider"></div>
					<li><a href="listSiteNews.do">站点通知</a></li>
					<div class="divider"></div>
					<li><a href="enterSMS.do">短信管理</a></li>
					<div class="divider"></div>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
					<li  class="active"><a href="enterUserQuery.do">用户管理</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	
	

	<div class="span9" style="margin-left: 1px;">
	<div class="bar-bg"  style="width:777px;">
        <div class="row">
          <div class="span9 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;用户管理</h5>
              </div>             
            </div>
          </div>
        </div>
      </div>
      
      <div class="border" style="width:777px;">
      <br>
      <div class="row">

					<p style="padding-left: 29px; padding-bottom: 5px;color:blue;">
						<strong>请输入查询条件：</strong>
					</p>
				</div>
		<form class="form-horizontal" action="doUserQuery.do" method="POST">
			<div class="row">
				<div class="span3">
					<div class="control-group">
						<label class="control-label" for="rId">电话</label>
						<div class="controls">
							<input style="width:120px;" name="queryMobile" type="text" value="${query_mobile}" ></input>
						</div>
						
					</div>
				</div>
				<div class="span4">
					<div class="control-group">
						<label class="control-label" for="rId">姓名</label>
						<div class="controls">
							<input style="width:120px;" name="queryName" type="text" value="${query_name}"></input>
						</div>
						
					</div>
				</div>
				<div class="span1" style="margin-left:65px;">
					<button class="btn btn-block btn-primary" type="submit">查询</button>
				</div>
			</div>
			<div class="row">

					<p style="padding-left: 29px; padding-bottom: 5px;color:blue;">
						<strong>查询结果：</strong>
					</p>
				</div>

			<div class="row">
				<table class="table table-striped table-bordered table-hover" style="margin-left:25px;width:760px;">
					<thead>
						<tr>
							<th>电话号码</th>
							<th>姓名</th>
							<th>性别</th>
							<th>角色</th>
							<c:choose>
								<c:when
									test="${sessionScope['LOGIN_USER'].admin }">
									<th style="width:35%;">设置用户角色</th>	
								</c:when>
							</c:choose>
							<c:choose>
								<c:when
									test="${sessionScope['LOGIN_USER'].admin }">
									<th style="width:10%;">状态</th>	
								</c:when>
							</c:choose>						
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users}" var="user">
							<tr>
								<td><c:out value="${user.mobile}"></c:out>
								<c:choose>
									<c:when
									test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
										<a href="checkChatHistory.do?mobile=${user.mobile}" target="_blank">客服聊天记录</a>
									</c:when>
								</c:choose>							
								</td>
								<td><c:out value="${user.name}"></c:out></td>
								<td><c:out value="${user.gender.text}"></c:out></td>
								<td><c:out value="${user.userRoleList}"></c:out></td>
								
								<c:choose>
									<c:when
									test="${sessionScope['LOGIN_USER'].admin}">
									<td>
											<c:if test="${!user.normalUser or user.noRole}">
												<a onclick="setNormalUser('${user.mobile}')"
													role="button"  class="btn btn-success" data-toggle="modal">客户</a>												
											</c:if>
											<c:if test="${!user.staff or user.noRole}">
												<a onclick="setStaff('${user.mobile}')"
													role="button"  class="btn btn-success" data-toggle="modal">公证员</a>												
											</c:if>
											<c:if test="${!user.admin or user.noRole}">
												<a onclick="setAdmin('${user.mobile}')"
													role="button"  class="btn btn-success" data-toggle="modal">管理员</a>												
											</c:if>									
									</td>
									</c:when>
								</c:choose>	
								<c:choose>
									<c:when
									test="${sessionScope['LOGIN_USER'].admin}">
									<td>
											<c:if test="${user.status eq 'ALLOW'}">
												<a onclick="setNonAllow('${user.mobile}')"
													role="button"  class="btn btn-danger" data-toggle="modal">封禁</a>												
											</c:if>
											<c:if test="${user.status eq 'NON_ALLOW'}">
												<a onclick="setAllow('${user.mobile}')"
													role="button"  class="btn btn-success" data-toggle="modal">解封</a>												
											</c:if>
									</td>
									</c:when>
								</c:choose>									
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			<div class="pagination pagination-right">
				<ul>
					<c:choose>
						<c:when test="${left < 1}">
							<li class="disabled"><a href="#">«</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<c:url value="/doUserQuery.do?pn=${left}"/>">«</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${loopBegin}" end="${loopEnd}" varStatus="loop">
						<c:choose>
							<c:when test="${(loop.index) == currPage}">
								<li class="active"><a href="#">${loop.index}</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="<c:url value="/doUserQuery.do?pn=${loop.index}"/>">${loop.index}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${right > pageCount}">
							<li class="disabled"><a href="#">»</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<c:url value="/doUserQuery.do?pn=${right}"/>">»</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>

		</form>
		</div>
	</div>
</div>

<div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<p><strong>您确定将该用户的角色设置为公证员吗？</strong></p>
	</div>	
	<div class="modal-footer" style="height:20px;padding:13px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="staff_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<p><strong>您确定将该用户的角色设置为客户吗？</strong></p>
	</div>	
	<div class="modal-footer" style="height:20px;padding:13px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="normal_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<div id="myModal3" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<p><strong>您确定将该用户的角色设置为管理员吗？</strong></p>
	</div>	
	<div class="modal-footer" style="height:20px;padding:13px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="admin_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<div id="myModal4" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<p><strong>您确定将该用户封禁吗？</strong></p>
	</div>	
	<div class="modal-footer" style="height:20px;padding:13px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="non_allow_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<div id="myModal5" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:400px;">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<p><strong>您确定将该用户解封吗？</strong></p>
	</div>	
	<div class="modal-footer" style="height:20px;padding:13px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="allow_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<script type="text/javascript">
	function setNormalUser(mobile) {
		$("#myModal1").modal("show");
		$("#normal_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/setUserAsNormal.do",
				data : {
					mobile : mobile
				},
				success : function(data) {
					
					if(data==1)
						window.location.reload();
				}
	
			});
		});
	
	}
	function setStaff(mobile) {
		$("#myModal2").modal("show");
		$("#staff_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/setUserAsStaff.do",
				data : {
					mobile : mobile
				},
				success : function(data) {
					
					if(data==1)
						window.location.reload();
				}

			});
		});

	}
	
	function setAdmin(mobile) {
		$("#myModal3").modal("show");
		$("#admin_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/setUserAsAdmin.do",
				data : {
					mobile : mobile
				},
				success : function(data) {
					
					if(data==1)
						window.location.reload();
				}

			});
		});

	}
	function setNonAllow(mobile) {
		$("#myModal4").modal("show");
		$("#non_allow_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/setNonAllow.do",
				data : {
					mobile : mobile
				},
				success : function(data) {
					
					if(data==1)
						window.location.reload();
				}
	
			});
		});
	
	}
	function setAllow(mobile) {
		$("#myModal5").modal("show");
		$("#allow_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/setAllow.do",
				data : {
					mobile : mobile
				},
				success : function(data) {
					
					if(data==1)
						window.location.reload();
				}
	
			});
		});
	
	}
</script>


<%@ include file="../footer.jspf"%>


