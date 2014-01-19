<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<!-- <ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>
	<li><a href="enterReserv.do">网上预约</a> <span class="divider">/</span></li>
	<li class="active">预约申请</li>
</ul> -->

<div class="row">
	<div class="span12 content_title">
		<h2>预约时间段定义</h2>
	</div>
</div>


<div class="row">

<div class="span2 well" style="margin-left: 22px; width: 154px;">
		<ul class="nav nav-list">
			<li><h5>我的菜单</h5>
			<li><a href="orderQuery.do">办证订单管理</a></li>
			<div class="divider"></div>
			<li><a href="reserv_Query.do">预约订单管理</a></li>
			
			<div class="divider"></div>
			<li><a href="enterModify.do">个人信息修改</a></li>
			<div class="divider"></div>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin}">
				
			<li class="active"><a href="enterSlots.do">预约时间段</a></li>
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
<form class="form-horizontal" action="saveSlot.do" method="POST">
  <div class="workarea">
	<div class="bar-bg" style="margin-left: 1px; width: 778px;">
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

	<div class="border" style="width: 777px;">
		<br />
		<div class="row">
			<p style="padding-left: 70px; padding-bottom: 10px;">
				<strong>请录入时间段定义，请先选择上午或者下午，然后输入时间范围，如 09:00 ~ 10:00。 </strong>
			</p>
		</div>

		<div class="row">
			<div class="span12">
				<div class="row">
					<div class="span2 offset1">
						<div class="control-group">
							<label class="control-label" for="dest">上午/下午</label>
							<div class="controls">
								<SELECT id="amKey" name="amKey">
									<OPTION selected value="Y">上午</OPTION>
									<OPTION value="N">下午</OPTION>								
								</SELECT>
							</div>
						</div>
					</div>
					<div id="amKey_m" class="span4 hide alert alert-error">必须选择上午还是下午
					</div>
				</div>
				<div class="row">
					<div class="span5 offset1">
						<div class="control-group">
							<label class="control-label" for="username">时间范围</label>
							<div class="offset1" style="padding-left: 40px;">
								<input id="slotTag" name="slotTag" type="text"
									value="09:00 ~ 10:00""></input>
							</div>
						</div>
					</div>
					<div id="tag_m" class="span4 hide alert alert-error">时间范围不能为空
					</div>
				</div>

				<div class="row">
					<div class="span5 offset1">
						<button id="makeSlot" class="btn btn-medium btn-info"
				type="submit">保存</button>
				<button id="cleanAll" class="btn btn-medium btn-info"
				type="button" onclick="javascript:window.location.href='cleanSlots.do'">清除所有</button>
					</div>					
				</div>
				<br>
				
				<div id="seg_container" class="row">
					<div class="span7 offset1">
						<div class="control-group">
							<table class="table table-bordered table-hover">
								<tr>
									<td id="segheader" class="segmenthd">预约时间段定义列表</td>
								</tr>
								<c:forEach items="${amslots}" var="amslot">
									<tr>
										<td class="segment"><c:out value="${amslot.tag}"/></td>
									</tr>
								</c:forEach>
								<tr>
									<td class="segmenthd">午休</td>
								</tr>
								<c:forEach items="${pmslots}" var="pmslot">
									<tr>
										<td class="segment"><c:out value="${pmslot.tag}"/></td>
									</tr>
								</c:forEach>
										
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>  
  </div>

	<br> <br>


</form>
</div>

</div>


<script>
	
	function prepareBasic() {
		validateAMKey();
		validateSlotTag();
		$("#amKey").change(validateAMKey);
		$("#slotTag").change(validateSlotTag);

	}

	


	function validateAMKey() {
		var amKey = $("#amKey").val();
		if (amKey == 'NULL') {
			$("#amKey_m").removeClass("hide");
			validBasic = false;
			$("#makeSlot").attr("disabled", "disabled");
		} else {
			$("#amKey_m").addClass("hide");
			$("#makeSlot").removeAttr("disabled");
		}

	}
	
	function validateSlotTag() {
		var slotTag = $("#slotTag").val();
		if (slotTag == '') {
			$("#tag_m").removeClass("hide");
			validBasic = false;
			$("#makeSlot").attr("disabled", "disabled");
		} else {
			$("#tag_m").addClass("hide");
			$("#makeSlot").removeAttr("disabled");
		}
	}
	
	$(prepareBasic);
	
	
	

</script>



<%@ include file="footer.jspf"%>