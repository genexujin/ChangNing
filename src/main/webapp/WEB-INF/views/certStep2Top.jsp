<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
      
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">选择申办业务</li>
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
				<li class="ago">选择申办业务</li>
				<li class="step">输入信息</li>
		        <li class="">上传资料</li>
				<li class="">上门取证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>

      <br>
      <form class="form-horizontal" action="certStep3.do" method="POST">
      <!-- 基本信息 -->
      <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;基本个人信息</h5>
	        </div>
	      </div>
      </div>
      
      <div class="border">
        <br/>
        <div class="row">
	        <div class="span12">
	          
	            <div class="row">
	              <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="username">申请人姓名</label>
			    	  <div class="controls">
			    		<input id="username" name="username" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
		          <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="gender">性别</label>
			    	  <div class="controls">
			    		<SELECT id="gender" name="gender">
							<OPTION selected value="MALE">男</OPTION>
							<OPTION  value="FEMALE">女</OPTION>
						</SELECT>
			    	  </div>
			    	</div>
	    		  </div>
	    		</div>
	    		<div class="row">
	    		  <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="mobile">手机号</label>
			    	  <div class="controls">
			    		<input id="mobile" name="mobile" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="email">邮箱</label>
			    	  <div class="controls">
			    		<input id="email" name="email" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	            </div>
	            <div class="row">
	              <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="address">地址</label>
			    	  <div class="controls">
			    		<input id="address" name="address" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	            </div>
	          
	    	</div>
	    </div>      
      </div>