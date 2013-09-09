<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">支付</li>
      </ul>
      
      <hr/>
      
      <div class="row">
        <div class="span12">
          <h2>网上办证</h2>
        </div>
      </div>
      
	  <div class="row">
	    <div class="span12">
		  <div class="flowstep">
			<ol>
				<li class="pass">选择申办业务</li>
				<li class="pass">输入信息</li>
		        <li class="pass">上传资料</li>
				<li class="ago">上门送证</li>
		        <li class="step">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	   <br>
	   
	    <div class="border">
	      <br/>
	      <div class="row">
		      <div class="span5"><img src="resources/icon_succ_large.png" style="padding-left:20px; padding-right:10px;"/> 您已成功付款 <font color=red><fmt:formatNumber value="${totalFee}" type="currency" pattern="￥#.00"/></font>元  人民币。</div>
		      <div class="span5">商品名称： </div>
		  </div>
		 </div>

<%@ include file="footer.jspf"%>