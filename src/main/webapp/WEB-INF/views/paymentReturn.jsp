<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="certStep1.do">网上办证</a> <span class="divider">/</span></li>
	<li class="active">支付</li>
</ul>

<hr />

<div class="row">
	<div class="span12">
		<h2>网上办证</h2>
	</div>
</div>

<div class="row">
	<div class="span12">
		<div class="flowstep">
			<ol>
				<li class="pass">选择申办业务</li>
				<li class="pass">输入信息</li>
				<li class="pass">上传资料</li>
				<li class="ago">上门送证</li>
				<li class="step">支付</li>
			</ol>
		</div>
	</div>
</div>

<br>

<div class="border">
	<br />
	<div class="row">
		<div class="span5">
		<strong>
			<c:choose>
				<c:when test="${success}">
					<img src="resources/icon_succ_large.png"
						style="padding-left: 20px; padding-right: 10px;" /> 您已成功付款 ！
				</c:when>
				<c:otherwise>
					<img src="resources/symbol-error.png"
						style="padding-left: 20px; padding-right: 10px;" /> 您的付款不成功 ！
				</c:otherwise>
			</c:choose>
			</strong>
			 人民币
			<font color=red> <fmt:formatNumber value="${totalFee}"
					type="currency" pattern="￥#.00" />
			</font>元。

		</div>

	</div>
	<br />
	<div class="row">
		<div class="span5 offset1">
			订单号： <font color=red>${orderNo}</font>
		</div>

	</div>

	<div class="row">
		<div class="span5 offset1">
			<font color=gray>....................................................................................................................................................................................................................................
			</font>
		</div>
	</div>
	<br />
	<div class="row">
		<div class="span5 offset1">
			<strong>您可以：</strong>
		</div>
	</div>
	<div class="row">
		<div class="span5 offset1">
		<c:choose>
			<c:when test="${oid!=null}">
				<a href="orderDetail.do?oId=${oid}" class="btn btn-primary">查看该订单详情</a>
			</c:when>
			<c:otherwise>
				<a href="#">查看该订单详情</a>
			</c:otherwise>
		</c:choose>
		</div>
	</div>

	<br />
</div>

<%@ include file="footer.jspf"%>