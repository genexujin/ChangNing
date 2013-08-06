<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<style>

/* GLOBAL STYLES
    -------------------------------------------------- */

/* CUSTOMIZE THE NAVBAR
    -------------------------------------------------- */

/* CUSTOMIZE THE CAROUSEL
    -------------------------------------------------- */

/* Carousel base class */
.carousel {
	margin-bottom: 10px;
}

.carousel .container {
	position: relative;
	z-index: 9;
}

.carousel-control {
	height: 50px;
	margin-top: 0;
	font-size: 120px;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .4);
	background-color: transparent;
	border: 0;
	z-index: 10;
}

.carousel .item {
	height: 250px;
}

.carousel img {
	position: absolute;
	top: 0;
	left: 0;
	min-width: 100%;
	height: 250px;
}

.carousel-caption {
	background-color: transparent;
	position: static;
	max-width: 550px;
	padding: 0 20px;
	margin-top: 30px;
}

.carousel-caption h1,.carousel-caption .lead {
	margin: 5px;
	line-height: 1.25;
	color: #fff;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .4);
}

.carousel-caption .btn {
	margin-top: 10px;
}

/* MARKETING CONTENT
    -------------------------------------------------- */

/* Center align the text within the three columns below the carousel */
.marketing .span4 {
	text-align: center;
}

.marketing h2 {
	font-weight: normal;
}

.marketing .span4 p {
	margin-left: 10px;
	margin-right: 10px;
}



</style>
<hr/>
<div id="myCarousel" class="carousel slide">
	<div class="carousel-inner">
		<div class="item active">
			<img src="resources/balance.jpg" alt="">
			<div class="container">
				<div class="carousel-caption">
					<h1>长宁公证之窗</h1>
					<p class="lead">了解公证的窗口 网上办事的平台 沟通信息的桥梁</p>
					<a class="btn btn-large btn-primary"
						href="#">现在就去注册!</a>
				</div>
			</div>
		</div>
		
	</div>
	<!-- a class="left carousel-control"
		href="http://getbootstrap.com/2.3.2/examples/carousel.html#myCarousel"
		data-slide="prev">‹</a> <a class="right carousel-control"
		href="http://getbootstrap.com/2.3.2/examples/carousel.html#myCarousel"
		data-slide="next">›</a-->
</div>
<!-- /.carousel -->

<div class="row">
	<div class="span4">
		<h2>网上办证</h2>
		<p>在线办理30余种涉外公证事项，快捷的受理通道使您免去舟车劳顿之苦。</p>
		<p>
			<a class="btn"
				href="http://getbootstrap.com/2.3.2/examples/carousel.html#">进入网上办证 »</a>
		</p>
	</div>
	<!-- /.span4 -->
	<div class="span4">
		<h2>现场办证预约</h2>
		<p>在线预约到场办证。</p>
		<p>
			<a class="btn"
				href="http://getbootstrap.com/2.3.2/examples/carousel.html#">进入在线预约»</a>
		</p>
	</div>
	<!-- /.span4 -->
	<div class="span4">
		<h2>在线咨询</h2>
		<p>在线咨询业务</p>
		<p>
			<a class="btn"
				href="#" onclick="window.open('http://59064.fy.kf.qycn.com/vclient/chat/?websiteid=59064&clerkid=&clienturl=http%3A%2F%2Fwww.6408.com.cn%2F&originPageTitle='+encodeURIComponent(window.document.title)+'&originPageUrl='+encodeURIComponent(document.referrer), '_blank', 'toolbar=no,scrollbars=yes,menubar=no,status=no,resizable=yes,location=no,width=650,height=530,top=100,left=200')">打开咨询窗口 »</a>
		</p>
	</div>
	<!-- /.span4 -->
</div>
<!-- /.row -->





<%@ include file="footer.jspf"%>