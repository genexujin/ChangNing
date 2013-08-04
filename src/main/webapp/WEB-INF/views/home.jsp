<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<script type="text/javascript">
	$(document).ready(function() {
		$("#menu-collapse").accordion({
			header : "h3"
		});
	});
</script>
<hr />

<div class="container">

	<div id="menu" style="float:left; width:150px; height:500px;">
		<div id="menu-collapse">
			<div>
				<h3>First</h3>
				<div>Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.
					Lorem ipsum dolor sit amet.</div>
			</div>
			<div>
				<h3>Second</h3>
				<div>Phasellus mattis tincidunt nibh.</div>
			</div>
			<div>
				<h3>Third</h3>
				<div>Nam dui erat, auctor a, dignissim quis.</div>
			</div>
		</div>
	</div>
	<div id="content" style="float:left; margin-left:2px;">
		<img src="<c:url value="/resources/balance.jpg"/>" />
		<div id="links">
			<div id="link1" style="float:left;">Image1</div>
			<div id="link2" style="float:left; margin-left:10px;">Image2</div>
			<div id="link3" style="float:left; margin-left:10px;">Image3</div>
		</div>
	</div>
</div>
<%@ include file="footer.jspf"%>