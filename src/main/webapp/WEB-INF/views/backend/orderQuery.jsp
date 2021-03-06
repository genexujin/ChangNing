<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>
<script src="<c:url value="/datepicker/js/bootstrap-datepicker.js"/>"></script>

<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li class="active">订单查询</li>
</ul>
 -->
<div class="row">
	<div class="span12 content_title">
		<h2>个人中心</h2>
	</div>
</div>
<div class="row">
	<div class="span2 well" style="margin-left: 22px; width: 154px;">
		<ul class="nav nav-list">
			<li><h5>我的菜单</h5>
			<li class="active"><a href="orderQuery.do">办证订单管理</a></li>
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
							<h5>&nbsp;&nbsp;&nbsp;&nbsp;订单管理</h5>
						</div>
					</div>
				</div>
			</div>
		</div>


		<div class="workarea">
			<div class="border" style="width: 777px;">
				<form class="form-horizontal" action="orderQuery.do" method="POST">
					<br>
					<div class="row">
						<p style="padding-left: 29px; padding-bottom: 5px; color: blue;">
							<strong>请输入查询条件：</strong>
						</p>
					</div>
					<div class="row">
						<div class="span3">
							<div class="control-group">
								<label class="control-label" for="rId">申办号</label>
								<div class="controls">
									<input class="thin" id="rId" name="rId" type="text"
										placeholder="申办号" value="${sessionScope['order_readable_id']}"></input>
								</div>
							</div>
						</div>
						<div class="span3">
							<div class="control-group">
								<label class="control-label" for="reqName">姓名</label>
								<div class="controls">
									<input class="thin" id="reqName" name="reqName" type="text"
										placeholder="申办人姓名" value="${sessionScope['order_req_name']}"></input>
								</div>
							</div>
						</div>
						<div class="span2">
							<div class="control-group">
								<label class="control-label" for="status">状态</label>
								<div class="controls">
									<SELECT id="status" name="status">
										<OPTION value="NULL"
											<c:if test="${sessionScope['order_status'] eq 'NULL'}">selected</c:if>>全部</OPTION>
										<OPTION value="SUBMITTED"
											<c:if test="${sessionScope['order_status'] eq 'SUBMITTED'}">selected</c:if>>已创建</OPTION>
										<OPTION value="PAYING"
											<c:if test="${sessionScope['order_status'] eq 'PAYING'}">selected</c:if>>付款中</OPTION>
										<OPTION value="PAID"
											<c:if test="${sessionScope['order_status'] eq 'PAID'}">selected</c:if>>已付款</OPTION>
										<OPTION value="ACCEPTED"
											<c:if test="${sessionScope['order_status'] eq 'ACCEPTED'}">selected</c:if>>已受理</OPTION>
										<OPTION value="FINISHED"
											<c:if test="${sessionScope['order_status'] eq 'FINISHED'}">selected</c:if>>已完成</OPTION>
										<OPTION value="CANCEL_REQUESTED"
											<c:if test="${sessionScope['order_status'] eq 'CANCEL_REQUESTED'}">selected</c:if>>已申请撤销</OPTION>
										<OPTION value="EXTRADOC_REQUESTED"
											<c:if test="${sessionScope['order_status'] eq 'EXTRADOC_REQUESTED'}">selected</c:if>>要求补充材料</OPTION>
										<OPTION value="EXTRADOC_ADDED"
											<c:if test="${sessionScope['order_status'] eq 'EXTRADOC_ADDED'}">selected</c:if>>已补充材料</OPTION>
										<OPTION value="ADD_CHARGE"
											<c:if test="${sessionScope['order_status'] eq 'ADD_CHARGE'}">selected</c:if>>要求附加费用</OPTION>
										<OPTION value="CANCELLED"
											<c:if test="${sessionScope['order_status'] eq 'CANCELLED'}">selected</c:if>>已撤销</OPTION>
									</SELECT>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="span3">
							<div class="control-group">
								<label class="control-label thin2" for="startDate">开始日期</label>
								<div class="controls">
									<input class="thin" id="startDate" type="text" name="startDate"
										placeholder="请点击选择" readonly
										value="<fmt:formatDate pattern="MM/dd/yyyy" value="${sessionScope['order_start_date']}" type="date"/>" />
								</div>
							</div>
						</div>
						<div class="span3">
							<div class="control-group">
								<label class="control-label" for="endDate">结束日期</label>
								<div class="controls thin2">
									<input class="thin" id="endDate" type="text" name="endDate"
										placeholder="请点击选择" readonly
										value="<fmt:formatDate pattern="MM/dd/yyyy" value="${sessionScope['order_end_date']}" type="date"/>" />
								</div>
							</div>
						</div>
						<div class="span3">
							<div class="control-group">
								<label class="control-label" for="reqMobile">手机号</label>
								<div class="controls thin2">
									<input class="thin" id="reqMobile" type="text" name="reqMobile"
										placeholder="手机号" value="${sessionScope['order_req_mobile']}" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="span5 offset2">
							<button class="btn btn-primary" type="submit">查询</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button id="reset_query" class="btn btn-success">重置</button>
						</div>
					</div>
					<br>
					<div class="row">
						<p style="padding-left: 29px; padding-bottom: 5px; color: blue;">
							<strong>查询结果：</strong>
						</p>
					</div>


					<div class="row">
						<table class="table table-striped table-bordered table-hover"
							style="margin-left: 25px; width: 760px;">
							<thead>
								<tr>
									<th>申办号</th>
									<th>公证号</th>
									<th>时间</th>
									<th>申办人</th>
									<th>总费用</th>
									<th>已支付</th>
									<th>状态</th>
									<c:if test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
									<th>备注</th>
									</c:if>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${orders}" var="order">
									<tr>
										<td><a
											href="<c:url value="/orderDetail.do?oId=${order.id}"/>">${order.readableId}</a></td>
										<td><c:out value="${order.backendNotaryId}"></c:out></td>
										<td><fmt:formatDate value="${order.orderDate}"
												pattern="yyyy-MM-dd" /></td>
										<td><c:out value="${order.requestorName}"></c:out></td>
										<td><fmt:formatNumber value="${order.paymentTotal}"
												type="currency" pattern="￥#0.00" /></td>
										<td><fmt:formatNumber value="${order.paymentPaid}"
												type="currency" pattern="￥#0.00" /></td>
										<td><c:out value="${order.orderStatus.text}"></c:out></td>
										<c:if test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
										<td><c:if test="${not empty order.notes}">
												<img src="resources/info.png"
													style="cursor: pointer; display: inline; padding-left: 10px"
													onclick="showNotes(${order.id})"></img>
											</c:if></td>
										</c:if>
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
									<li><a href="<c:url value="/orderQuery.do?pn=${left}"/>">«</a></li>
								</c:otherwise>
							</c:choose>
							<c:forEach begin="${loopBegin}" end="${loopEnd}" varStatus="loop">
								<c:choose>
									<c:when test="${(loop.index) == currPage}">
										<li class="active"><a href="#">${loop.index}</a></li>
									</c:when>
									<c:otherwise>
										<li><a
											href="<c:url value="/orderQuery.do?pn=${loop.index}"/>">${loop.index}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:choose>
								<c:when test="${right > pageCount}">
									<li class="disabled"><a href="#">»</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="<c:url value="/orderQuery.do?pn=${right}"/>">»</a></li>
								</c:otherwise>
							</c:choose>
						</ul>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>
	<div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"
		style="width: 840px;">
		<div class="modal-header" style="height: 10px;">
			<p id="myModalLabel">订单备注</p>
		</div>
		<div class="modal-body">
			<iframe id="noteframe" width="810" height="250"
				frameborder="0"></iframe>
		</div>
		<div class="modal-footer" style="height: 20px;">
			<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		</div>
	</div>

	<script>
$("#startDate").datepicker({language: 'cn'});
$("#endDate").datepicker({language: 'cn'});

$("#reset_query").click(resetQueryParameters);

function resetQueryParameters() {
	$("#rId").val("");
	$("#reqName").val("");
	$("#startDate").val("");
	$("#endDate").val("");
	$("#status").val("NULL");
	$("#reqMobile").val("");
	
	return false;
}

function showNotes(orderId) {
	var frameLink = "getOrderNotes.do?oId=" + orderId;
	$("#noteframe").attr("src", frameLink);
	$("#myModal1").modal("show");
}

</script>

	<%@ include file="../footer.jspf"%>
