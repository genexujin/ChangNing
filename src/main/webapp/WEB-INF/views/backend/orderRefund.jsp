<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">退款</li>
      </ul>
      
      <hr/>
	  
	  <br>
	  <form class="form-horizontal" action="doRefund.do" method="POST">
	  
		<div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <div class="row">
	            <div class="span9">
	              <h5>&nbsp;&nbsp;&nbsp;&nbsp;退款</h5>
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
	            <label class="control-label">订单申办号：</label>
	            <div class="controls">
	              ${order.readableId}
	            </div>
	          </div>
	        </div>
	        <div class="span5">
	          <div class="control-group">
	            <label class="control-label">总金额：</label>
	            <div class="controls">
	              <fmt:formatNumber value="${order.paymentTotal}" type="currency" pattern="￥#.00"/>
	            </div>
	          </div>
	        </div>
		  </div>
		  
		  <div class="row">
		    <div class="span10 offset1">
	    	  <table class="table table-striped table-bordered table-hover">
	            <thead>
	              <tr>
	                <th>序号</th>
	                <th>收费项目</th>
	                <th>收费说明</th>
	                <th>费用</th>
	                <th>支付日期</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach items="${order.payments}" var="payment" varStatus="counter">
	                <tr>
	                  <td>${counter.index}</td>
	                  <td>${payment.title}</td>
	                  <td>${payment.paymentReason}</td>
	                  <td><fmt:formatNumber value="${payment.paymentTotal}" type="currency" pattern="￥#.00"/></td>
	                  <td><fmt:formatDate value="${payment.paymentDate}" pattern="yyyy-MM-dd"/></td>
	                </tr>
	              </c:forEach>
	            </tbody>
	          </table>
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