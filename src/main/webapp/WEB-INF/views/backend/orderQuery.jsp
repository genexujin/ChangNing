<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="../header.jspf"%>

      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li class="active">订单查询</li>
      </ul>
      <br/>
      
      <div class="row">
        <div class="span2 well">
            <ul class="nav nav-list">
              <li><h5>我的菜单</h5>
              <li class="active"><a href="#">订单查询</a></li>
              <li><a href="#">附加费用</a></li>
            </ul>
        </div>
        
        <div class="span9" style="margin-left: 40px;">
          <form class="form-horizontal" action="" method="POST">
            <div class="row">
    		  <div class="span5">
    		    <div class="control-group">
		    	  <label class="control-label" for="query_str">申办号</label>
		    	  <div class="controls">
		    	    <input name="query_str" type="text"></input>
		    	  </div>
		    	</div>
    		  </div>
    		  <div class="span2">
    		  </div>
    		  <div class="span1">
    		    <button class="btn btn-block" type="submit">查询</button>
    		  </div>
    		</div>
    		
    		<div class="row">
    		  <table class="table table-striped table-bordered table-hover">
	            <thead>
	              <tr>
	                <th>申办号</th>
	                <th>公证号</th>
	                <th>时间</th>
	                <th>申办人</th>
	                <th>总费用</th>
	                <th>已支付</th>
	                <th>处理状态</th>
	              </tr>
	            </thead>
	            <tbody>
	              <c:forEach items="${orders}" var="order" >
	                <tr>
	                  <td>${order.readableId}</td>
	                  <td></td>
	                  <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
	                  <td>${order.requestorName}</td>
	                  <td><fmt:formatNumber value="${order.paymentTotal}" type="currency" pattern="￥#0.00"/></td>
	                  <td><fmt:formatNumber value="${order.paymentPaid}" type="currency" pattern="￥#0.00"/></td>
	                  <td>${order.orderStatus}</td>
	                </tr>
	              </c:forEach>
	            </tbody>
	          </table>
    		</div>
    		
    		<div class="pagination pagination-right">
			  <ul>
			    <c:choose>
			      <c:when test="${left < 1}">
			        <li class="disabled"><a href="#">«</a></li>
			      </c:when>
			      <c:otherwise>
			        <li><a href="<c:url value="/orderQuery.do?pn=${left}"/>">«</a></li>
			      </c:otherwise>
			    </c:choose>
			    <c:forEach begin="${loopBegin}" end="${loopEnd}" varStatus="loop">
			      <c:choose>
			        <c:when test="${(loop.index) == currPage}">
			          <li class="active"><a href="#">${loop.index}</a></li>
			        </c:when>
			        <c:otherwise>
			          <li><a href="<c:url value="/orderQuery.do?pn=${loop.index}"/>">${loop.index}</a></li>
			        </c:otherwise>
			      </c:choose>
			    </c:forEach>
			    <c:choose>
			      <c:when test="${right > pageCount}">
			        <li class="disabled"><a href="#">»</a></li>
			      </c:when>
			      <c:otherwise>
			        <li><a href="<c:url value="/orderQuery.do?pn=${right}"/>">»</a></li>
			      </c:otherwise>
			    </c:choose>
			  </ul>
			</div>
    		
          </form>
        </div>
      </div>


<%@ include file="../footer.jspf"%>

