<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>
<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">退款</li>
</ul> -->

<div class="row">
	<div class="span12 content_title">
		<h2>个人中心</h2>
	</div>
</div>

<div class="row">
	<div class="span2 well" style="margin-left: 22px; width: 154px;">
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
					<li><a href="enterWorkdaySetting.do">工作日设定</a></li>
					<div class="divider"></div>
					<li class="active"><a href="listSiteNews.do">站点通知</a></li>
					<div class="divider"></div>
					<li><a href="enterSMS.do">短信管理</a></li>
					<div class="divider"></div>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when
					test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
					<li><a href="enterUserQuery.do">用户管理</a></li>
				</c:when>
			</c:choose>

		</ul>
	</div>


	<div class="span9" style="margin-left: 1px; width: 770px;">
		<div class="bar-bg" style="margin-left: 1px; width: 778px;">
			<div class="row">
				<div class="span9 navbg2">
					<div class="row">
						<div class="span9">
							<h5>&nbsp;&nbsp;&nbsp;&nbsp;站点通知</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="workarea">
			<div class="border" style="width: 777px;">
				<form class="form-horizontal" action="updateSiteNews.do"
					method="POST">
					<br />
					<div class="row">
						<c:choose>
							<c:when test="${success=='Y'}">
								<div class="alert alert-success"
									style="width: 200px; margin: 0 0 20px 100px;">保存成功</div>
							</c:when>
						</c:choose>
						<input type="hidden" name="id" value="${id}" />
						<div class="span8 offset1">
							<textarea rows="5" cols="150" name="content"
								style="width: 500px;" placeholder="站点通知" maxLength="200">${content}</textarea>
						</div>
					</div>
					<br />
					<div class="row">
						<div class="span2 offset4" style="padding: 0 0 10px 0">
							<button class="btn btn-block btn-info" type="submit">保存站点通知</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>


<%@ include file="../footer.jspf"%>