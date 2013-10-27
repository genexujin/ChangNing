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
  <div class="workarea">
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
							<div class="offset1" style="padding-left: 40px;">
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
							<div class="offset1" style="padding-left: 40px;">
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
						<strong>请选择预约日期，注：只能从第二天起的7个自然日内的工作日中选择。</strong>
					</p>
				</div>
				<div class="row">
					<div class="span9 offset2">
						<div class="control-group">
							<table class="table table-bordered">

								<tr>
									<c:forEach items="${dayList}" var="workday">
										<td class="wdheader">${workday}</td>
									</c:forEach>

								</tr>
								<tr>
									<c:set var="seq" value="1" />
									<c:forEach items="${dayTypeList}" var="dayType">
										<td id="workday${seq}" class="${dayType.style}"
											<c:choose>
												<c:when test="${dayType.style=='workday'}">
												onclick="javascript:checkSegment(${seq},'workday${seq}')"
													
												</c:when>
												<c:otherwise>
													
												</c:otherwise>
											</c:choose>
											>
											${dayType.linkText}</td>
										<c:set var="seq" value="${seq+1}" />
									</c:forEach>

								</tr>
							</table>
						</div>
					</div>
				</div>

				<div id="seg_title" class="row">
					<div class="span7 offset2">
						<strong>请选择预约时间：</strong>
					</div>
				</div>


				<div id="seg_container" class="row">
					<div class="span7 offset3">
						<div class="control-group">
							<table class="table table-bordered table-hover">
								<tr>
									<td id="segheader" class="segmenthd">2013-09-11 星期三</td>
								</tr>
								<tr>
									<td id="slot1" class="segment">08:30 ~ 9:00</td>
								</tr>
								<tr>
									<td id="slot2" class="segment">09:00 ~ 9:30</td>
								</tr>
								<tr>
									<td id="slot3" class="segment">09:30 ~ 10:00</td>
								</tr>
								<tr>
									<td id="slot4" class="segment">10:00 ~ 10:30</td>
								</tr>
								<tr>
									<td id="slot5" class="segment">10:30 ~ 11:00</td>
								</tr>
								<tr>
									<td id="slot6" class="segment">11:00 ~ 11:30</td>
								</tr>
								<tr>
									<td class="segmenthd">午休</td>
								</tr>
								<tr>
									<td id="slot7" class="segment">13:30 ~ 14:00</td>
								</tr>
								<tr>
									<td id="slot8" class="segment">14:00 ~ 14:30</td>
								</tr>
								<tr>
									<td id="slot9" class="segment">14:30 ~ 15:00</td>
								</tr>
								<tr>
									<td id="slot10" class="segment">15:00 ~ 15:30</td>
								</tr>
								<tr>
									<td id="slot11" class="segment">15:30 ~ 16:00</td>
								</tr>
								<tr>
									<td id="slot12" class="segment">16:00 ~ 16:30</td>
								</tr>
							</table>
						</div>
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
				type="button" onclick="submitOrder();">提交预约申请</button>
		</div>
	</div>

</form>

<script>
	var selectedWorkday;
	var selectedSegment;
	var theLimit = ${limit};

	

	var theSegments;

	function prepareBasic() {
		validateUsername();
		validateMobile();
		validateRsrvKey();
		$("#username").change(validateUsername);
		$("#mobile").change(validateMobile);
		$("#rsvKey").change(validateRsrvKey);

	}
	$("#seg_title").hide();
	$("#seg_container").hide();
	$(prepareBasic);

	function validateTimeSelection() {
		if (selectedWorkday == null || selectedSegment == null)
			return false;
		else
			return true;
	}

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

	var lastTD;
	var lastSlot;

	function checkSegment(seq, lasttd) {
		
		//选择的日期变色
		$("#" + lastTD).removeAttr('style');
		lastTD = lasttd;
		$("#" + lastTD).css('background-color', '#FFFF70');
		selectedWorkday = seq;

		$.ajax({
			type : "post",
			url : "/ChangNing/checkSegment.do",
			data : {
				sequence : seq
			},
			async : false,
			success : function(data) {
				refreshSegments(data);
			}
		});
	}

	function refreshSegments(data) {
		if (data != null) {
			//alert(data);
			var theWorkDay = jQuery.parseJSON(data);
			var d = new Date();
			d.setTime(theWorkDay.date);
			$("#segheader").html(d.toLocaleDateString());
			theSegments = theWorkDay.timeSegments;
			//alert(segs);
			initializeSegemnts();

			$("#seg_container").show();

		}
	}

	function initializeSegemnts() {
		//initialize all segments to be available for booking...
		$("#slot1").removeAttr('style');
		$("#slot2").removeAttr('style');
		$("#slot3").removeAttr('style');
		$("#slot4").removeAttr('style');
		$("#slot5").removeAttr('style');
		$("#slot6").removeAttr('style');
		$("#slot7").removeAttr('style');
		$("#slot8").removeAttr('style');
		$("#slot9").removeAttr('style');
		$("#slot10").removeAttr('style');
		$("#slot11").removeAttr('style');
		$("#slot12").removeAttr('style');

		if (ifSegAvailable('08:30 ~ 9:00')) {
			$("#slot1").html('08:30 ~ 9:00    有空闲');
			$("#slot1").click(function() {
				bookSegment('08:30 ~ 9:00', '#slot1');
			});

		} else {
			$("#slot1").html('08:30 ~ 9:00   坐席满');
			$("#slot1").attr("class", "segmentfull");

		}

		if (ifSegAvailable('09:00 ~ 9:30')) {
			$("#slot2").html('09:00 ~ 9:30 有空闲');
			$("#slot2").click(function() {
				bookSegment('09:00 ~ 9:30', '#slot2');
			});
		} else {
			$("#slot2").html('09:00 ~ 9:30  坐席满');
			$("#slot2").attr("class", "segmentfull");
		}

		if (ifSegAvailable('09:30 ~ 10:00')) {
			$("#slot3").html('09:30 ~ 10:00    有空闲');

			$("#slot3").click(function() {
				bookSegment('09:30 ~ 10:00', '#slot3');
			});
		} else {
			$("#slot3").html('09:30 ~ 10:00    坐席满');
			$("#slot3").attr("class", "segmentfull");
		}

		if (ifSegAvailable('10:00 ~ 10:30')) {
			$("#slot4").html('10:00 ~ 10:30    有空闲');

			$("#slot4").click(function() {
				bookSegment('10:00 ~ 10:30', '#slot4');
			});
		} else {
			$("#slot4").html('10:00 ~ 10:30    坐席满');
			$("#slot4").attr("class", "segmentfull");
		}

		if (ifSegAvailable('10:30 ~ 11:00')) {
			$("#slot5").html('10:30 ~ 11:00    有空闲');

			$("#slot5").click(function() {
				bookSegment('10:30 ~ 11:00', '#slot5');
			});
		} else {
			$("#slot5").html('10:30 ~ 11:00    坐席满');
			$("#slot5").attr("class", "segmentfull");
		}

		if (ifSegAvailable('11:00 ~ 11:30')) {
			$("#slot6").html('11:00 ~ 11:30    有空闲');

			$("#slot6").click(function() {
				bookSegment('11:00 ~ 11:30', '#slot6');
			});
		} else {
			$("#slot6").html('11:00 ~ 11:30    坐席满');
			$("#slot6").attr("class", "segmentfull");
		}

		if (ifSegAvailable('13:30 ~ 14:00')) {
			$("#slot7").html('13:30 ~ 14:00    有空闲');

			$("#slot7").click(function() {
				bookSegment('13:30 ~ 14:00', '#slot7');
			});
		} else {
			$("#slot7").html('13:30 ~ 14:00    坐席满');
			$("#slot7").attr("class", "segmentfull");
		}

		if (ifSegAvailable('14:00 ~ 14:30')) {
			$("#slot8").html('14:00 ~ 14:30    有空闲');

			$("#slot8").click(function() {
				bookSegment('14:00 ~ 14:30', '#slot8');
			});
		} else {
			$("#slot8").html('14:00 ~ 14:30    坐席满');
			$("#slot8").attr("class", "segmentfull");
		}

		if (ifSegAvailable('14:30 ~ 15:00')) {
			$("#slot9").html('14:30 ~ 15:00    有空闲');

			$("#slot9").click(function() {
				bookSegment('14:30 ~ 15:00', '#slot9')
			});
		} else {
			$("#slot9").html('14:30 ~ 15:00    坐席满');
			$("#slot9").attr("class", "segmentfull");
		}

		if (ifSegAvailable('15:00 ~ 15:30')) {
			$("#slot10").html('15:00 ~ 15:30    有空闲');

			$("#slot10").click(function() {
				bookSegment('15:00 ~ 15:30', '#slot10');
			});
		} else {
			$("#slot10").html('15:00 ~ 15:30    坐席满');
			$("#slot10").attr("class", "segmentfull");
		}

		if (ifSegAvailable('15:30 ~ 16:00')) {
			$("#slot11").html('15:30 ~ 16:00    有空闲');

			$("#slot11").click(function() {
				bookSegment('15:30 ~ 16:00', '#slot11');
			});
		} else {
			$("#slot11").html('15:30 ~ 16:00    坐席满');
			$("#slot11").attr("class", "segmentfull");
		}

		if (ifSegAvailable('16:00 ~ 16:30')) {
			$("#slot12").html('16:00 ~ 16:30    有空闲');

			$("#slot12").click(function() {
				bookSegment('16:00 ~ 16:30', '#slot12');
			});
		} else {
			$("#slot12").html('16:00 ~ 16:30    坐席满');
			$("#slot12").attr("class", "segmentfull");
		}

	}

	function ifSegAvailable(key) {
		//alert('checking key: '  + key + ' in segments: '+ theSegments.length);
		//for ( var key in theSegments[0]) {
		//	alert('key: ' + key + '\n' + 'value: ' + theSegments[0][key]);
		//}

		for (i = 0; i < theSegments.length; i++) {
			var seg = theSegments[i];
			//if(seg.startTime == key)
			//	alert('start Time: ' + seg.startTime + ' size: ' + seg.resvCount  + ' limit:' + theLimit);
			if (seg.startTime == key && seg.resvCount >= theLimit) {
				return false;
			}
		}

		return true;

	}

	function bookSegment(key, slot) {
		//alert(key);
		//alert(lastSlot);
		if (lastSlot)
			lastSlot.removeAttr('style');
		lastSlot = $(slot);
		selectedSegment = key;
		lastSlot.css('background-color', '#FFFF70');
	}

	function submitOrder() {
		if (selectedWorkday == null || selectedSegment == null) {
			alert("请选择预约日期和时间！");
		} else {

			var userName = $("#username").val();
			var mobile = $("#mobile").val();
			var rsvKey = $("#rsvKey").val();

			$.ajax({
				type : "post",
				url : "/ChangNing/makeReserv.do",
				data : {
					title : rsvKey,
					name : userName,
					mobile : mobile,
					sequence : selectedWorkday,
					startTime : selectedSegment
				},
				async : false,
				success : function(data) {
					//alert(data);
					var result = jQuery.parseJSON(data);
					if (result.success == '0') {
						alert('您预订的日期和时间已无空闲坐席，请重新选择！');
						checkSegment(result.sequence, "workday"
								+ result.sequence);
					} else if (result.success == '1') {
						alert('预订成功，系统将重定向到预约查询页面！');
						window.location.href="/ChangNing/reserv_Query.do";
					} else if (result.success == '2') {
						alert('对不起，您在一天之内只能做一次成功的预订，并且在一周之内只能做3次成功的预订！');
					}

				}
			});
		}
	}
</script>



<%@ include file="footer.jspf"%>