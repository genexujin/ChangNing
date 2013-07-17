<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
<script type="text/javascript">
var second=5;
var timer;
function change()
{
    second--;
 
 if(second>-1)
 {
     document.getElementById("second").innerHTML=second;
  timer = setTimeout('change()',1000);
 }
 else
 {
     clearTimeout(timer);
 }
}
timer = setTimeout('change()',1000);
</script>
<meta http-equiv="refresh" content="5;URL=/ChangNing/enterRegister.do">
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
${msg}<div align="center" id=second>5</div>秒后自动跳转到注册页面