<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="#">网上预约</a> <span class="divider">/</span></li>
	<li class="active">预约申请</li>
</ul>

<hr />

<div class="row">
	<div class="span12">
		<h2>预约申请</h2>
	</div>
</div>

<!-- div class="row">
	    <div class="span12">
		  <div class="flowstep">
			<ol>
				<li class="step">选择申办业务</li>
				<li class="">输入信息</li>
		        <li class="">上传资料</li>
				<li class="">上门送证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div> 

      <br>-->

<form class="form-horizontal" action="certStep2.do" method="POST">

	<div class="bar-bg">
		<div class="row">
			<div class="span12 navbg2">
				<div class="row">
					<div class="span9">
						<h5>&nbsp;&nbsp;&nbsp;&nbsp;在线预约申请信息</h5>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="border">

		<br />
		<div class="row">

			<p style="padding-left: 70px; padding-bottom: 10px;">
				<strong>请留下您的联系方式以方便工作人员与您取得联系。 </strong>
			</p>


		</div>

		<div class="row">
			<div class="span12">
				<div class="row">
					<div class="span5 offset1">
						<div class="control-group">
							<label class="control-label" for="dest">预约办证事项</label>
							<div class="controls">
								<SELECT id="rsvKey" name="rsvKey">
									<OPTION selected value="NULL">请选择</OPTION>
									<OPTION value="房产买卖">房产买卖</OPTION>
									<OPTION value="赠予">赠予</OPTION>
									<OPTION value="抵押">抵押</OPTION>
									<OPTION value="继承">继承</OPTION>
									<OPTION value="证据保全">证据保全</OPTION>
								</SELECT>
							</div>
						</div>
					</div>
					<div id="rsvKey_m" class="span4 hide alert alert-error">必须选择一个预约事项
					</div>
				</div>
				<div class="row">
					<div class="span5 offset1">
						<div class="control-group">
							<label class="control-label" for="username">申请人姓名</label>
							<div class="controls">
								<input id="username" name="username" type="text"
									value="${currUser.name}"></input>
							</div>
						</div>
					</div>
					<div id="username_m" class="span4 hide alert alert-error">姓名不能为空
					</div>
				</div>

				<div class="row">
					<div class="span5 offset1">
						<div class="control-group">
							<label class="control-label" for="mobile">手机号</label>
							<div class="controls">
								<input id="mobile" name="mobile" type="text"
									value="${currUser.mobile}"></input>
							</div>
						</div>
					</div>
					<div id="mobile_m" class="span4 tiny-pt hide alert alert-error">
					</div>
				</div>
				<br>
				<div class="row">

					<p style="padding-left: 70px; padding-bottom: 10px;">
						<strong>请选择预约日期，注：只能选择第二天起7个自然日内的日期。</strong>
					</p>
				</div>
				<div class="row">
					<div class="span8 offset2">
						<div class="control-group">
							<table border="1">
								<tr>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
									<td class="wdheader">2013-09-11 星期三</td>
								</tr>
								<tr>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
									<td class="workday">第1天</td>
								</tr>
							</table>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="span7 offset2">
					<strong>请选择预约时间：</strong>
					</div>
				</div>


				<div class="row">
					<div class="span7 offset4">
						<div class="control-group">
							<table border="1">
								<tr>
									<td class="segmenthd">2013-09-11 星期三</td>
								</tr>
								<tr>
									<td class="segment">08:30 ~ 9:00</td>
								</tr>
								<tr>
									<td class="segment">09:00 ~ 9:30</td>
								</tr>
								<tr>
									<td class="segment">09:30 ~ 10:00</td>
								</tr>
								<tr>
									<td class="segment">10:00 ~ 10:30</td>
								</tr>
								<tr>
									<td class="segment">10:30 ~ 11:00</td>
								</tr>
								<tr>
									<td class="segment">11:00 ~ 11:30</td>
								</tr>
								<tr>
									<td class="segmenthd">午休</td>
								</tr>
								<tr>
									<td class="segment">13:30 ~ 14:00</td>
								</tr>
								<tr>
									<td class="segment">14:00 ~ 14:30</td>
								</tr>
								<tr>
									<td class="segment">14:30 ~ 15:00</td>
								</tr>
								<tr>
									<td class="segment">15:00 ~ 15:30</td>
								</tr>
								<tr>
									<td class="segment">15:30 ~ 16:00</td>
								</tr>
								<tr>
									<td class="segment">16:00 ~ 16:30</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>




	<br> <br>

	<div class="row">
		<div class="span2 offset5">
			<button id="makeRsrv" class="btn btn-large btn-block btn-info"
				type="submit">提交预约申请</button>
		</div>
	</div>

</form>

<script>
	function prepareBasic() {
		validateUsername();
		validateMobile();
		validateRsrvKey();
		$("#username").change(validateUsername);
		$("#mobile").change(validateMobile);
		$("#rsvKey").change(validateRsrvKey);

	}
	$(prepareBasic);

	function validateRsrvKey() {
		var rsvKey = $("#rsvKey").val();

		if (rsvKey == 'NULL') {
			$("#rsvKey_m").removeClass("hide");
			validBasic = false;
			$("#makeRsrv").attr("disabled", "disabled");
		} else {
			$("#rsvKey_m").addClass("hide");
			$("#makeRsrv").removeAttr("disabled");
		}
	}

	function validateUsername() {
		var username = $("#username").val();
		if (username == '') {
			$("#username_m").removeClass("hide");
			validBasic = false;
			$("#makeRsrv").attr("disabled", "disabled");
		} else {
			$("#username_m").addClass("hide");
			$("#makeRsrv").removeAttr("disabled");
		}
	}

	function validateMobile() {
		var mobile = $("#mobile").val();
		if (mobile == '') {
			$("#mobile_m").removeClass("hide").text("手机号码不能为空");
			validBasic = false;
			$("#makeRsrv").attr("disabled", "disabled");
		} else if (!mobile.match(/^1(3|4|5|8)[0-9]{9}$/)) {
			$("#mobile_m").removeClass("hide").text("手机号码格式不正确！请重新输入！");
			validBasic = false;
			$("#makeRsrv").attr("disabled", "disabled");
		} else {
			$("#mobile_m").addClass("hide").text("");
			$("#makeRsrv").removeAttr("disabled");
		}
	}

	function validMobile(mobile) {
		if (mobile.length != 0 && mobile.match(/^1(3|4|5|8)[0-9]{9}$/)) {
			return true;
		} else {
			return false;
		}
	}
</script>



<%@ include file="footer.jspf"%>