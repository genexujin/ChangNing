<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

	<script src="datepicker/js/bootstrap-datepicker.js"></script>
      
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">输入信息</li>
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
				<li class="">上门送证</li>
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
	              <div class="span5 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="username">申请人姓名</label>
			    	  <div class="controls">
			    		<input id="username" name="username" type="text" value="${currUser.name}"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div id="username_m" class="span4 hide alert alert-error">姓名不能为空
			      </div>
	    		</div>
	    		<div class="row">
		          <div class="span5 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="gender">申请人名字拼音</label>
			    	  <%-- <div class="controls">
			    		<SELECT id="gender" name="gender">
			    		  <c:choose>
			    		    <c:when test="${currUser.gender == 'MALE'}">
								<OPTION selected value="MALE">男</OPTION>
								<OPTION value="FEMALE">女</OPTION>
			    		    </c:when>
			    		    <c:otherwise>
								<OPTION value="MALE">男</OPTION>
								<OPTION selected value="FEMALE">女</OPTION>
			    		    </c:otherwise>
					      </c:choose>
						</SELECT>
			    	  </div> --%>
			    	  <div class="controls">
			    		<input id="username" name="pinyin" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		</div>
	    		<div class="row">
	              <div class="span5 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="address">出生日期</label>
			    	  <div class="controls">
			    		<div data-date-format="mm/dd/yyyy" data-date="now" id="birthDate" class="input-append date">
				          <input type="text" readonly size="16" class="span2" name="birthDate">
				          <span class="add-on"><i class="icon-calendar"></i></span>
			            </div>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <!-- <div id="address_m" class="span4 tiny-pt hide alert alert-error">地址不能为空
			      </div> -->
	            </div>
	    		<div class="row">
	    		  <div class="span5 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="mobile">手机号</label>
			    	  <div class="controls">
			    		<input id="mobile" name="mobile" type="text" value="${currUser.mobile}"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div id="mobile_m" class="span4 tiny-pt hide alert alert-error">
			      </div>
	    		</div>
	    		<div class="row">
	    		  <div class="span5 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="email">邮箱</label>
			    	  <div class="controls">
			    		<input id="email" name="email" type="text" value="${currUser.email}"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div id="email_m" class="span4 hide alert alert-error">
			      </div>
	            </div>
	    	</div>
	    </div>      
      </div>
      <script>
          function prepareBasic() {
        	  validateUsername();
        	  validateMobile();
        	  validateEmail();
        	  //validateAddress();
        	  
        	  $("#username").change(validateUsername);
        	  $("#mobile").change(validateMobile);
        	  $("#email").change(validateEmail);
        	  //$("#address").change(validateAddress);

  		      $('#birthDate').datepicker();
          }
          $(prepareBasic);
          
          function validateUsername() {
        	  var username = $("#username").val();
        	  if (username == '') {
        		  $("#username_m").removeClass("hide");
        		  validBasic = false;
        		  disableGoToStep3Button();
        	  } else {
        		  $("#username_m").addClass("hide");
        		  updateValidBasic();
        		  tryToEnableGoToStep3Button();
        	  }
          }
          
          function validateMobile() {
        	  var mobile = $("#mobile").val();
        	  if (mobile == '') {
        		  $("#mobile_m").removeClass("hide").text("手机号码不能为空");
        		  validBasic = false;
        		  disableGoToStep3Button();
        	  } else if (!mobile.match(/^1(3|4|5|8)[0-9]{9}$/)) {
        		  $("#mobile_m").removeClass("hide").text("手机号码格式不正确！请重新输入！");
        		  validBasic = false;
        		  disableGoToStep3Button();
        	  } else {
        		  $("#mobile_m").addClass("hide").text("");
        		  updateValidBasic();
        		  tryToEnableGoToStep3Button();
        	  }
          }
          
          function validateEmail() {
        	  var email = $("#email").val();
        	  //if (email == '') {
        		//  $("#email_m").removeClass("hide").text("邮箱不能为空");
        		//  validBasic = false;
        		//  disableGoToStep3Button();
        	  //} else if (!email.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)) {
        	  if (email != '' && !email.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)) {
        		  $("#email_m").removeClass("hide").text("邮箱格式不正确！请重新输入！");
        		  validBasic = false;
        		  disableGoToStep3Button();
        	  } else {
        		  $("#email_m").addClass("hide").text("");
        		  updateValidBasic();
        		  tryToEnableGoToStep3Button();
        	  }
          }
          
          function validateAddress() {
        	  var address = $("#address").val();
        	  if (address == '') {
        		  $("#address_m").removeClass("hide");
        		  validBasic = false;
        		  disableGoToStep3Button();
        	  } else {
        		  $("#address_m").addClass("hide");
        		  updateValidBasic();
        		  tryToEnableGoToStep3Button();
        	  }
          }
          
          function updateValidBasic() {
        	  var username = $("#username").val();
        	  var mobile = $("#mobile").val();
        	  var email = $("#email").val();
        	  var address = $("#address").val();
        	  
        	  if (username != '' && validMobile(mobile) && validEmail(email) && address != '')
        		  validBasic = true;
          }
          
          function validEmail(email) {
        	if (email.length != 0 && 
        		(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(email)) {
        		return true;
        	} else {
        		return false;
        	}
          }
          
          function validMobile(mobile) {
			if (mobile.length != 0 && mobile.match(/^1(3|4|5|8)[0-9]{9}$/)) {
				return true;
			} else {
				return false;
			}
          }
      </script>