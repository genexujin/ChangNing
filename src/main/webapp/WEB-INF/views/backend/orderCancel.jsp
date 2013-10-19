<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>


<hr />

<br>
<div class="workarea">
<form class="form-horizontal" action="doCancel.do" method="POST">

	<div class="bar-bg">
		<div class="row">
			<div class="span12 navbg2">
				<div class="row">
					<div class="span9">
						<h5>&nbsp;&nbsp;&nbsp;&nbsp;订单撤销</h5>
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
					<label class="control-label">订单申办号：</label>
					<div class="controls">${order.readableId}</div>

				</div>
			</div>
			<div class="span9 offset1">
				<div class="control-group">
					<label class="control-label">总金额：</label>
					<div class="controls">
						<fmt:formatNumber value="${order.paymentTotal}" type="currency"
							pattern="￥#.00" />
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="span10 offset1">
				<div class="control-group">
					<label class="control-label" for="backendNotaryId">请输入撤销原因：</label>
					<div class="controls">
						<input name="oId" type="hidden" value="${order.id}"></input>
						<textarea rows="5" cols="150" name="cancel_note">${order.cancelNote}</textarea>
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

</div>

<%@ include file="../footer.jspf"%>