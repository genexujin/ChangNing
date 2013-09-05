<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="<c:url value="/js/bootstrap-paginator.js"/>"></script>

<ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">预约查询</li>
</ul>

<div class="bar-bg">
	<div class="row">
		<div class="span12 navbg2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预约查询</div>
	</div>
</div>


<div class="border">
	<br />
	<div class="row">
		<div class="span12">

			<div class="row" id="requestor">
				<div class="span5">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预约号：<input type="text" class="input" id="readable_id" placeholder="预约号"  name="readable_id">
				</div>
				
				<div class="span2">
					<button class="btn" type="submit" id="showlist1">查询</button>
				</div>
			</div>
			<div class="row" id="workers">
				<div class="span5">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;预约号：<input type="text" class="input" id="readable_id1" placeholder="预约号"  name="readable_id1">
				</div>
				<div class="span5">
					订单状态：	<SELECT id="status" name="status">
								<OPTION selected value="NULL">请选择</OPTION>
								<OPTION  value="SUBMITTED">已创建</OPTION>
								<OPTION  value="FINISHED">已完成</OPTION>
								<OPTION  value="CANCELLED">已取消</OPTION>
							</SELECT>
				</div>
				<div class="span2">
					<button class="btn" type="submit" id="showlist2">查询</button>
				</div>
			</div>

			<div class="row">
				<div class="span10 offset1">
					<table class="table table-bordered" id="infotable">


					</table>
					<div id="example" class= "offset3"></div>
				</div>
			</div>


		</div>
	</div>
</div>

<script type="text/javascript">

var options = {
		currentPage: 1,
		totalPages: 100,
		numberOfPages:5,
		alignment:"center",
		onPageClicked: function(e,originalEvent,type,page){
			$.ajax({type : "post",
				url : "/ChangNing/workerQuery.do",
				data : {
						readableId : $("#readable_id1").val(),
						reservStatus : $("#status").val(),
						pageNO: page
				},
				success : function(data) {
					$("#infotable").html('<tr class="info" id="info"><td class="span2">申办号</td><td class="span3">时间</td><td class="span1">申办人</td><td class="span2">公证项</td><td class="span2">处理状态</td><td class="span2">操作</td></tr>');
						var json = $.parseJSON(data);
						$.each(json,function(index, content) {
						$("#infotable").append('<tr><td>'+content.readableId+'</td><td>'+timeStamp2String(content.reservDate)+'&nbsp;'+content.reservTime+'</td><td>'+content.requestorName+'</td><td>'+content.reservKey+'</td><td id="nowstatus">'+reservstatusformat(content.reservStatus)+'</td><td class="span1"><button class="btn" type="button" id="finish">完成预约</button></td></tr>');
						$("#finish").click(function(){
							$.ajax({url:"/ChangNing/finishReserv.do?readableId="+content.readableId});
								});
						});		
						
				}
		});
		}
	}
$('#example').bootstrapPaginator(options);
	
	$("#showlist1").click(function () {
						$.ajax({type : "post",
								url : "/ChangNing/customQuery.do",
								data : {
									readableId : $("#readable_id").val()
								},
								success : function(data) {
									$("#infotable").html('<tr class="info" id="info"><td class="span2">申办号</td><td class="span3">时间</td><td class="span1">申办人</td><td class="span2">公证项</td><td class="span2">处理状态</td><td class="span2">操作</td></tr>');
										var json = $.parseJSON(data);
										$("#infotable").append('<tr><td>'+json.readableId+'</td><td>'+timeStamp2String(json.reservDate)+'&nbsp;'+json.reservTime+'</td><td>'+json.requestorName+'</td><td>'+json.reservKey+'</td><td>'+reservstatusformat(json.reservStatus)+'</td><td class="span1"><button class="btn" type="button" id="cancle">取消预约</button></td></tr>');
										$("#cancle").click(function(){
													$.ajax({url:"/ChangNing/cancleReserv.do?readableId="+json.readableId});
										});
												
										
								}
						});
					});

	
	$("#showlist2").click(function () {
		$.ajax({type : "post",
				url : "/ChangNing/workerQuery.do",
				data : {
					readableId : $("#readable_id1").val(),
					reservStatus : $("#status").val(),
					pageNO: 1
				},
				success : function(data) {
					$("#infotable").html('<tr class="info" id="info"><td class="span2">申办号</td><td class="span3">时间</td><td class="span1">申办人</td><td class="span2">公证项</td><td class="span2">处理状态</td><td class="span2">操作</td></tr>');
						var json = $.parseJSON(data);
						$.each(json,function(index, content) {
						$("#infotable").append('<tr><td>'+content.readableId+'</td><td>'+timeStamp2String(content.reservDate)+'&nbsp;'+content.reservTime+'</td><td>'+content.requestorName+'</td><td>'+content.reservKey+'</td><td id="nowstatus">'+reservstatusformat(content.reservStatus)+'</td><td class="span1"><button class="btn" type="button" id="finish">完成预约</button></td></tr>');
						$("#finish").click(function(){
							$.ajax({url:"/ChangNing/finishReserv.do?readableId="+content.readableId});
								});
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

	//格式化订单状态
		function reservstatusformat(txt){
			var status =null;
			if (txt == 'SUBMITTED'){
				status = '已创建';
			}
			if (txt == 'FINISHED'){
				status = '已完成';
			}
			if (txt == 'CANCELLED'){
				status = '已取消';
			}
			return status;
	}
</script>

<%@ include file="footer.jspf"%>