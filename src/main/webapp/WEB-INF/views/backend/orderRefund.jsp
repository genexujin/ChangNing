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
          <h2>退款</h2>
        </div>
      </div>

<br>

	<div class="workarea">
<form class="form-horizontal" action="doRefund.do" method="POST">

	<div class="bar-bg">
		<div class="row">
			<div class="span12 navbg2">
				<div class="row">
					<div class="span9">
						<h5>&nbsp;&nbsp;&nbsp;&nbsp;退款</h5>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="border">
		<br />
		<div class="row">
			<div class="span5 offset1">
				<div class="control-group">
					<label class="control-label" style="font-weight:bold;text-align:left;">订单申办号：</label>
					<div class="controls" style="padding-top:5px;font-weight:bold;">${order.readableId}</div>
				</div>
			</div>
			<div class="span5">
				<div class="control-group">
					<label class="control-label" style="font-weight:bold;text-align:left;">订单总金额：</label>
					<div class="controls" style="padding-top:5px;font-weight:bold;color:red">
						<fmt:formatNumber value="${order.paymentTotal}" type="currency"
							pattern="￥#.00" />
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span10 offset1">
				<p>
						<strong>可退款列表：</strong>
					</p>
			</div>
		</div>
		
		<div class="row">
			<div class="span10 offset1">
				<input name="oId" type="hidden" value="${order.id}"></input>
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>序号</th>
							<th>收费项目</th>
							<th>收费说明</th>
							<th>费用</th>
							<th>支付日期</th>
							<th><input type="checkbox" id="all_payment">全选</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${order.payments}" var="payment"
							varStatus="counter">
							<c:choose>
								<c:when test="${payment.status=='PARTIAL_PAID' or payment.status=='FULL_PAID'}">
									<tr>
										<td>${counter.index + 1}</td>
										<td>${payment.title}</td>
										<td>${payment.paymentReason}</td>
										<td><fmt:formatNumber value="${payment.paymentTotal}"
												type="currency" pattern="￥#.00" /></td>
										<td><fmt:formatDate value="${payment.paymentDate}"
												pattern="yyyy-MM-dd" /></td>
										<td><input type="checkbox" value="${payment.id}"
											name="payment_id"></td>
									</tr>
								</c:when>
							</c:choose>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="span10 offset1">
				<p>
						<strong>退款理由：</strong>
					</p>
			</div>
		</div>		
		<div class="row">
			<div class="span8 offset1">
				<textarea rows="5" cols="150" name="refund_reason"
					style="width: 700px;">${order.cancelNote}</textarea>
			</div>
		</div>

		<div class="row">
			<div class="span2 offset2">
				<button id="refund_submit" class="btn btn-primary" type="submit">确认</button>
			</div>
			<div class="span2">
				<a href="orderDetail.do?oId=${order.id}" class="btn btn-success">返回</a>
			</div>
		</div>

		<br />

	</div>

</form>

</div>

<script>
	function prepareRefund() {
		$("#all_payment").change(togglePaymentSelection);

		$("#refund_submit").click(verifyPaymentIds);
	}

	function togglePaymentSelection() {
		var selectAll = $("#all_payment").prop("checked");
		if (selectAll) {
			$("input[name='payment_id']").prop("checked", true);
		} else {
			$("input[name='payment_id']").prop("checked", false);
		}
	}

	function verifyPaymentIds() {
		var selected = false;
		$.each($("input[name='payment_id']"), function(index, object) {
			if ($(object).prop("checked") == true) {
				selected = true;
			}
		});

		if (selected == false) {
			//No payment selected, so return false to event.preventDefault() and event.stopPropogation()
			alert("请至少选择一项进行退款");
			return false;
		}
	}

	$(prepareRefund);
</script>

<%@ include file="../footer.jspf"%>