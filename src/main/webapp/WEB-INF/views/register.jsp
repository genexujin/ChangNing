<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
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
	
	function sendData() {
		$.ajax({
			type : 'post',
			url : '/ChangNing/checkMessageProv.do',
			data : {mobile:$("#reg_user_mobile").val()}
		});
	}
	
	
	$(function() {
		$("#reg_user_name").blur(function() {
			if ($("#reg_user_name").val().length == 0) {
				$("#reg_name_alert").show().html("姓名不能为空！");
			} else {
				$("#reg_name_alert").hide();
			}
		});
		$("#reg_user_mobile").blur(
				function() {
					if ($("#reg_user_mobile").val().length == 0) {
						$("#reg_mobile_alert").show().html("手机号码不能为空！");
					} else if (!$("#reg_user_mobile").val().match(
							/^1(3|4|5|8)[0-9]{9}$/)) {
						$("#reg_mobile_alert").show().html("手机号码格式不正确！请重新输入！");
						$("#reg_user_mobile").focus();
					} else {
						$("#reg_mobile_alert").hide();
					}
				});

		$("#reg_user_smscode").blur(function() {
			if ($("#reg_user_smscode").val().length == 0) {
				$("#reg_smscode_alert").show().html("请输入短信验证码！");
			} else {
				$("#reg_smscode_alert").hide();
			}
		});

		$("#reg_user_smsbtn").click(
				function() {
					$("#reg_user_smsbtn").attr("disabled", true).addClass(
							"btn btn-success");
					$("#reg_smscode_alert").show().html("请查看手机收取短信验证码！");
				});

		$("#reg_user_pwd").blur(
				function() {
					if ($("#reg_user_pwd").val().match(/([a-zA-Z])/)
							&& $("#reg_user_pwd").val().match(/([0-9])/)
							&& ($("#reg_user_pwd").val().length >= 8)
							&& ($("#reg_user_pwd").val().length <= 16)) {
						$("#reg_pwd_alert").hide();
					} else {
						$("#reg_pwd_alert").show().html(
								"请输入8-16位的密码，必须包含数字和字母！");
					}
				});

		$("#reg_user_pwd1").blur(function() {
			if ($("#reg_user_pwd1").val() == ($("#reg_user_pwd").val())) {
				$("#reg_pwd1_alert").hide();
			} else {

				$("#reg_pwd1_alert").show().html("两次密码须一致！");
			}
		});

		$("#veryCode").blur(function() {
			isRightCode();
		});

		$("#veryCode").blur(function() {
			if ($("#veryCode").val().length == 0) {
				$("#info").show().html("请输入图片中的结果！");
			}
		});
	});

	function checkRegForm() {
		if ($("#reg_user_name").val().length == 0) {
			$("#reg_name_alert").show().html("姓名不能为空！");
			$("#reg_user_name").focus();
			return false;
		}
		if ($("#reg_user_mobile").val().length == 0) {
			$("#reg_mobile_alert").show().html("手机号码不能为空！");
			$("#reg_user_mobile").focus();
			return false;
		}
		if (!$("#reg_user_mobile").val().match(/^1(3|4|5|8)[0-9]{9}$/)) {
			$("#reg_mobile_alert").show().html("手机号码格式不正确！请重新输入！");
			$("#reg_user_mobile").focus();
			return false;
		}
		if ($("#reg_user_smscode").val().length == 0) {
			$("#reg_smscode_alert").show().html("请输入短信验证码！");
			$("#reg_user_smscode").focus();
			return false;
		}
		if (!($("#reg_user_pwd").val().match(/([a-zA-Z])/) && ($(
				"#reg_user_pwd").val().match(/([0-9])/)
				&& ($("#reg_user_pwd").val().length >= 8) && ($("#reg_user_pwd")
				.val().length <= 16)))) {
			$("#reg_pwd_alert").show().html("请输入8-16位的密码，必须包含数字和字母！");
			$("#reg_user_pwd").focus();
			return false;
		}
		if ($("#reg_user_pwd1").val() == 0) {
			$("#reg_pwd1_alert").show().html("请重复输入密码！");
			$("#reg_user_pwd1").focus();
			return false;
		}
		if ($("#reg_user_pwd1").val() != ($("#reg_user_pwd").val())) {
			$("#reg_pwd1_alert").show().html("两次密码不一致！");
			$("#reg_user_pwd1").focus();
			return false;
		}
		if ($("#veryCode").val() == 0) {
			$("#info").show().html("请输入图片中的结果！");
			$("#veryCode").focus();
			return false;
		}
		if (data1==1) {
			$("#info").show().html("验证码错误！");
			$("#veryCode").focus();
			return false;
		}
		alert($("#reg_user_checkbox").attr("checked"));
		if(!$("#reg_user_checkbox").attr("checked")==true){
			$("#reg_checkbox_alert").show().html("阅读公证处协议并同意后才可注册！");
			return false;
		}
		else {
			return true;
		}

	};
</script>
<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">用户注册</li>
</ul>
<hr />

<div class="row">
	<div class="span12">
		<h2>用户注册</h2>
	</div>
</div>



<form id="reg_user_form" name="reg_user_form" method="post" onsubmit="return checkRegForm()" action="/ChangNing/register.do">
	<div class="border">
		<div class="row">
			<div class="span12">
				<table>
					<tr>
						<th width="15%"></th>
						<th width="15%"></th>
						<th width="10%"></th>
						<th width="15%"></th>
						<th width="35%"></th>
					</tr>
					<tr>
						<td><p class="text-right">您的姓名：</p></td>
						<td colspan="3"><input type="text" class="input-xlarge" id="reg_user_name" placeholder="name" name="name"></td>
						<td><div id="reg_name_alert" class="alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td><p class="text-right">手机号：</p></td>
						<td colspan="3"><input type="text" class="input-xlarge" id="reg_user_mobile" placeholder="mobile" name="mobile"></td>
						<td><div id="reg_mobile_alert" class="alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td><p class="text-right">手机验证码：</p></td>
						<td><input type="text" class="input-small" id="reg_user_smscode" name ="reg_user_smscode" placeholder="smscode"></td>
						<td colspan="2">
							<button type="button" class="btn-info" id=reg_user_smsbtn onclick="sendData()">获取短信验证码</button>
						</td>
						<td><div id="reg_smscode_alert" class="alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td><p class="text-right">密码：</p></td>
						<td colspan="3"><input type="password" id="reg_user_pwd" class="input-xlarge" placeholder="Password" name="password"></td>
						<td><div class="alert" id="reg_pwd_alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td><p class="text-right">重复密码：</p></td>
						<td colspan="3"><input type="password" id="reg_user_pwd1" class="input-xlarge" placeholder="Password"></td>
						<td><div class="alert" id="reg_pwd1_alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td><p class="text-right">请输入答案：</p></td>
						<td><input type="text" class="input-small" id="veryCode" placeholder="checkcode"></td>
						<td><img id="imgObj" alt="" src="verifyCodeServlet" /></td>
						<td><a href="javascript:void(0)" onclick="changeImg()">看不清？换一个</a></td>
						<td><div class="alert" id="info" style="display: none"></div></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="3"><input type="checkbox" value="checked" id="reg_user_checkbox" checked="checked"> 我接受<a href="#">长宁公证处注册协议</a></td>
						<td><div class="alert" id="reg_checkbox_alert" style="display: none"></div></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2">
							<button href="#" id="user_reg_btn" type="submit" class="btn btn-large btn-block ">用户注册</button>
						</td>
						<td colspan="2"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>

</form>

