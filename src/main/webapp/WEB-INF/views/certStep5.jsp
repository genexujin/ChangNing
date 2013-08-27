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
	  <form class="form-horizontal" action="payment.do" method="POST">
	  
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
		      <div class="span5 offset1">尊敬的用户，您的支付费用为：<font color=red><fmt:formatNumber value="${order.paymentTotal}" type="currency" pattern="￥#.00"/></font>元  人民币。</div>
		  </div>
		  
		  <br/>
		  <hr/>
		  <br/>
		  
		  <div class="row">
		    <div class="span5 offset1">费用明细</div>
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
		    <div class="span5 offset1">
		      <input id="agreement" type="checkbox"> 同意《<a href="#">受理告知协议</a>》
		    </div>
		  </div>
		  
		  <br/>
		  <hr/>
		  <br/>
		  <div class="row">
		    <div class="span10 offset1">您可以通过以下方式进行在线支付。</div>
		  </div>
		  <div class="row">
		    <div class="span9 offset2">
		        <input type="radio" value="Alipay" name="payMethod" checked style="vertical-align:middle">
		        <img src="resources/alipay_logo.jpg"/>
		    </div>
		  </div>
		  <br/>
	    </div>
	    
	    <br/>
	    <br/>
	    
	    <div class="row">
   		  <div class="span2 offset5">
   		    <button id="payBill" class="btn btn-large btn-block btn-info" type="submit" disabled>立即支付</button>
   		  </div>    		  
   	    </div>
	  </form>
	  
	  <script>
	    function preparePayment() {
	    	$("#agreement").change(function (event) {
	    		if (event.target.checked == true) {
	    			$("#payBill").removeAttr("disabled");
	    		} else {
	    			$("#payBill").attr("disabled", "disabled");
	    		}
	    	});
	    }
	    $(preparePayment);
	  </script>

<%@ include file="footer.jspf"%>	  