<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>
<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">订单受理</li>
</ul>

<hr />

<div class="row">
	<div class="span12">
		<h2>网上办证</h2>
	</div>
</div>

<br>
<form class="form-horizontal" action="doAccept.do" method="POST">

	<div class="bar-bg">
		<div class="row">
			<div class="span12 navbg2">
				<div class="row">
					<div class="span9">
						<h5>&nbsp;&nbsp;&nbsp;&nbsp;订单受理</h5>
					</div>
				</div>
			</div>

		</div>
	</div>

	<div class="border">
		<br />
		<c:choose>
			<c:when test="${successMsg!=null}">
				<div class="row">
					<div class="span5 offset1">
						<div id="workday_select_alert" class="alert alert-success">${successMsg}
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
		<div class="row">
			<div class="span9 offset1">
				<div class="control-group">
					<label class="control-label" for="backendNotaryId">订单申办号：</label>
					<div class="controls">${order.readableId}</div>

				</div>
			</div>
		</div>

		<div class="row">
			<div class="span5 offset1">
				<div class="control-group">
					<label class="control-label" for="backendNotaryId">公证受理号：</label>
					<div class="controls">
						<input name="oId" type="hidden" value="${order.id}"></input> 
						<input name="notaryId" type="text" value="${(empty order.backendNotaryId) ? '(2013)沪长证外字第()号' : order.backendNotaryId}"></input>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="span2 offset2">
				<button class="btn btn-primary" type="submit">确认</button>
			</div>
			<div class="span2">
				<a href="orderDetail.do?oId=${order.id}" class="btn btn-success">返回</a>
			</div>
		</div>

		<br />

	</div>

</form>

<%@ include file="../footer.jspf"%>