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
					<li><a href="listSiteNews.do">站点通知</a></li>
					<div class="divider"></div>
					<li class="active"><a href="enterSMS.do">短信管理</a></li>
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
							<h5>&nbsp;&nbsp;&nbsp;&nbsp;短信通道管理</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="workarea">
			<div class="border" style="width: 777px;">
				<div class="row">
					<div class="span9">
						<div class="control-group"
							style="padding-left: 30px; margin-bottom: 10px; margin-top: 10px;">
							<label class="control-label" for="purpose"><strong>短信通道</strong></label>
							<div class="controls">
								<label class="radio inline"> <input type="radio"
									value="Y" name="purpose" ${useEmay?"checked":""}>
									亿美&nbsp;&nbsp;
								</label> <label class="radio inline"> <input type="radio"
									value="N" name="purpose" ${!useEmay?"checked":""}>
									区政府&nbsp;&nbsp;
								</label>
							</div>
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
					<div class="span9">
						<div class="control-group"
							style="padding-left: 30px; margin-bottom: 10px; margin-top: 10px;">
							<label class="control-label" for="purpose"><strong>亿美余额</strong></label>
							<div class="controls">
								<label class="radio inline"> 剩余短信条数： <font color="red">${balance}</font>
									条
								</label>
							</div>
						</div>
					</div>
				</div>
				<hr />
				<div class="row">
					<div class="span9">
						<div class="control-group"
							style="padding-left: 30px; margin-bottom: 10px; margin-top: 10px;">
							<label class="control-label" for="purpose"><strong>测试短信</strong></label>
							<table class="table table-striped table-bordered table-hover"
								style="margin-left: 10px;">
								<tbody>
									<tr>
										<td style="width: 20px"></td>
										<td style="width: 70px"><b>请编辑测试短信内容,
												如需要多个接收人，请用空格分隔手机号码</b></td>
									</tr>
									<tr>
										<td style="width: 20px"><b>接收手机号码（不超过10个）</b></td>
										<td style="width: 70px"><input id="mobile"
											style="width: 90%;" maxlength="150" /></td>
									</tr>
									<tr>
										<td style="width: 20px"><b>短信正文(不超过200字)</b></td>
										<td style="width: 70px"><textarea id="content"
												style="width: 90%;" rows="6" cols="100" maxlength="200"> </textarea></td>
									</tr>

									<tr>
										<td style="width: 20px"></td>
										<td style="width: 70px"><a id="smsSendBtn" class="btn">发送</a></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
<script>
	//alert('${encodedName}');

	$("#smsSendBtn").click(function() {
		if ($("#content").val() == null || $("#mobile").val() == null) {
			alert("请输入手机号码和内容！");
		} else {
			$("#smsSendBtn").val("发送中...");
			$.ajax({
				type : "post",
				url : "/ChangNing/sendTestSMS.do",
				data : {
					mobile : $("#mobile").val(),
					content : $("#content").val()
				},
				async : false,
				success : function(data) {
					//alert(data);
					var result = jQuery.parseJSON(data);
					if (result.success == '1') {
						alert('短信已发送');
						location.reload();
					} else {
						$("#smsSendBtn").val("发送");
						alert('短信发送失败！');
					}
				}
			});
		}
	});

	$('input[type=radio][name=purpose]').change(function() {
		var purposeVal = $('input[name=purpose]:checked').val();
		var res = confirm("确认要切换短信通道吗？");
		if (res) {
			$.ajax({
				type : "post",
				url : "/ChangNing/switchSMSSender.do",
				data : {
					useEmay : purposeVal
				},
				async : false,
				success : function(data) {
					//alert(data);
					var result = jQuery.parseJSON(data);
					if (result.success == '1') {
						alert('通道已切换');
					} else {
						alert('通道切换失败！');
					}
				}
			});
		}
	});
</script>

<%@ include file="../footer.jspf"%>