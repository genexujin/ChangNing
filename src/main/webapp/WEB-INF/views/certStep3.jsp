<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">上传资料</li>
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
				<li class="ago">输入信息</li>
		        <li class="step">上传资料</li>
				<li class="">上门取证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	  <br>
	  
	  <form class="form-horizontal" action="certStep3.do" method="POST">
	  
		  <div class="bar-bg">
		      <div class="row">
		        <div class="span12 navbg2">
		          <h5>&nbsp;&nbsp;&nbsp;&nbsp;上传材料</h5>
		        </div>
		      </div>
	      </div>
	      
	      <div class="border">
	        
	        <input type="file" placeholder="Select File" id="order" name="order" multiple/>
	        <button id="upload">上传</button>
		    
	      </div>

	      <br>
	      <br/>
		  <div class="row">
	   		  <div class="span2 offset5">
	   		    <button class="btn btn-large btn-block btn-info" type="submit">下一步</button>
	   		  </div>
	      </div>
      
      </form>
      
<%@ include file="footer.jspf"%>