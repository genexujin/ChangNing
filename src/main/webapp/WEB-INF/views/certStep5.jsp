<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		        <li class="step end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	  <br>
	  <form class="form-horizontal" action="certStep5.do" method="POST">
	  
		<div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <div class="row">
	            <div class="span9">
	              <h5>&nbsp;&nbsp;&nbsp;&nbsp;在线支付</h5>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="border">
	      <br/>
	      <div class="row">
		      <div class="span5 offset1">尊敬的用户，您的支付费用为：<font color=red>100.00</font>元  人民币。</div>
		  </div>
		  
		  <br/>
		  <hr/>
		  <br/>
		  
		  
		  
	    </div>
	    
	    <div class="row">
   		  <div class="span2 offset5">
   		    <button id="payBill" class="btn btn-large btn-block btn-info" type="submit">立即支付</button>
   		  </div>    		  
   	    </div>
	  </form>

<%@ include file="footer.jspf"%>	  