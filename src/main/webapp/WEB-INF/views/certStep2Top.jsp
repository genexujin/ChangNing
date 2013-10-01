<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
      
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="certStep1.do">网上办证</a> <span class="divider">/</span></li>
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
      <form id="theform" class="form-horizontal" action="certStep3.do" method="POST">
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
			    		<input id="username" name="pinyin" type="text" onkeyup="this.value=this.value.replace(/[^\a-zA-Z ]/g,'')"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		</div>
	    		<div class="row special">
	              <div class="span3 offset1">
	    		    <div class="control-group">
			    	  <label class="control-label" for="address">出生日期</label>
			    	  <div class="controls">
			    	    <SELECT id="bd_year" name="bd_year">
						  <OPTION value="2013">2013</OPTION>
						  <OPTION value="2012">2012</OPTION>
						  <OPTION value="2011">2011</OPTION>
						  <OPTION value="2010">2010</OPTION>
						  <OPTION value="2009">2009</OPTION>
						  <OPTION value="2008">2008</OPTION>
						  <OPTION value="2007">2007</OPTION>
						  <OPTION value="2006">2006</OPTION>
						  <OPTION value="2005">2005</OPTION>
						  <OPTION value="2004">2004</OPTION>
						  <OPTION value="2003">2003</OPTION>
						  <OPTION value="2002">2002</OPTION>
						  <OPTION value="2001">2001</OPTION>
						  <OPTION value="2000">2000</OPTION>
						  <OPTION value="1999">1999</OPTION>
						  <OPTION value="1998">1998</OPTION>
						  <OPTION value="1997">1997</OPTION>
						  <OPTION value="1996">1996</OPTION>
						  <OPTION value="1995">1995</OPTION>
						  <OPTION value="1994">1994</OPTION>
						  <OPTION value="1993">1993</OPTION>
						  <OPTION value="1992">1992</OPTION>
						  <OPTION value="1991">1991</OPTION>
						  <OPTION value="1990">1990</OPTION>
						  <OPTION value="1989">1989</OPTION>
						  <OPTION value="1988">1988</OPTION>
						  <OPTION value="1987">1987</OPTION>
						  <OPTION value="1986">1986</OPTION>
						  <OPTION value="1985">1985</OPTION>
						  <OPTION value="1984">1984</OPTION>
						  <OPTION value="1983">1983</OPTION>
						  <OPTION value="1982">1982</OPTION>
						  <OPTION value="1981">1981</OPTION>
						  <OPTION value="1980">1980</OPTION>
						  <OPTION value="1979">1979</OPTION>
						  <OPTION value="1978">1978</OPTION>
						  <OPTION value="1977">1977</OPTION>
						  <OPTION value="1976">1976</OPTION>
						  <OPTION value="1975">1975</OPTION>
						  <OPTION value="1974">1974</OPTION>
						  <OPTION value="1973">1973</OPTION>
						  <OPTION value="1972">1972</OPTION>
						  <OPTION value="1971">1971</OPTION>
						  <OPTION value="1970">1970</OPTION>
						  <OPTION value="1969">1969</OPTION>
						  <OPTION value="1968">1968</OPTION>
						  <OPTION value="1967">1967</OPTION>
						  <OPTION value="1966">1966</OPTION>
						  <OPTION value="1965">1965</OPTION>
						  <OPTION value="1964">1964</OPTION>
						  <OPTION value="1963">1963</OPTION>
						  <OPTION value="1962">1962</OPTION>
						  <OPTION value="1961">1961</OPTION>
						  <OPTION value="1960">1960</OPTION>
						  <OPTION value="1959">1959</OPTION>
						  <OPTION value="1958">1958</OPTION>
						  <OPTION value="1957">1957</OPTION>
						  <OPTION value="1956">1956</OPTION>
						  <OPTION value="1955">1955</OPTION>
						  <OPTION value="1954">1954</OPTION>
						  <OPTION value="1953">1953</OPTION>
						  <OPTION value="1952">1952</OPTION>
						  <OPTION value="1951">1951</OPTION>
						  <OPTION value="1950">1950</OPTION>
						  <OPTION value="1949">1949</OPTION>
						</SELECT>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div class="span1">
	    		    	<SELECT id="bd_month" name="bd_month">
						  <OPTION value="1">1</OPTION>
						  <OPTION value="2">2</OPTION>
						  <OPTION value="3">3</OPTION>
						  <OPTION value="4">4</OPTION>
						  <OPTION value="5">5</OPTION>
						  <OPTION value="6">6</OPTION>
						  <OPTION value="7">7</OPTION>
						  <OPTION value="8">8</OPTION>
						  <OPTION value="9">9</OPTION>
						  <OPTION value="10">10</OPTION>
						  <OPTION value="11">11</OPTION>
						  <OPTION value="12">12</OPTION>
						</SELECT>
	    		  </div>
	    		  <div class="span1" style="margin-left: 40px">
						<SELECT id="bd_date" name="bd_date">
						  <OPTION value="1">1</OPTION>
						  <OPTION value="2">2</OPTION>
						  <OPTION value="3">3</OPTION>
						  <OPTION value="4">4</OPTION>
						  <OPTION value="5">5</OPTION>
						  <OPTION value="6">6</OPTION>
						  <OPTION value="7">7</OPTION>
						  <OPTION value="8">8</OPTION>
						  <OPTION value="9">9</OPTION>
						  <OPTION value="10">10</OPTION>
						  <OPTION value="11">11</OPTION>
						  <OPTION value="12">12</OPTION>
						  <OPTION value="13">13</OPTION>
						  <OPTION value="14">14</OPTION>
						  <OPTION value="15">15</OPTION>
						  <OPTION value="16">16</OPTION>
						  <OPTION value="17">17</OPTION>
						  <OPTION value="18">18</OPTION>
						  <OPTION value="19">19</OPTION>
						  <OPTION value="20">20</OPTION>
						  <OPTION value="21">21</OPTION>
						  <OPTION value="22">22</OPTION>
						  <OPTION value="23">23</OPTION>
						  <OPTION value="24">24</OPTION>
						  <OPTION value="25">25</OPTION>
						  <OPTION value="26">26</OPTION>
						  <OPTION value="27">27</OPTION>
						  <OPTION value="28">28</OPTION>
						  <OPTION value="29">29</OPTION>
						  <OPTION value="30">30</OPTION>
						  <OPTION value="31">31</OPTION>
						</SELECT>
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