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
				<li class="ago">上门送证</li>
				<li class="step">确认订单</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  <br>
<div class="workarea">

<div class="border">
	    <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9 offset1" style="padding-bottom:5px;">
                <h5 style="color:blue;font-weight:bold;">请在付款前确认您的订单信息、阅读并确认本页底部的受理告知！</h5>
                
              </div>             
            </div>
          </div>
        </div>
        </div>
 
    
   
	 
	  <form class="form-horizontal" action="certStep5.do" method="POST" id="payForm">
	    <div class="workarea">
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
        
        <c:if test="${not empty order.uploadNote}">
	        <div class="row">
	          <div class="span2 offset1">
	            <b>上传备注：</b>
	          </div>
	          <div class="span5"><c:out value="${order.uploadNote}"></c:out>
	          </div>
	        </div>
        </c:if>
        <br/>
         <c:if test="${not empty order.docs}">
        <div class="row">
          <div class="span5 offset1">
           
              <a href="getFile/${order.id}/allInOne.do" class="btn btn-success">打包下载查看</a>
              <a href="getPDF/${order.id}/allInOne.do" class="btn btn-success">PDF下载查看</a>
                     
          </div>
        </div>
        <br/>
        </c:if> 
        
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
       <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5 id="section_bill">&nbsp;&nbsp;&nbsp;&nbsp;受理告知</h5>
              </div>
            </div>
          </div>
        </div>
      </div>	      
	  
	<div class="border">
	    <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9 offset1" style="padding-bottom:5px;">
                <h5 style="color:blue;font-weight:bold;">我处将收取您提交的公证申请，您付款并递交材料齐全后，我处会于五个工作日内出具公证书。
                声明书和身份证复印件公证必需要本人持上传的所有材料原件来领取，其他公证可以凭短信和上传的所有材料原件代领。如果提交申请后七日内未补充材料或者未付款，此公证申请将被撤销。</h5>
                <input id="agreement"  type="checkbox" style="vertical-align: top;"> <strong>已阅读受理告知</strong>
              </div>             
            </div>
          </div>
        </div>
        </div>
     </div>
     </form>
     </div>
       
	    <br/>
	    <br/>
	    <div class="row">
   		  <div class="span2 offset5">
   		    <button id="payBill" class="btn btn-large btn-block btn-info" disabled>确认并支付</button>
   		  </div>    		  
   	    </div>
	  
	  
<div id="myModal1" class="modal hide fade" style="margin-top:100px;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<h3 id="myModalLabel">您确认已阅读受理通知并要开始支付吗？</h3>
	</div>
	<div class="modal-body">
		<p></p>
		<div class="row">
			<div class="span5">
				<button class="btn" id="success_btn" class="btn btn-primary">确认</button>
				<button class="btn" id="issue_btn" class="btn btn-primary">取消</button>
			</div>
		</div>
	</div>
</div>
	  
	  <script>
	  
	  $( document ).ready(function() {
	  	$("#payBill").click(
	  		function(event){
	  			event.preventDefault();
	  			$("#myModal1").modal("show");	  				  			
	  		}	
	  	);
	  	
	  	$("#success_btn").click(
		  		function(){
		  			$("#payForm").submit();
		  		}	
		);
	  	
	  	$("#issue_btn").click(
		  		function(){
		  			$("#myModal1").modal("hide");
		  		}	
		);
	  });
	  	
	  	
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