<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<link href="<c:url value="/resources/user-alert.css" />" rel="stylesheet">

<script type="text/javascript">
	var data1 = null;
	function changeImg() {
		var imgSrc = $("#imgObj");
		var src = imgSrc.attr("src");
		imgSrc.attr("src", chgUrl(src));
		return false;
	}
	// 时间戳
	// 为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
	function chgUrl(url) {
		var timestamp = (new Date()).valueOf();
		urlurl = url.substring(0, 17);
		if ((url.indexOf("&") >= 0)) {
			urlurl = url + "×tamp=" + timestamp;
		} else {
			urlurl = url + "?timestamp=" + timestamp;
		}
		return urlurl;
	}

	function isRightCode() {
		var code = $("#veryCode").val();
		code = "c=" + code;
		$.ajax({
			type : "POST",
			url : "resultServlet",
			data : code,
			success : callback
		});
	}

	function callback(data) {
		data1 = data;
	}

	var tid;
	var bClicked = false;
	function sbm() {
		if (bClicked) {
			return false;
		}
		bClicked = true;
		$("#forget_user_smsbtn").attr("disabled", true).removeClass().addClass(
				"btn");

		tid = setTimeout("doit()", 300000);
		//document.forms[0].submit();
	}

	function doit() {
		if (tid != null) {
			clearTimeout(tid);
			tid = null;
		}
		$("#forget_user_smsbtn").removeClass().addClass("btn btn-info").attr(
				"disabled", false);
		bClicked = false;
	}

	function senddata() {
		if (checkmobilein()) {
			$.ajax({
				type : 'post',
				url : '/ChangNing/checkMessageProv.do',
				data : {
					mobile : $("#forget_user_mobile").val()
				}
			});

			$("#forget_smscode_alert").removeClass().addClass(
					"alert alert-error").show().html("请查看手机收取短信验证码并正确输入！");
		}
		sbm();
	}

	function checkmobilein() {
		if ($("#forget_user_mobile").val().length == 0) {
			$("#forget_mobile_alert").removeClass().addClass(
					"alert alert-error").show().html("手机号码不能为空！");
			$("#forget_user_mobile").focus();
			return false;
		} else {
			return true;
		}
	}

	function checksmscode() {
		var flag = false;
		$.ajax({
			type : "post",
			url : "/ChangNing/checkSMSCode2.do",
			data : {
				forget_user_smscode : $("#forget_user_smscode").val()
			},
			async : false,
			success : function(data) {
				if (data == 0) {
					$("#forget_smscode_alert").removeClass().addClass(
							"alert alert-error").show().html("手机验证码输入错误！");
					$("#forget_user_smscode").focus();
				} else {
					flag = true;
				}
			}
		});
		return flag;
	}

	$(function() {
		$("#forget_user_mobile").blur(
				function checkmobile() {
					if (!$("#forget_user_mobile").val().match(
							/^1(3|4|5|8)[0-9]{9}$/)) {
						$("#forget_mobile_alert").removeClass().addClass(
								"alert alert-error").show().html(
								"手机号码格式不正确！请重新输入！");
						$("#forget_user_mobile").focus();
					} else {
						$("#forget_mobile_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					}
				});

		$("#forget_user_smscode").blur(
				function() {
					if ($("#forget_user_smscode").val().length == 0) {
						$("#forget_smscode_alert").removeClass().addClass(
								"alert alert-error").show().html("请输入短信验证码！");
					} else {
						$("#forget_smscode_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					}
				});

		$("#forget_user_pwd").blur(
				function checkpwd() {
					if ($("#forget_user_pwd").val().match(/([a-zA-Z])/)
							&& $("#forget_user_pwd").val().match(/([0-9])/)
							&& ($("#forget_user_pwd").val().length >= 8)
							&& ($("#forget_user_pwd").val().length <= 16)) {
						$("#forget_pwd_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					} else {
						$("#forget_pwd_alert").removeClass().addClass(
								"alert alert-error").show().html(
								"请输入8-16位的密码，必须包含数字和字母！");
					}
				});
		$("#forget_user_pwd1").blur(
				function checkpwd1() {
					if ($("#forget_user_pwd1").val() == 0) {
						$("#forget_pwd1_alert").removeClass().addClass(
								"alert alert-error").show().html("重复密码不能为空！");
					} else

					if ($("#forget_user_pwd1").val() != ($("#forget_user_pwd")
							.val())) {
						$("#forget_pwd1_alert").removeClass().addClass(
								"alert alert-error").show().html("两次密码须一致！");

					} else {
						$("#forget_pwd1_alert").removeClass().addClass(
								"alert alert-success").show().html(
								"<h7 style='font-family:幼圆'>√</h7>");
					}
				});
		$("#veryCode").blur(function() {
			isRightCode();
		});

		$("#veryCode").blur(
				function() {
					if ($("#veryCode").val().length == 0) {
						$("#info").removeClass().addClass("alert alert-error")
								.show().html("请输入图片中的结果！");
					}
				});
	});

	function checkForgetForm() {
		if ($("#forget_user_mobile").val().length == 0) {
			$("#forget_mobile_alert").removeClass().addClass(
					"alert alert-error").show().html("手机号码不能为空！");
			$("#forget_user_mobile").focus();
			return false;
		}
		if ($("#forget_user_smscode").val().length == 0) {
			$("#forget_smscode_alert").removeClass().addClass(
					"alert alert-error").show().html("请输入短信验证码！");
			$("#forget_user_smscode").focus();
			return false;
		}
		if (!($("#forget_user_pwd").val().match(/([a-zA-Z])/) && ($(
				"#forget_user_pwd").val().match(/([0-9])/)
				&& ($("#forget_user_pwd").val().length >= 8) && ($(
				"#forget_user_pwd").val().length <= 16)))) {
			$("#forget_pwd_alert").removeClass().addClass("alert alert-error")
					.show().html("请输入8-16位的密码，必须包含数字和字母！");
			$("#forget_user_pwd").focus();
			return false;
		}
		if ($("#forget_user_pwd1").val() == 0) {
			$("#forget_pwd1_alert").removeClass().addClass("alert alert-error")
					.show().html("请重复输入密码！");
			$("#forget_user_pwd1").focus();
			return false;
		}
		if ($("#forget_user_pwd1").val() != ($("#forget_user_pwd").val())) {
			$("#forget_pwd1_alert").removeClass().addClass("alert alert-error")
					.show().html("两次密码不一致！");
			$("#forget_user_pwd1").focus();
			return false;
		}
		if ($("#veryCode").val() == 0) {
			$("#info").removeClass().addClass("alert alert-error").show().html(
					"请输入图片中的结果！");
			$("#veryCode").focus();
			return false;
		}
		if (data1 == 1) {
			$("#info").removeClass().addClass("alert alert-error").show().html(
					"验证码错误！");
			$("#veryCode").focus();
			return false;
		} else {
			if (checkmobilein()) {
				if (checksmscode() == true) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		}
	}
</script>
<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">找回密码</li>
</ul>
<hr />

<div class="row">
	<div class="span12">
		<h2>找回密码</h2>
	</div>
</div>
<div>
	<form onsubmit="return checkForgetForm()" id="forget_user_form" action="/ChangNing/forget.do" method="POST">
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

						<tr>
							<td><p class="text-right">您注册时的手机号：</p></td>
							<td colspan="3"><input type="text" class="input-xlarge" id="forget_user_mobile" placeholder="mobile" name="mobile"></td>
							<td><div id="forget_mobile_alert" class="alert" style="display: none">请输入手机号码！</div></td>
						</tr>
						<tr>
							<td><p class="text-right">手机验证码：</p></td>
							<td><input type="text" class="input-small" id="forget_user_smscode" name="forget_user_smscode" placeholder="smscode"></td>
							<td colspan="2">
								<button type="button" class="btn btn-info" id=forget_user_smsbtn onclick="senddata()">获取短信验证码</button>
							</td>
							<td><div id="forget_smscode_alert" class="alert" style="display: none">请点击按钮查收短消息验证码</div></td>
						</tr>
						<tr>
							<td><p class="text-right">密码：</p></td>
							<td colspan="3"><input type="password" id="forget_user_pwd" class="input-xlarge" placeholder="Password" name="password"></td>
							<td><div class="alert" id="forget_pwd_alert" style="display: none">请输入密码！</div></td>
						</tr>
						<tr>
							<td><p class="text-right">重复密码：</p></td>
							<td colspan="3"><input type="password" id="forget_user_pwd1" class="input-xlarge" placeholder="Password"></td>
							<td><div class="alert" id="forget_pwd1_alert" style="display: none">请重复输入密码！</div></td>
						</tr>
						<tr>
							<td><p class="text-right">请输入答案：</p></td>

							<td><input type="text" class="input-small" id="veryCode" placeholder="checkcode"></td>
							<td><img id="imgObj" alt="" src="verifyCodeServlet" /></td>
							<td><a href="javascript:void(0)" onclick="changeImg()">看不清？换一个</a></td>
							<td><div class="alert" id="info" style="display: none">请输入图片中的结果！</div></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<button href="#" id="user_forget_btn" type="submit" class="btn btn-large btn-block ">提交信息</button>
							</td>
							<td colspan="2"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
</div>
