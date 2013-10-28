<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<script src="js/jquery.form.js"></script>
<script src="<c:url value="/datepicker/js/bootstrap-datepicker.js"/>"></script>
<script src="<c:url value="/js/bootstrap-paginator.js"/>"></script>
<!-- 
<ul class="breadcrumb">
	<b>您的位置：</b>
	<li><a href="#">首页</a> <span class="divider">/</span></li>	
	<li class="active">工作日设定与查询</li>
</ul> -->
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
			<li><a href="reserv_Query.do">预约订单管理</a></li>
			<li><a href="enterModify.do">个人信息修改</a></li>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin}">
					<li class="active"><a href="enterWorkdaySetting.do">工作日设定</a></li>
				</c:when>
			</c:choose>
			<c:choose>
				<c:when test="${sessionScope['LOGIN_USER'].admin}">
					<li><a href="enterUserQuery.do">用户管理</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>

	<div class="span9" style="width: 760px; margin-left: 6px;">

		<div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;工作日设定</h5>
              </div>             
            </div>
          </div>
        </div>
      </div>
<div class="workarea">
		<div class="border">
			<br />
			<div class="row">
				<form action="/ChangNing/saveWorkday.do" method="post"
					id="workdaysettingform">
					
					<div class="span12 offset1">
						<div class="row">
							<div class="controls span4">
								日期：&nbsp;<input id="datepicker" class="" type="text"
									name="date" />
							</div>
							<div class="span3">
								<div id="workday_select_alert" class="alert alert-info">请点击选择日期
								</div>
							</div>
						</div>



						<div class="row" style="padding-top:15px;">
							<div class="span8">
								<div class="span2" style="width:80px;">
									<label class="control-label"> <input type="radio" name="type"
										id="type" value="WORKDAY" class="controls" checked> 工作日
									</label>
								</div>
								<div class="span2" style="width:80px;">
									<label class="control-label"> <input type="radio" name="type"
										id="type" class="controls" value="NON_WORKDAY"> 非工作日
									</label>
								</div>
							</div>
						</div>
						<div class="row" style="padding-top:15px;">
							<div class="control-group">
								<div class="span4">
									说明：
									<textarea rows="3" cols="60" id="description" name="description"></textarea>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="span3">
								<button class="btn btn-medium" type="submit">保存</button>
							</div>
							<div class="span2">
								<div id="workday_alert" class="alert" style="display: none">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="span10"></div>
						</div>
					</div>
				</form>
				
			</div>
			<br>
			<br>
		</div>
		
		

		<div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;已设定的工作日查询</h5>
              </div>             
            </div>
          </div>
        </div>
      </div>

		<div class="border">
			<br />
			<div class="row">
				<div class="span10 offset1">


					<div class="row">
						<div class="span5">
							请选择年份：<SELECT id="year" name="year">
								<option>2013</option>
								<option>2014</option>
							</SELECT>

						</div>
					</div>

					<div class="row">
						<div class="span5">
							请选择月份：<SELECT id="month" name="month">
								<option>1</option>
								<option>2</option>
								<option>3</option>
								<option>4</option>
								<option>5</option>
								<option>6</option>
								<option>7</option>
								<option>8</option>
								<option>9</option>
								<option>10</option>
								<option>11</option>
								<option>12</option>
							</SELECT>

						</div>
						<button class="btn" type="submit" id="showlist">查询</button>
					</div>



					<div class="row">
						<div class="span8">
							<table class="table table-bordered table-striped" id="infotable">


							</table>
							<div id="example"></div>
						</div>
					</div>


				</div>
			</div>
		</div>

	</div>
</div>
</div>

<script type="text/javascript">
	$("#datepicker").datepicker();
	$("#set_one_year").click(function() {
		$.ajax({
			url : "/ChangNing/setOneYear.do"
		});
	});

	var options = {
		currentPage : 1,
		totalPages : 3,
		numberOfPages : 15,
		alignment : "center",
		onPageClicked : function(e, originalEvent, type, page) {
			$
					.ajax({
						type : "post",
						url : "/ChangNing/getWorkdayList.do",
						data : {
							year : $("#year").val(),
							month : $("#month").val(),
							pageNO : page
						},
						success : function(data) {
							$("#infotable")
									.html(
											'<tr class="info" id="info"><td class="span2">日期</td><td class="span5">说明</td><td class="span3">工作日/非工作日</td></tr>');
							var json = $.parseJSON(data);
							$
									.each(
											json,
											function(index, content) {
												$("#infotable")
														.append(
																'<tr><td>'
																		+ timeStamp2String(content.date)
																		+ '</td><td>'
																		+ descriptionformat(content.description)
																		+ '</td><td>'
																		+ typeformat(content.type)
																		+ '</td></tr>');
											});
						}
					});
		}
	}
	$('#example').bootstrapPaginator(options);

	$("#showlist")
			.click(
					function() {
						$
								.ajax({
									type : "post",
									url : "/ChangNing/getWorkdayList.do",
									data : {
										year : $("#year").val(),
										month : $("#month").val(),
										pageNO : 1
									},
									success : function(data) {
										$("#infotable")
												.html(
														'<tr class="info" id="info"><td class="span2">日期</td><td class="span5">说明</td><td class="span3">工作日/非工作日</td></tr>');
										var json = $.parseJSON(data);
										$
												.each(
														json,
														function(index, content) {
															$("#infotable")
																	.append(
																			'<tr><td>'
																					+ timeStamp2String(content.date)
																					+ '</td><td>'
																					+ descriptionformat(content.description)
																					+ '</td><td>'
																					+ typeformat(content.type)
																					+ '</td></tr>');
														});
									}
								});
					});

	//格式化日期：yyyy-MM-dd
	function timeStamp2String(time) {
		var datetime = new Date();
		datetime.setTime(time);
		var year = datetime.getFullYear();
		var month = datetime.getMonth() + 1 < 10 ? "0"
				+ (datetime.getMonth() + 1) : datetime.getMonth() + 1;
		var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
				: datetime.getDate();

		return year + "-" + month + "-" + date;
	}

	//格式化类型
	function typeformat(txt) {
		var type = null;
		if (txt == 'WORKDAY') {
			type = '工作日';
		}
		if (txt == 'NON_WORKDAY') {
			type = '非工作日';
		}
		return type;
	}
	//格式化说明
	function descriptionformat(txt) {
		var type = null;
		if (txt == null) {
			type = '';
		} else {
			type = txt;
		}

		return type;
	}

	$(function() {
		$("#workdaysettingform").ajaxForm(
				function() {
					$("#workday_alert").removeClass().addClass(
							"alert alert-success").show().html("保存成功！");
				});
	});

	function add() {
		var addyear = $("#Year").val();
		$.ajax({
			type : "POST",
			url : "/ChangNing/setYear/" + addyear + ".do",
			success : function(msg) {
				if (msg == 0) {
					$("#workday_select_alert").removeClass().addClass(
							"alert alert-error").html("您已经设置过本年度工作日程！");
				} else if (msg == 1) {
					$("#workday_select_alert").removeClass().addClass(
							"alert alert-success").html("设置成功");
				}
			}
		});
		//document.location.href="http://localhost:8080/ChangNing/setYear/"+addyear+".do";
	}
</script>
<%@ include file="footer.jspf"%>