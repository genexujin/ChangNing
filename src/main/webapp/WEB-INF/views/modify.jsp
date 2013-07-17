<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<script type="text/javascript">
	$(function() {
		$("#modify_user_name").blur(function() {
			if ($("#modify_user_name").val().length == 0) {
				$("#modify_name_alert").show().html("姓名不能为空！");
			} else {
				$("#modify_name_alert").hide();
			}
		});
		$("#modify_user_cardnum").blur(function() {
			if ($("#modify_user_cardnum").val().length == 0) {
				$("#modify_cardnum_alert").show().html("证件号不能为空！");
			} else {
				$("#modify_cardnum_alert").hide();
			}
		});

		$("#modify_user_pwd").blur(
				function() {
					if ($("#modify_user_pwd").val().match(/([a-zA-Z])/)
							&& $("#modify_user_pwd").val().match(/([0-9])/)
							&& ($("#modify_user_pwd").val().length >= 8)
							&& ($("#modify_user_pwd").val().length <= 16)) {
						$("#modify_pwd_alert").hide();
					} else {
						$("#modify_pwd_alert").show().html(
								"请输入8-16位的密码，并且必须包含数字和字母！");
					}
				});

		$("#modify_user_address").blur(function() {
			if ($("#modify_address_name").val().length == 0) {
				$("#modify_address_alert").show().html("地址不能为空！");
			} else {
				$("#modify_address_alert").hide();
			}
		});
		$("#modify_user_email")
				.blur(
						function() {
							if ($("#modify_user_email").val().length == 0) {
								$("#modify_email_alert").show().html("邮箱不能为空！");
							} else if (!(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
									.test($("#modify_user_email").val())) {
								$("#modify_email_alert").show().html("邮箱格式错误！");
							} else {
								$("#modify_email_alert").hide();
							}
						});
	});
	function checkModifyForm() {
		if ($("#modify_user_name").val().length == 0) {
			$("#modify_name_alert").show().html("姓名不能为空！");
			$("#modify_user_name").focus();
			return false;
		}
		if ($("#modify_user_cardnum").val().length == 0) {
			$("#modify_cardnum_alert").show().html("证件号码不能为空！");
			$("#modify_user_cardnum").focus();
			return false;
		}
		if (!($("#modify_user_pwd").val().match(/([a-zA-Z])/) && ($(
				"#modify_user_pwd").val().match(/([0-9])/)
				&& ($("#modify_user_pwd").val().length >= 8) && ($(
				"#modify_user_pwd").val().length <= 16)))) {
			$("#modify_pwd_alert").show().html("请输入8-16位的密码，并且必须包含数字和字母！");
			$("#modify_user_pwd").focus();
			return false;
		}
		if ($("#modify_user_email").val().length == 0) {
			$("#modify_email_alert").show().html("邮箱不能为空！");
			$("#modify_user_email").focus();
			return false;
		}
		if (!(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)
				.test($("#modify_user_email").val())) {
			$("#modify_email_alert").show().html("邮箱格式错误！");
			$("#modify_user_email").focus();
			return false;
		}
		if ($("#modify_user_address").val().length == 0) {
			$("#modify_address_alert").show().html("地址不能为空！");
			$("#modify_user_address").focus();
			return false;
		} else {
			return true;
		}
	}
</script>

<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上办证</a> <span class="divider">/</span></li>
	<li class="active">个人信息维护</li>
</ul>
<hr />

<div class="row">
	<div class="span12">
		<h2>个人信息维护</h2>
	</div>
</div>
<div>
	<form onsubmit="return checkModifyForm()" id="user_modify_form" name="user_modify_form" method="post" action="/ChangNing/modify.do">
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
							<td colspan="2"><input type="text" class="input" id="modify_user_name" placeholder="${user.name}" value="${user.name}" name="name"></td>
							<td>
							  <div class="controls">
		    		<SELECT id="gender" name="gender">
						<OPTION selected value="MALE">男</OPTION>
						<OPTION  value="FEMALE">女</OPTION>
					</SELECT>
		    	  </div>
							</td>
							<td><div id="modify_name_alert" class="alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td><p class="text-right">证件类型：</p></td>
							<td colspan="3"><label class="radio inline"> <input type="radio" name="credentialType" id="modify_user_cardtype1" value="ID_CARD" checked> 身份证
							</label> <label class="radio inline"> <input type="radio" name="credentialType" id="modify_user_cardtype2" value="ARMY_ID_CARD"> 军官证
							</label><label class="radio inline"> <input type="radio" name="credentialType" id="modify_user_cardtype3" value="PASSPORT"> 护照
							</label> <label class="radio inline"> <input type="radio" name="credentialType" id="modify_user_cardtype4" value="HK_MC_TW_PASS"> 港澳台居民通行证
							</label><label class="radio inline"> <input type="radio" name="credentialType" id="modify_user_cardtype5" value="OTHER"> 其他
							</label></td>
							<td><div id="modify_cardtype_alert" class="alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td><p class="text-right">证件号码：</p></td>
							<td colspan="3"><input type="text" class="input-xlarge" id="modify_user_cardnum" placeholder="cardnumber" name="credentialId"></td>
							<td><div id="modify_cardnum_alert" class="alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td><p class="text-right">手机号：</p></td>
							<td colspan="3"><input type="hidden" name="mobile" id="modify_user_mobile" value="${user.mobile}">${user.mobile}</td>
							<td><div id="modify_mobile_alert" class="alert" style="display: none"></div></td>
						</tr>

						<tr>
							<td><p class="text-right">修改密码：</p></td>
							<td colspan="3"><input type="password" id="modify_user_pwd" class="input-xlarge" placeholder="Password" name="password"></td>
							<td><div class="alert" id="modify_pwd_alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td><p class="text-right">邮箱：</p></td>
							<td colspan="3"><input type="text" class="input-xlarge" id="modify_user_email" placeholder="email" name="email"></td>
							<td><div id="modify_email_alert" class="alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td><p class="text-right">联系地址：</p></td>
							<td colspan="3"><input type="text" class="input-xlarge" id="modify_user_address" placeholder="address" name="address"></td>
							<td><div id="modify_address_alert" class="alert" style="display: none"></div></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<button href="#" id="user_modify_btn" type="submit" class="btn">提交修改</button>
							</td>
							<td colspan="2"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</form>
</div>