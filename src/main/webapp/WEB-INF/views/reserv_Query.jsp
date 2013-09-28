<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<script src="<c:url value="/datepicker/js/bootstrap-datepicker.js"/>"></script>

<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li class="active">预约查询</li>
</ul>
<br />

<div class="row">
	<div class="span2 well">
		<ul class="nav nav-list">
			<li><h5>我的菜单</h5>
			<li><a href="orderQuery.do">办证订单管理</a></li>
			<li class="active"><a href="reserv_Query.do">预约订单管理</a></li>
			<li><a href="enterModify.do">个人信息修改</a></li>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin}">
					<li><a href="enterWorkdaySetting.do">工作日设定</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>

	<div class="span9" style="margin-left: 40px;">
		<form class="form-horizontal" action="/ChangNing/reserv_Query.do"
			method="POST">
			<div class="row">
				<div class="span5">
					<div class="control-group">
						<label class="control-label" for="readable_id">预约号</label>
						<div class="controls">
							<input name="readable_id" type="text" placeholder="预约号"></input>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="row">
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="startDate">开始日期</label>
							<div class="controls">
								<input id="datepicker1" class="" type="text" 
									name="startDate" placeholder="请点击选择开始日期" readonly />
							</div>
						</div>
					</div>
			</div>
			<div class="row">
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="endDate">结束日期</label>
							<div class="controls">
								<input id="datepicker2" class="" type="text" 
									name="endDate" placeholder="请点击选择结束日期" readonly />
							</div>
						</div>
					</div>
			</div>
			<div class="row">
				<div class="span5">
					<div class="control-group">
						<label class="control-label" for="requestor_name">姓名</label>
						<div class="controls">
							<input  name="requestor_name" type="text" placeholder="预约人姓名"></input>
						</div>
					</div>
				</div>
				<div class="span2">
					<SELECT id="status" name="status">
						<OPTION selected value="">全部</OPTION>
						<OPTION value="SUBMITTED">已创建</OPTION>
						<OPTION value="FINISHED">已完成</OPTION>
						<OPTION value="CANCELLED">已取消</OPTION>
					</SELECT>
				</div>
				<div class="span1">
					<button class="btn btn-block" type="submit">查询</button>
				</div>
			</div>

			<div class="row" style="width:750px;">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>申办号</th>
							<th>时间</th>
							<th>申办人</th>
							<th>申办人手机</th>
							<th>公证项</th>
							<th>处理状态</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${reservations}" var="reservation">
							<tr>
								<td>${reservation.readableId}</td>
								<td><fmt:formatDate value="${reservation.reservationDate}"
										pattern="yyyy-MM-dd" />&nbsp;${reservation.reservationTimeSegment}</td>
								<td>${reservation.requestorName}</td>
								<td>${reservation.requestorMobile}</td>
								<td>${reservation.reservationKey}</td>
								<td>${reservation.reservationStatus.getText()}</td>
								<td><c:choose>
										<c:when
											test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">

											<c:if test="${reservation.reservationStatus eq 'SUBMITTED'}">
												<a onclick="cancle('${reservation.readableId}')"
													role="button"  class="btn btn-primary" data-toggle="modal">取消</a>
												<a onclick="finish('${reservation.readableId}')"
													role="button" class="btn btn-primary" data-toggle="modal">完成</a>
											</c:if>
											<c:if test="${reservation.reservationStatus eq 'FINISHED'}">
												受理人：${reservation.accepter.name}
											</c:if>

										</c:when>
										<c:otherwise>
											<c:if test="${reservation.reservationStatus eq 'SUBMITTED'}">
												<a onclick="cancle('${reservation.readableId}')"
													role="button" class="btn btn-primary" data-toggle="modal">取消</a>
											</c:if>
										</c:otherwise>
									</c:choose></td>
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
							<li><a href="<c:url value="/reserv_Query.do?pn=${left}"/>">«</a></li>
						</c:otherwise>
					</c:choose>
					<c:forEach begin="${loopBegin}" end="${loopEnd}" varStatus="loop">
						<c:choose>
							<c:when test="${(loop.index) == currPage}">
								<li class="active"><a href="#">${loop.index}</a></li>
							</c:when>
							<c:otherwise>
								<li><a
									href="<c:url value="/reserv_Query.do?pn=${loop.index}"/>">${loop.index}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${right > pageCount}">
							<li class="disabled"><a href="#">»</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<c:url value="/reserv_Query.do?pn=${right}"/>">»</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>

		</form>
	</div>
</div>

<div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 id="myModalLabel">您确定要取消预约吗？</h3>
	</div>
	<div class="modal-body">
		<p>确定要取消预约吗？取消后将不可恢复，如有业务需求你需要重新预约！</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="cancle_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">×</button>
		<h3 id="myModalLabel">您确定完成预约吗？</h3>
	</div>
	<div class="modal-body">
		<p>如此次预约已经完成，请点击确定！</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
		<button id="finish_submit" class="btn btn-primary">确定</button>
	</div>
</div>

<script type="text/javascript">
	$("#datepicker1").datepicker();
	$("#datepicker2").datepicker();
	function cancle(readableId) {
		$("#myModal1").modal("show");
		$("#cancle_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/cancleReserv.do",
				data : {
					readableId : readableId
				},
				success : function(data) {
					window.location.reload();
				}

			});
		});

	}

	function finish(readableId) {
		$("#myModal2").modal("show");
		$("#finish_submit").click(function() {
			$.ajax({
				type : "post",
				url : "/ChangNing/finishReserv.do",
				data : {
					readableId : readableId
				},
				success : function(data) {
					window.location.reload();
				}

			});
		});

	}
</script>

<%@ include file="footer.jspf"%>


