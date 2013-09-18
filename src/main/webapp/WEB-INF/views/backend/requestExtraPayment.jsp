<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">要求客户附加材料</li>
      </ul>
      
      <hr/>
      
      <div class="row">
        <div class="span12">
          <h2>网上办证</h2>
        </div>
      </div>
	  
	  <br>
	  <form class="form-horizontal" action="doRequestExtraPayment.do" method="POST">
	  
		<div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <div class="row">
	            <div class="span9">
	              <h5>&nbsp;&nbsp;&nbsp;&nbsp;附加费用详情</h5>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="border">
	      <br/>
	      <div class="row">
	        <div class="span5 offset1">
	          <div class="control-group">
	            <label class="control-label" for="backendNotaryId">订单申办号：</label>
	            <div class="controls">
	              ${order.readableId}
	            </div>
	          </div>
	        </div>
		  </div>
		  
		  <div class="row">
		    <div class="span5 offset1">
	    	  <div class="control-group">
	    	    <label class="control-label" for="backendNotaryId">附加费用金额：</label>
	    	    <div class="controls">
	    	      ￥<input name="oId" type="hidden" value="${order.id}"></input>
	    	      <input name="extra_pay" type="text"></input>
		    	</div>
	    	  </div>
	    	</div>
		  </div>
		  
		  <div class="row">
		    <div class="span5 offset1">
	    	  <div class="control-group">
	    	    <label class="control-label" for="backendNotaryId">附加费用原因：</label>
	    	    <div class="controls">
	    	      <textarea rows="5" cols="150" name="extra_pay_note"></textarea>
		    	</div>
	    	  </div>
	    	</div>
		  </div>
		  
		  <div class="row">
		    <div class="span2 offset2">
		      <button class="btn" type="submit">确认</button>
		    </div>
		    <div class="span2">
		      <a href="orderDetail.do?oId=${order.id}" class="btn">返回</a>
		    </div>
		  </div>
        
          <br/>
		  
        </div>
      
	  </form>
	  
<%@ include file="../footer.jspf"%>