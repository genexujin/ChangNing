<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<link href="<c:url value="/resources/user-alert.css" />"
	rel="stylesheet">
<script src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript">
	$(function() {
		$("#modify_user_name").blur(
				function() {
					if ($("#modify_user_name").val().length == 0) {
						$("#modify_name_alert").removeClass().addClass(
								"alert alert-error").show().html("姓名不能为空！");
					} else {
						$("#modify_name_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					}
				});

		$("#modify_user_smscode").blur(
				function() {
					if ($("#modify_user_smscode").val().length == 0) {
						$("#modify_smscode_alert").removeClass().addClass(
								"alert alert-error").show().html("请输入短信验证码！");
					} else {
						$("#modify_smscode_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					}
				});
		$("#modify_user_pwd").blur(
				function() {
					if ($("#modify_user_pwd").val().match(/([a-zA-Z])/)
							&& $("#modify_user_pwd").val().match(/([0-9])/)
							&& ($("#modify_user_pwd").val().length >= 8)
							&& ($("#modify_user_pwd").val().length <= 16)) {
						$("#modify_pwd_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					} else {
						$("#modify_pwd_alert").removeClass().addClass(
								"alert alert-error").show().html(
								"请输入8-16位的密码，必须包含数字和字母！");
					}
				});
		$("#modify_user_email")
				.blur(
						function() {
							if (($("#modify_user_email").val().length != 0)
									&& (!(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
											.test($("#modify_user_email").val()))) {
								$("#modify_email_alert").removeClass()
										.addClass("alert alert-error").show()
										.html("邮箱格式错误！");
							} else {
								$("#modify_email_alert")
										.removeClass()
										.addClass("alert alert-success")
										.show()
										.html(
												"<h7 style='font-family:幼圆'>√</h7>");
							}
						});
	});

	function sbm() {

		var count = 300;
		var countdown = setInterval(CountDown, 1000);

		function CountDown() {
			$("#modify_user_smsbtn").attr("disabled", true).removeClass()
					.addClass("btn").html(count + "秒后可以使用");
			if (count == 0) {
				$("#modify_user_smsbtn").removeClass().addClass("btn btn-info")
						.attr("disabled", false).html("获取短信验证码");
				clearInterval(countdown);
			}
			count--;
		}

	}

	function checksmscode() {
		var flag = false;
		$.ajax({
			type : "post",
			url : "/ChangNing/checkSMSCode1.do",
			data : {
				modify_user_smscode : $("#modify_user_smscode").val()
			},
			async : false,
			success : function(data) {
				if (data == 0) {
					$("#modify_smscode_alert").removeClass().addClass(
							"alert alert-error").show().html("手机验证码输入错误！");
					$("#modify_user_smscode").focus();
				} else {
					flag = true;
				}
			}
		});
		return flag;
	}
	function senddata() {
		$.ajax({
			type : 'post',
			url : '/ChangNing/checkMessageProv.do',
			data : {
				mobile : $("#modify_user_mobile").val()
			}
		});

		$("#modify_smscode_alert").removeClass().addClass("alert alert-error")
				.show().html("请查看手机收取短信验证码并正确输入！");
		sbm();
	}
	function checkModifyForm() {
		if ($("#modify_user_name").val().length == 0) {
			$("#modify_name_alert").removeClass().addClass("alert alert-error")
					.show().html("姓名不能为空！");
			$("#modify_user_name").focus();
			return false;
		}

		if (($("#modify_user_email").val().length != 0)
				&& (!(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
						.test($("#modify_user_email").val()))) {
			$("#modify_email_alert").removeClass()
					.addClass("alert alert-error").show().html("邮箱格式错误！");
			$("#modify_user_email").focus();
			return false;
		} else {
			return true;
		}
	}
	$(function() {
		$("#user_modify_form").ajaxForm(
				function() {
					$("#modify_submit_alert").removeClass().addClass(
							"alert alert-success").show().html("修改成功！");
				});
	});
	function checkModifyPwdForm() {
		if (!($("#modify_user_pwd").val().match(/([a-zA-Z])/) && ($(
				"#modify_user_pwd").val().match(/([0-9])/)
				&& ($("#modify_user_pwd").val().length >= 8) && ($(
				"#modify_user_pwd").val().length <= 16)))) {
			$("#modify_pwd_alert").removeClass().addClass("alert alert-error")
					.show().html("请输入8-16位的密码，必须包含数字和字母！");
			$("#modify_user_pwd").focus();
			return false;
		}
		if ($("#modify_user_smscode").val().length == 0) {
			$("#modify_smscode_alert").removeClass().addClass(
					"alert alert-error").show().html("请输入短信验证码！");
			$("#modify_user_smscode").focus();
			return false;
		} else {
			return checksmscode();
		}
	}
	function modifyPwd() {
		if (checkModifyPwdForm()) {
			$.ajax({
				type : 'post',
				url : '/ChangNing/modifyPwd.do',
				data : {
					password : $("#modify_user_pwd").val()
				},
				success : function(data) {
					$("#modifyPwd_submit_alert").removeClass().addClass(
							"alert alert-success").show().html(data);
				}
			});

		} else {
			return false;
		}
	}
</script>

<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">个人信息</li>
</ul>
<hr />



<div class="row">

	<div class="span2 well">
		<ul class="nav nav-list">
			<li><h5>我的菜单</h5>
			<li><a href="orderQuery.do">办证订单查询</a></li>
			<li ><a href="reserv_Query.do">预约订单查询</a></li>
			<li class="active"><a href="enterModify.do">个人信息修改</a></li>

		</ul>
	</div>

	<div class="span9" style="margin-left: 40px;">
		<div class="span12">
			<h2>个人信息</h2>
		</div>

		<div>
			<form onsubmit="return checkModifyForm()" id="user_modify_form"
				name="user_modify_form" method="post" action="/ChangNing/modify.do">
				<div class="border">
					<div class="row">
						<div class="span12">
							<table width="98%">
								<tr>
									<th width="15%"></th>
									<th width="15%"></th>
									<th width="10%"></th>
									<th width="15%"></th>
									<th width="35%"></th>
								</tr>
								<tr height="60px">
									<td><p class="text-right">您的姓名：</p></td>
									<td colspan="2"><input type="text" class="input"
										id="modify_user_name" placeholder="姓名" value="${user.name}"
										name="name"></td>
									<td>
										<div class="controls">
											<SELECT id="gender" name="gender">
												<OPTION selected value="MALE"
													<c:if test="${user.gender=='MALE'}">selected="selected"</c:if>>男</OPTION>
												<OPTION value="FEMALE"
													<c:if test="${user.gender=='FEMALE'}">selected="selected"</c:if>>女</OPTION>
											</SELECT>
										</div>
									</td>
									<td><div id="modify_name_alert" class="alert"
											style="display: none">请确认或修改姓名！</div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">证件类型：</p></td>
									<td colspan="3"><label class="radio inline"> <input
											type="radio" name="credentialType" id="modify_user_cardtype1"
											value="ID_CARD"
											<c:if test="${user.credentialType=='ID_CARD'}"> checked="checked" </c:if>>
											身份证
									</label> <label class="radio inline"> <input type="radio"
											name="credentialType" id="modify_user_cardtype2"
											value="ARMY_ID_CARD"
											<c:if test="${user.credentialType=='ARMY_ID_CARD'}">checked="checked" </c:if>>
											军官证
									</label><label class="radio inline"> <input type="radio"
											name="credentialType" id="modify_user_cardtype3"
											value="PASSPORT"
											<c:if test="${user.credentialType=='PASSPORT'}" >checked="checked" </c:if>>
											护照
									</label> <label class="radio inline"> <input type="radio"
											name="credentialType" id="modify_user_cardtype4"
											value="HK_MC_TW_PASS"
											<c:if test="${user.credentialType=='HK_MC_TW_PASS'}"  >checked="checked" </c:if>>港澳台居民通行证
									</label><label class="radio inline"> <input type="radio"
											name="credentialType" id="modify_user_cardtype5"
											value="OTHER"
											<c:if test="${user.credentialType=='OTHER'}"> checked="checked" </c:if>>
											其他
									</label></td>
									<td><div id="modify_cardtype_alert" class="alert"
											style="display: none"></div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">证件号码：</p></td>
									<td colspan="3"><input type="text" class="input-xlarge"
										id="modify_user_cardnum" placeholder="证件号" name="credentialId"
										value="${user.credentialId}"></td>
									<td><div id="modify_cardnum_alert" class="alert"
											style="display: none">请输入或修改证件号码！</div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">手机号：</p></td>
									<td colspan="3"><input type="hidden" name="mobile"
										id="modify_user_mobile" value="${user.mobile}">${user.mobile}</td>
									<td><div id="modify_mobile_alert" class="alert"
											style="display: none"></div></td>
								</tr>


								<tr height="60px">
									<td><p class="text-right">邮箱：</p></td>
									<td colspan="3"><input type="text" class="input-xlarge"
										id="modify_user_email" placeholder="电子邮箱地址" name="email"
										value="${user.email}"></td>
									<td><div id="modify_email_alert" class="alert"
											style="display: none">请输入或修改邮箱！</div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">联系地址：</p></td>
									<td colspan="3"><input type="text" class="input-xlarge"
										id="modify_user_address" placeholder="联系地址" name="address"
										value="${user.address}"></td>
									<td><div id="modify_address_alert" class="alert"
											style="display: none">请输入或修改联系地址！</div></td>
								</tr>
								<tr height="60px">
									<td></td>
									<td colspan="3">
										<button href="#" id="user_modify_btn" type="submit"
											class="btn">提交修改</button>
									</td>
									<td><div id="modify_submit_alert" class="alert"
											style="display: none"></div></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</form>
		</div>





		<div class="row">
			<div class="span12">
				<h2>密码修改</h2>
			</div>
		</div>
		<div>
			<form id="user_modifyPwd_form" name="user_modifyPwd_form">
				<div class="border">
					<div class="row">
						<div class="span12">
							<table width="98%">
								<tr>
									<th width="15%"></th>
									<th width="15%"></th>
									<th width="10%"></th>
									<th width="15%"></th>
									<th width="35%"></th>
								</tr>
								<tr height="60px">
									<td><p class="text-right">手机号：</p></td>
									<td colspan="3"><input type="hidden" name="mobile"
										id="modify_user_mobile" value="${user.mobile}">${user.mobile}</td>
									<td><div id="modify_mobile_alert" class="alert"
											style="display: none"></div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">手机验证码：</p></td>
									<td><input type="text" class="input-small"
										id="modify_user_smscode" name="modify_user_smscode"
										placeholder="短信验证码"></td>
									<td colspan="2">
										<button type="button" class="btn btn-info"
											id="modify_user_smsbtn" onclick="senddata()">获取短信验证码</button>
									</td>
									<td height="1px"><div id="modify_smscode_alert"
											class="alert" style="display: none">请点击按钮查收短消息验证码</div></td>
								</tr>
								<tr height="60px">
									<td><p class="text-right">修改密码：</p></td>
									<td colspan="3"><input type="password"
										id="modify_user_pwd" class="input-xlarge" placeholder="新密码"
										name="password"></td>
									<td><div class="alert" id="modify_pwd_alert"
											style="display: none">如需修改密码请在此输入！</div></td>
								</tr>
								<tr height="60px">
									<td></td>
									<td colspan="3">
										<button href="#" id="user_modifypwd_btn" type="button"
											class="btn" onclick="modifyPwd()">提交修改</button>
									</td>
									<td><div id="modifyPwd_submit_alert" class="alert"
											style="display: none"></div></td>
								</tr>
							</table>
						</div>
					</div>
				</div>

			</form>
		</div>
	</div>
</div>

<%@ include file="footer.jspf"%>