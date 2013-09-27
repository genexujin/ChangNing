<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li class="active">订单详情</li>
      </ul>
      <br/>
      
      <c:choose>
        <c:when test="${sessionScope['LOGIN_USER'].admin or sessionScope['LOGIN_USER'].staff}">
          <div class="row">
			<div class="span9">
			 <c:choose>
        		<c:when test="${order.orderStatus == 'PAID'}">
			  		<a class="btn" href="<c:url value="/orderAccept.do?oId=${order.id}"/>">确认受理</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'PAID' or order.orderStatus == 'ACCEPTED'}">				
			  		<a href="requestExtraDocs.do?oId=${order.id}" class="btn">要求补充材料</a>
			    </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'PAID' or order.orderStatus == 'ACCEPTED'}">	
			 	 	<a href="requestExtraPayment.do?oId=${order.id}" class="btn">要求客户附加费用</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'CANCEL_REQUESTED'}">	
			  		<a href="orderRefund.do?oId=${order.id}" class="btn">退款</a>
			   </c:when>
			 </c:choose>
			  <a href="generateForm.do?oId=${order.id}" class="btn">申请书下载</a>
			  <a href="orderQuery.do" class="btn">返回</a>
			</div>
	      </div>
        </c:when>
        <c:otherwise>
          <div class="row">
			<div class="span9">
			 <c:choose>
        		<c:when test="${order.orderStatus != 'CANCEL_REQUESTED' and order.orderStatus!='FINISHED'}">
			  		<a href="orderCancel.do?oId=${order.id}" class="btn">申请撤销</a>
			   </c:when>
			 </c:choose>
			  <c:choose>
        		<c:when test="${order.orderStatus == 'SUBMITTED' or order.orderStatus=='ADD_CHARGE'}">
			  		<a href="payment.do?oId=${order.id}" target="_blank" class="btn">支付</a>
			   </c:when>
			 </c:choose>			
			  <a href="orderQuery.do" class="btn">返回</a>
			</div>
      	  </div>
        </c:otherwise>
      </c:choose>
      
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
            <div class="span10 offset1"><font><strong>${order.orderStatus.text}</strong></font> </div>
            <c:choose>
            	<c:when test="${order.accepter!=null}">
            		<div class="span10 offset1"><font><strong>受理人： ${order.accepter.name}</strong></font>            
            		</div>
            	</c:when>
            </c:choose>
            
        <c:if test="${not empty interactions}">
          
              <ul>
              <c:forEach items="${interactions}" var="interaction">
                <li>
                ${interaction.interactionContent}&nbsp;&nbsp;
                <c:choose>
                  <c:when test="${interaction.interactionType == 'ADD_DOCS'}">
                    <a href="addDocs.do?oId=${order.id}" class="btn">补充材料</a>
                  </c:when>
                  <c:when test="${interaction.interactionType == 'ADD_PAYMENT'}">
                    <a href="extraPayment.do?oId=${order.id}&pId=${interaction.extraData}" class="btn">支付</a>
                  </c:when>
                </c:choose>
                </li>
              </c:forEach>
              </ul>
           
        </c:if>
      </div>
      <br>
      </div>
     
      
      
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;基本信息查看</h5>
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
	                <td style="width:100px">${order.readableId}</td>
	                <td style="width:120px"><b>公证号</b></td>
	                <td style="width:100px">${order.backendNotaryId}</td>
	              </tr>
	              <tr>
	                <td style="width:120px"><b>订单日期</b></td>
	                <td style="width:100px"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
	                <td style="width:120px"><b>订单状态</b></td>
	                <td style="width:100px">${order.orderStatus.text}</td>
	              </tr>
	              <tr>
	                <td><b>前往国家或地区</b></td>
	                <td>${order.destination.text}</td>
	                <td><b>翻译语言</b></td>
	                <td>${order.translationLanguage.text}</td>
	              </tr>
	              <tr>
	                <td><b>办证用途</b></td>
	                <td>${order.certificatePurpose.text}</td>
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
	                <td>${order.requestorName}</td>
	                <td><b>姓名拼音</b></td>
	                <td>${order.requestorNamePinyin}</td>
	              </tr>
	              <tr>
	                <td><b>出生日期</b></td>
	                <td><fmt:formatDate value="${order.requestorBirthDate}" pattern="yyyy-MM-dd"/></td>
	                <td><b>手机号</b></td>
	                <td>${order.requestorMobile}</td>
	              </tr>
	              <tr>
	                <td><b>邮箱</b></td>
	                <td>${order.requestorEmail}</td>
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
	              <tr>
	                <td colspan="4"><b>${form.formName}公证</b></td>
	              </tr>
	              <c:choose>
	                <c:when test="${form.qsgx}">
	                  <c:forEach items="${form.formItems}" var="item">
	                    <tr>
	                      <c:choose>
	                        <c:when test="${item.relativeInfo == null}">
	                          <td style="width:120px"><b>${item.itemName}</b></td>
	                          <td style="width:100px">${item.text}</td>
	                          <td style="width:120px"></td>
	                          <td style="width:100px"></td>
	                        </c:when>
	                        <c:otherwise>
	                          <td style="width:120px"><b>和申请人关系</b></td>
	                          <td style="width:100px">${item.relativeInfo.relativeType.text}</td>
	                          <td style="width:120px"><b>关系人姓名</b></td>
	                          <td style="width:100px">${item.relativeInfo.relativeName}</td>
	                        </c:otherwise>
	                      </c:choose>
	                    </tr>
	                  </c:forEach>
	                </c:when>
	                <c:otherwise>
	                  <tr>
	                    <c:forEach items="${form.formItems}" var="item" varStatus="counter">
	                      <c:if test="${counter.index % 2 == 0}"></tr><tr></c:if>
	                      <td style="width:120px"><b>${item.itemName}</b></td>
	                      <td style="width:100px">${item.text}</td>
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
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;证件信息及照片查看</h5>
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
	              <li>${docs.extraDocNames}</li>
	          </c:forEach>
	        </ul>
            </div>
          </div>
        </c:if>
        <div class="row">
          <div class="span5 offset1">
            <c:if test="${not empty order.docs}">
              <a href="getFile/${order.id}/allInOne.do" class="btn">下载</a>
            </c:if>
            <a href="addDocs.do?oId=${order.id}" class="btn">补充材料</a>
          </div>
        </div>
        <br/>
      </div>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;上门送证情况</h5>
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
                  <td>${order.sendAddress}</td>
                </tr>
                <tr>
                  <td><b>送证时间</b></td>
                  <td>${order.sendDate.text}</td>
                </tr>
              </c:if>
            </table>
          </div>
        </div>
      </div>
      
      <div class="bar-bg">
        <div class="row">
          <div class="span12 navbg2">
            <div class="row">
              <div class="span9">
                <h5>&nbsp;&nbsp;&nbsp;&nbsp;收费明细</h5>
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


<%@ include file="../footer.jspf"%>


