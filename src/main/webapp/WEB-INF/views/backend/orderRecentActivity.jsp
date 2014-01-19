<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

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
					<li class="active"><a href="orderRecentActivity.do">办证订单近期活动</a></li>
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
							<h5>&nbsp;&nbsp;&nbsp;&nbsp;办证订单近期活动</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="workarea">
		  <div class="border" style="width: 777px;">
		    <br>
		    
		    <div class="row">
				<table class="table table-striped table-bordered table-hover"
					style="margin-left: 25px; width: 760px;">
					<thead>
						<tr>
							<th>申办号</th>
							<!-- <th>公证号</th> -->
							<th>操作时间</th>
							<th>操作者</th>
							<!-- <th>总费用</th>
							<th>已支付</th> -->
							<th>操作</th>
							<%-- <c:if test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
							<th>备注</th>
							</c:if> --%>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${oras}" var="ora">
							<tr>
								<td><a
									href="<c:url value="/orderDetail.do?oId=${ora.id}"/>">${ora.readableId}</a></td>
								<td><fmt:formatDate value="${ora.operationDate}" pattern="yyyy-MM-dd" /></td>
								<td><c:out value="${ora.name}"></c:out></td>
								<%-- <td><fmt:formatNumber value="${order.paymentTotal}"
										type="currency" pattern="￥#0.00" /></td>
								<td><fmt:formatNumber value="${order.paymentPaid}"
										type="currency" pattern="￥#0.00" /></td> --%>
								<td><c:out value="${ora.operation}"></c:out></td>
								<%-- <c:if test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
								<td><c:if test="${not empty order.notes}">
										<img src="resources/info.png"
											style="cursor: pointer; display: inline; padding-left: 10px"
											onclick="showNotes(${order.id})"></img>
									</c:if></td>
								</c:if> --%>
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
							<li><a href="<c:url value="/orderRecentActivity.do?pn=${left}"/>">«</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${loopBegin}" end="${loopEnd}" varStatus="loop">
						<c:choose>
							<c:when test="${(loop.index) == currPage}">
								<li class="active"><a href="#">${loop.index}</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="<c:url value="/orderRecentActivity.do?pn=${loop.index}"/>">${loop.index}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${right > pageCount}">
							<li class="disabled"><a href="#">»</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<c:url value="/orderRecentActivity.do?pn=${right}"/>">»</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		  </div>
		</div>
		
	</div>
	
</div>

