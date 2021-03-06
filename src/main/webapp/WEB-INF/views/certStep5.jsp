<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

<!--       <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="certStep1.do">网上办证</a> <span class="divider">/</span></li>
        <li class="active">支付</li>
      </ul> -->
      
      <div class="row">
        <div class="span12 content_title">
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
				<li class="pass">上门送证</li>
				<li class="ago">确认订单</li>
		        <li class="step">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	  <br>
	  <form class="form-horizontal" action="payment.do" method="POST" id="payForm" target="_blank">
	    <div class="workarea">
			<div class="bar-bg">
		      <div class="row">
		        <div class="span12 navbg2">
		          <div class="row">
		            <div class="span8">
		              <h5>&nbsp;&nbsp;&nbsp;&nbsp;在线支付</h5>
		            </div>
		            <div class="span3">
						<h5>申办号：<c:out value="${order.readableId}"></c:out></h5>
					</div>
		          </div>
		        </div>
		      </div>
		    </div>
		    
		    <div class="border">
		      <br/>
		      <div class="row">
			      <div class="span5 offset1">尊敬的用户，您的支付费用为：<font color=red><fmt:formatNumber value="${order.paymentTotal}" type="currency" pattern="￥#.00"/></font>元  人民币。</div>
			  </div>
			  
			  <br/>
			  <hr/>
			  <br/>
			  
			  <div class="row">
			    <div class="span9 offset1"><font><strong>费用明细</strong></font>
			    	
			    </div>
			    
			  </div>
			  <br/>
			  <div class="row">
			    <div class="span10 offset1">
				  <table class="table table-striped table-bordered table-hover">
		            <thead>
		              <tr>
		                <th></th>
		                <th>公证费用</th>
		                <th>副本费用</th>
		                <th>证词翻译费用</th>
		                <th>文件翻译费用</th>
		                <th>调查费</th>
		              </tr>
		            </thead>
		            <tbody>
		              <c:forEach items="${order.forms}" var="form" >
		                <c:forEach items="${form.feeItems}" var="fee">
		                  <tr>
		                    <td>${fee.feeName}公证</td>
		                    <td><fmt:formatNumber value="${fee.notaryFee}" type="currency" pattern="￥#.00"/></td>
		                    <td><fmt:formatNumber value="${fee.copyFee}" type="currency" pattern="￥#.00"/></td>
		                    <td>
		                      <c:if test="${fee.wordTranslationFee > 0}">
		                        <fmt:formatNumber value="${fee.wordTranslationFee}" type="currency" pattern="￥#.00"/>
		                      </c:if>
		                    </td>
		                    <c:choose>
		                      <c:when test="${fee.fileTranslationFee < 0}">
		                        <td>见文件报价</td>
		                      </c:when>
		                      <c:when test="${fee.fileTranslationFee > 0}">
		                        <td><fmt:formatNumber value="${fee.fileTranslationFee}" type="currency" pattern="￥#.00"/></td>
		                      </c:when>
		                      <c:otherwise>
		                        <td></td>
		                      </c:otherwise>
		                    </c:choose>
		                    <c:choose>
		                      <c:when test="${fee.investigationFee > 0}">
		                        <td><fmt:formatNumber value="${fee.investigationFee}" type="currency" pattern="￥#.00"/></td>
		                      </c:when>
		                      <c:otherwise>
		                        <td></td>
		                      </c:otherwise>
		                    </c:choose>
		                  </tr>
		                </c:forEach>
		              </c:forEach>
		              <c:if test="${order.sendDoc}">
		                <tr>
		                  <td>上门送证费用</td>
		                  <td><fmt:formatNumber value="100" type="currency" pattern="￥#.00"/></td>
		                  <td></td>
		                  <td></td>
		                  <td></td>
		                  <td></td>
		                </tr>
		              </c:if>
		              <tr>
		                <td><font><b>应收费用总计</b></font></td>
		                <td><b><fmt:formatNumber value="${order.paymentTotal}" type="currency" pattern="￥#.00"/></b></td>
		                <td></td>
		                <td></td>
		                <td></td>
		                <td></td>
		              </tr>
		            </tbody>
		          </table>		    
			    </div>
			  </div>
			  <div class="row">
			    <div class="span9 offset1">
			    <div style="padding-bottom:10px;"><font color=red>注：文件翻译费为预收，待翻译公司最终报价后由客服人员与您确认</font></div>
			      
			    </div>
			  </div>
			  
			  <br/>
			  <hr/>
			  <br/>
			  <div class="row">
			    <div class="span10 offset1">请通过以下方式付款：</div>
			  </div>
			  <div class="row">
			    <div class="span9 offset2">
			        <input type="radio" value="Alipay" name="payMethod" checked style="vertical-align:middle">
			        <img src="resources/alipay_logo.jpg"/>
			    </div>
			  </div>
			  <br/>
		    </div>	      
	    </div>
	    
	    <br/>
	    <br/>
	    
	    <div class="row">
   		  <div class="span2 offset5">
   		    <button id="payBill" class="btn btn-large btn-block btn-info">立即支付</button>
   		  </div>    		  
   	    </div>
	  </form>
	  
<div id="myModal1" class="modal hide fade" style="margin-top:100px;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<h3 id="myModalLabel">支付</h3>
	</div>
	<div class="modal-body">
		<p>请您在新打开的支付宝支付页面中进行支付，支付完成前请不要关闭该窗口！</p>
		<div class="row">
			<div class="span5">
				<button class="btn" id="success_btn" class="btn btn-primary">已完成支付</button>
				<button class="btn" id="issue_btn" class="btn btn-primary">支付遇到问题</button>
			</div>
		</div>
	</div>
</div>
	  
	  <script>
	  
	  $( document ).ready(function() {
	  	$("#payBill").click(
	  		function(){
	  			$("#myModal1").modal("show");
	  			$("#payBill").attr("disabled","disabled");
	  			$("#payForm").submit();
	  		}	
	  	);
	  	
	  	$("#success_btn").click(
		  		function(){
		  			window.location="orderDetail.do?oId="+${order.id};
		  		}	
		);
	  	
	  	$("#issue_btn").click(
		  		function(){
		  			window.location="orderDetail.do?oId="+${order.id};
		  		}	
		);
	  });
	  	
	  	
	  	
	  	
	    
	  </script>

<%@ include file="footer.jspf"%>	  