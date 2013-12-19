<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

<!--       <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li class="active">订单详情</li>
      </ul> -->
 <div class="row">
        <div class="span12 content_title">
          <h2>订单详情</h2>
        </div>
</div>
<div class="workarea">
     
      <div class="row" style="padding-top:5px;">
      <c:choose>
        <c:when test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
          
			<div class="span9">
			 <c:choose>
        		<c:when test="${order.orderStatus == 'PAID'}">
			  		<a class="btn btn-warning" href="<c:url value="/orderAccept.do?oId=${order.id}"/>">确认受理</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'PAID' or order.orderStatus == 'ACCEPTED'}">				
			  		<a href="requestExtraDocs.do?oId=${order.id}" class="btn btn-primary">要求补充材料</a>
			    </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'PAID' or order.orderStatus == 'ACCEPTED'}">	
			 	 	<a href="requestExtraPayment.do?oId=${order.id}" class="btn btn-primary">要求客户附加费用</a>
			   </c:when>
			 </c:choose>
			 <c:choose>
        		<c:when test="${order.orderStatus == 'PAYING' or order.orderStatus =='ADD_CHARGE'}">
			 	 	<a id="checkPayBill" class="btn btn-primary">人工确认收款</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${hasPaid}">	
			  		<a href="orderRefund.do?oId=${order.id}" class="btn btn-primary">退款</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'CANCEL_REQUESTED'}">	
			  		<a href="#" class="btn btn-primary" onclick="confirmCancel(${order.id})">确认撤销</a>
			   </c:when>
			 </c:choose>
			  
			  <a href="checkChatHistory.do?mobile=${order.requestorMobile}" class="btn btn-primary" target="_blank">客服记录</a>
			  <a href="generateForm.do?oId=${order.id}" class="btn btn-primary">申请书下载</a>
			  <a href="orderQuery.do" class="btn btn-success">返回</a>
			</div>
			
	      
        </c:when>
        <c:otherwise>
          
			<div class="span9">
			 <c:choose>
        		<c:when test="${order.orderStatus != 'CANCEL_REQUESTED' and order.orderStatus!='FINISHED'and order.orderStatus!='CANCELLED'}">
			  		<a href="orderCancel.do?oId=${order.id}" class="btn btn-primary">申请撤销</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'SUBMITTED' or order.orderStatus=='PAYING'}">
			  		<a href="payment.do?oId=${order.id}" target="_blank" class="btn btn-primary">支付</a>
			   </c:when>
			 </c:choose>			
			  <a href="orderQuery.do" class="btn btn-success">返回</a>
			</div>		
      	 
        </c:otherwise>
      </c:choose>
      		
       </div>
       <div class="row" style="padding-top:5px;">
       		<div class="span6">
      			<a href="#section_basic">[基本信息]</a>
				<a href="#section_doc">[公证材料]</a>
				<a href="#section_bill">[收费明细]</a>
				<a href="#section_pay">[付款记录]</a>
				<a href="#section_history">[操作历史]</a>
			</div>
       </div>
      <br/>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;订单当前状态</h5>
              </div>             
            </div>
          </div>
        </div>
      </div>
      <div class="border">
        <br/>
        <div class="row">
            <div class="span10 offset1"><font color='orange'><strong><c:out value="${order.orderStatus.text}"></c:out></strong></font> </div>
            <c:choose>
            	<c:when test="${order.accepter!=null}">
            		<div class="span10 offset1"><font color='blue'><strong>受理人： <c:out value="${order.accepter.name}"></c:out></strong></font>            
            		</div>
            	</c:when>
            </c:choose>
            <c:choose>
            	<c:when test="${order.cancelNote!=null and order.orderStatus=='CANCEL_REQUESTED'}">
            		<div class="span10 offset1"><font color='blue'><strong>撤销理由： <c:out value="${order.cancelNote}"></c:out></strong></font>            
            		</div>
            	</c:when>
            </c:choose>
            
        <c:if test="${not empty interactions}">
          
              
              <c:forEach items="${interactions}" var="interaction">
               
                
                <c:choose>
                  <c:when test="${order.orderStatus=='EXTRADOC_REQUESTED' and interaction.interactionType == 'ADD_DOCS'}">
                   	<div class="span10 offset1 alert alert-block">
	                   	<c:out value="${interaction.interactionContent}"></c:out> 
	                    <a href="addDocs.do?oId=${order.id}" class="btn btn-primary">补充材料</a>
                    </div>
                  </c:when>
                  <c:when test="${order.orderStatus=='ADD_CHARGE' and interaction.interactionType == 'ADD_PAYMENT'}">
                    <div class="span10 offset1 alert alert-block">
                    	<c:out value="${interaction.interactionContent}"/>
                    	<a id="payBill" href="extraPayment.do?oId=${order.id}&pId=${interaction.extraData}" target="_blank" class="btn btn-primary medium">支付</a>
                    </div>
                  </c:when>
                </c:choose>
                
              </c:forEach>
                      
        </c:if>
      </div>
      <br>
      </div>
     
      
      
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5 id="section_basic">&nbsp;&nbsp;&nbsp;&nbsp;申办基本信息</h5>
              </div>
            </div>
          </div>
        </div>
        
      </div>
      
      <div class="border">
        <br/>
        <div class="row">
          <div class="span10 offset1">
	          <table class="table td-no-border">
	            <tbody>
	              <tr>
	                <td style="width:120px"><b>申办号</b></td>
	                <td style="width:100px"><font color='blue'><strong>${order.readableId}</strong></font></td>
	                <td style="width:120px"><b>公证号</b></td>
	                <td style="width:100px"><font color='blue'><strong><c:out value="${order.backendNotaryId}"/></strong></font></td>
	              </tr>
	              <tr>
	                <td style="width:120px"><b>订单日期</b></td>
	                <td style="width:100px"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
	                <td style="width:120px"><b>订单状态</b></td>
	                <td style="width:100px">${order.orderStatus.text}</td>
	              </tr>
	              <tr>
	                <td><b>前往国家或地区</b></td>
	                <td><c:out value="${order.destination.text}"></c:out></td>
	                <td><b>翻译语言</b></td>
	                <td><c:out value="${order.translationLanguage.text}"></c:out></td>
	              </tr>
	              <tr>
	                <td><b>办证用途</b></td>
	                <td><c:out value="${order.certificatePurpose.text}"></c:out>
	                  <c:if test="${order.certificatePurpose == 'OTHER'}">
	                    <c:out value=": ${order.certCustomPurpose}"></c:out>
	                  </c:if>
	                </td>
	                <td><b>是否认证</b></td>
	                <td>
	                  <c:choose>
	                    <c:when test="${order.needVerify}">是</c:when>
	                    <c:otherwise>否</c:otherwise>
	                  </c:choose>
	                </td>
	              </tr>
	              <tr>
	                <td><b>申请人姓名</b></td>
	                <td><c:out value="${order.requestorName}"></c:out></td>
	                <td><b>姓名拼音</b></td>
	                <td><c:out value="${order.requestorNamePinyin}"></c:out></td>
	              </tr>
	              <tr>
	                <td><b>出生日期</b></td>
	                <td><fmt:formatDate value="${order.requestorBirthDate}" pattern="yyyy-MM-dd"/></td>
	                <td><b>手机号</b></td>
	                <td><c:out value="${order.requestorMobile}"></c:out></td>
	              </tr>
	              <tr>
	                <td><b>邮箱</b></td>
	                <td><c:out value="${order.requestorEmail}"></c:out></td>
	                <td><b></b></td>
	                <td></td>
	              </tr>
	            </tbody>
	          </table>
          </div>
        </div>
        <div class="row">
          <div class="span10 offset1">
            <c:forEach items="${order.forms}" var="form" >
              <table class="table table-bordered">
	            <tbody>
	              <tr class="info">
	                <td colspan="4"><b>${form.formName}公证录入信息</b></td>
	              </tr>
	              <c:choose>
	                <c:when test="${form.qsgx}">
	                  <c:forEach items="${form.formItems}" var="item">
	                    <tr>
	                      <c:choose>
	                        <c:when test="${item.relativeInfo == null}">
	                          <td style="width:120px"><b><c:out value="${item.itemName}"></c:out></b></td>
	                          <td style="width:100px"><c:out value="${item.text}"></c:out></td>
	                          <td style="width:120px"></td>
	                          <td style="width:100px"></td>
	                        </c:when>
	                        <c:otherwise>
	                          <td style="width:120px"><b>和申请人关系</b></td>
	                          <td style="width:100px"><c:out value="${item.relativeInfo.relativeType.text}"></c:out></td>
	                          <td style="width:120px"><b>关系人姓名</b></td>
	                          <td style="width:100px"><c:out value="${item.relativeInfo.relativeName}"></c:out></td>
	                        </c:otherwise>
	                      </c:choose>
	                    </tr>
	                  </c:forEach>
	                </c:when>
	                <c:otherwise>
	                  <tr>
	                    <c:forEach items="${form.formItems}" var="item" varStatus="counter">
	                      <c:if test="${counter.index % 2 == 0}"></tr><tr></c:if>
	                      <td style="width:120px"><b><c:out value="${item.itemName}"></c:out></b></td>
	                      <td style="width:100px"><c:out value="${item.text}"></c:out></td>
	                    </c:forEach>
	                    <c:if test="${form.formItemsSize % 2 == 1}"><td></td><td></td></c:if>
	                  </tr>
	                </c:otherwise>
	              </c:choose>
	            </tbody>
	          </table>
            </c:forEach>
          </div>
        </div>
      </div>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5 id="section_doc">&nbsp;&nbsp;&nbsp;&nbsp;上传材料及证件</h5>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="border">
        <br/>
        <div class="row">
          <div class="span5 offset1">
<%--             <b>基本材料：</b>&nbsp;&nbsp;&nbsp;&nbsp;<a href="getFile/${order.id}/allInOne.do" class="btn">下载</a>
			<ul>
	          <c:forEach items="${allInOneDocs}" var="docs" >
	            <c:forEach items="${docs}" var="doc" >
	              <li>${doc.docName}</li>
	            </c:forEach>
	          </c:forEach>
	        </ul> --%>
	        <b>所需上传材料：</b>
	        <ul>
	          <c:forEach items="${allDocs}" var="docs" >
	            <c:forEach items="${docs}" var="doc" >
	              <li>${doc.docName}</li>
	            </c:forEach>
	          </c:forEach>
	        </ul>
          </div>
<%--           <div class="span5 offset1">
            <table class="table td-no-border">
              <c:forEach items="${order.aloneDocs}" var="doc" varStatus="counter">
                <tr>
                  <td style="width:120px"><b>${doc.docName}</b></td>
                  <td style="width:100px"><a href="getFile/${order.id}/${doc.docFileName}.do" class="btn">下载</a></td>
                </tr>
              </c:forEach>
            </table>
          </div> --%>
        </div>
        <c:if test="${not empty order.extraDocs}">
          <div class="row">
            <div class="span5 offset1">
              <b>额外要求补充的材料：</b>
              <ul>
	          <c:forEach items="${order.extraDocs}" var="docs" >
	              <li><c:out value="${docs.extraDocNames}"></c:out></li>
	          </c:forEach>
	        </ul>
            </div>
          </div>
        </c:if>
        <c:if test="${not empty order.uploadNote}">
	        <div class="row">
	          <div class="span2 offset1">
	            <b>用户上传时的备注：</b>
	          </div>
	          <div class="span5"><c:out value="${order.uploadNote}"></c:out>
	          </div>
	        </div>
        </c:if>
        <br/>
        <div class="row">
          <div class="span5 offset1">
            <c:if test="${not empty order.docs}">
              <a href="getFile/${order.id}/allInOne.do" class="btn btn-success">打包下载</a>
              <a href="getPDF/${order.id}/allInOne.do" class="btn btn-success">PDF下载</a>
            </c:if>
            <a href="addDocs.do?oId=${order.id}" class="btn btn-primary">补充材料</a>
          </div>
        </div>
        <br/>
      </div>
      <c:if test="${not order.skipSendDoc}">
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;上门送证</h5>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="border">
        <br/>
        <div class="row">
          <div class="span8 offset1">
            <table class="table td-no-border">
              <tr>
                <td style="width:120px"><b>是否需要上门送证</b></td>
                <td style="width:100px">
                  <c:choose>
	                <c:when test="${order.sendDoc}">是</c:when>
	                <c:otherwise>否</c:otherwise>
	              </c:choose>
                </td>
              </tr>
              <c:if test="${order.sendDoc}">
                <tr>
                  <td><b>联系地址</b></td>
                  <td><c:out value="${order.sendAddress}"></c:out></td>
                </tr>
                <tr>
                  <td><b>送证时间</b></td>
                  <td><c:out value="${order.sendDate.text}"></c:out></td>
                </tr>
              </c:if>
            </table>
          </div>
        </div>
      </div>
      </c:if>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5 id="section_bill">&nbsp;&nbsp;&nbsp;&nbsp;收费明细</h5>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="border">
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
      </div>
      <div class="border">
	      	<div class="bar-bg">
		        <div class="row">
		          <div class="span12 navbg2">
		            <div class="row">
		              <div class="span9">
		                <h5 id="section_pay">&nbsp;&nbsp;&nbsp;&nbsp;付款及退款</h5>
		              </div>
		            </div>
		          </div>
		        </div>
	      </div>
	       <br/>
          <div class="row">
		    <div class="span10" style="margin-left:30px;">
	      <table class="table table-striped table-bordered table-hover" style="width:920px;">
	            <thead>
	              <tr>	                
	                <th>付款内容</th>
	                <th>状态</th>
	                <th>付款金额</th>
	                <th>付款日期</th>
	                <th>内部付款号</th>
	                <th>支付宝交易号</th>
	                <th>退款理由</th>
	                <th>退款金额</th>
	                <th>退款日期</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach items="${order.payments}" var="payment" >	                
	                  <tr>
	                    <td><c:out value="${payment.title}"></c:out></td>
	                    <td><font color='blue'><c:out value="${payment.status.text}"></c:out></font></td>
	                    <td><fmt:formatNumber value="${payment.paymentTotal}" type="currency" pattern="￥#.00"/></td>
	                    <td><c:out value="${payment.paymentDate}"></c:out></td>
	                    <td><c:out value="${payment.orderTxnNo}"></c:out></td>
	                    <td><c:out value="${payment.alipayTxnNo}"></c:out>
	                    </td>
	                    <td><c:out value="${payment.refundReason}"></c:out></td>
	                    <td><fmt:formatNumber value="${payment.refundTotal}" type="currency" pattern="￥#.00"/></td>
	                    <td><c:out value="${payment.refundDate}"></c:out></td>
	                  </tr>	                
	              </c:forEach>              
	              
	            </tbody>
	          </table>
	      </div>	      
	      </div>
	      <div class="border">
	      	<div class="bar-bg">
		        <div class="row">
		          <div class="span12 navbg2">
		            <div class="row">
		              <div class="span9">
		                <h5 id="section_history">&nbsp;&nbsp;&nbsp;&nbsp;订单历史</h5>
		              </div>
		            </div>
		          </div>
		        </div>
	      </div>
	      </div>
	       <br/>
	      <div class="row">
		    <div class="span10 offset1">
	      <table class="table table-striped table-bordered table-hover">
	            <thead>
	              <tr>	                
	                <th>操作人</th>
	                <th>时间</th>
	                <th>操作</th>	                
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach items="${order.histories}" var="history" >	                
	                  <tr>
	                    <td><c:out value="${history.user.name}"></c:out></td>
	                    <td><font color='blue'><c:out value="${history.operationDate}"></c:out></font></td>
	                    <td><c:out value="${history.operation}"></c:out></td>	                   
	                  </tr>	                
	              </c:forEach>              
	              
	            </tbody>
	          </table>
	      </div>	      
	      </div>
      </div>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5 id="section_bill">&nbsp;&nbsp;&nbsp;&nbsp;备注</h5>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="border">
		<br />
		<div class="row">
		  <div class="span8 offset1">
			<textarea rows="5" cols="150" name="order_note"
						style="width: 700px;" placeholder="如有关于订单的特殊情况，可在此说明" maxLength="200"></textarea>
		  </div>
		</div>
		<br />
	  </div>
 </div>
      
<div id="myModal1" class="modal hide fade" style="margin-top:100px;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<h3 id="myModalLabel">支付</h3>
	</div>
	<div class="modal-body">
		<p>如果确认该款项已支付，请输入该笔交易的支付宝交易号：</p>
		<label class="control-label" for="sendAddress">支付宝交易号</label>
		<div class="controls">
				    	<input id="aliTxnNo" name="aliTxnNo" type="text"></input>
		</div>
		<div class="row">
			<div class="span5">
				<button class="btn" id="success_btn" class="btn btn-primary">确认已支付</button>				
			</div>
		</div>
	</div>
</div>
      
      <script>
      $(document).ready(
    	function(){
	  	  	$("#checkPayBill").click(
	  	  		function(){
	  	  			$("#myModal1").modal("show");  	  			  	  			
	  	  		});
  	  		}
  	  	);
       
  	  	
  	  	$("#success_btn").click(
		  		function(){
		  			window.location="manualConfirmPayment.do?oId="+"${order.id}"+"&aliTxNo="+$("#aliTxnNo").val();
		  		}	
		);
    
      	function confirmCancel(oid){
      		var confirmed = window.confirm("您确认要撤销该订单吗？");
      		if(confirmed){
      			window.location="confirmCancel.do?oId="+oid;
      		}
      	}
      
      </script>


<%@ include file="../footer.jspf"%>


