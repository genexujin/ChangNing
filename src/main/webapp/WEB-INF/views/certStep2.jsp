<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<title>网上办证</title>

<style type="text/css">
.navbar .nav li a {
/*    border-left: 1px solid rgba(255, 255, 255, 0.75);
    border-right: 1px solid rgba(0, 0, 0, 0.1); */
    font-weight: bold;
    text-align: center;
}

.navbg2 {
    background-repeat: repeat-x;
    border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
    
}

.navbg3 {
    background-color: #006DCC;
    background-image: linear-gradient(to bottom, #0088CC, #0044CC);
    background-repeat: repeat-x;
    /* border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25); */
    color: #FFFFFF;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    border-radius: 6px 6px 6px 6px;
}

.nav li a.clean {
    color: #AAAAAA;
    text-shadow: none;
}

.form-horizontal .controls {
    margin-left: 140px;
}

.form-horizontal .control-label {
    width: 120px;
}

select {
    width: 140px;
}

.thin {
    width: 100px;
}

.border {
    border: 1px solid #CCDBED;
}

.bar-bg {
    background-color: #E5E5E5;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.125) inset;
}

.small-padding-top {
    padding-top: 10px;
}

.text-font {
    font-family:Arial;
    font-size:13px;
    font-weight:normal;
    font-style:normal;
    text-decoration:none;
}

.text-b {
    color:#333333;
}

.text-r {    
    color:#FF0000;
}

.breadcrumb {
    background-color: #FFFFFF;
    margin: 0px;
}

.container {
    height: 100%
}

#progressIndicatorWrapper {
    float: right;
    font-family: verdana,arial,helvetica,sans-serif;
    font-size: 15px;
    margin: 0;
    padding: 6px 0 0;
}


.progressIndicatorLeft {
    background: url("progress_bar_line.gif") no-repeat scroll 0 20px transparent;
    float: left;
    padding: 0 0 10px;
    position: relative;
}

.progressIndicatorLeft ul {
    float: left;
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.progressIndicatorLeft ul li {
    float: left;
    padding: 0 8px 8px;
}

.progressIndicatorRight {
    background: url("progress_bar_line.gif") no-repeat scroll 100% 14px transparent;
    float: left;
    position: absolute;
    right: 0;
    top: 6px;
    width: 5px;
}


.progressIndicatorLeft ul li.active {
    background: url("progress_bar_arrow.gif") no-repeat scroll 50% 20px transparent;
    font-weight: bold;
}

.progressIndicatorLeft ul li.nonVisited {
    color: #9C9C9C;
}

h2 {
    color: #666666;
    font-size: 24px;
    font-weight: normal;
    line-height: 36px;
    margin: 10px 0 15px;
}

h1 {
    color: #666666;
    font-size: 34px;
    font-weight: normal;
    line-height: 36px;
    margin: 10px 0 15px;
}


hr {
    border-width: 2px 0;
    margin: 0px;
}


div.flowstep ol {
    margin: 0;
    padding: 0;
    width: 100%;
    list-style:none outside none;
}


div.flowstep ol li.ago {
    background: url("bg_flow_step.png") no-repeat scroll 100% -32px #CEE2FF;
}

div.flowstep ol li {
    background: url("bg_flow_step.png") no-repeat scroll 100% -64px #E6E6E6;
    float: left;
    font-size: 14px;
    font-weight: bold;
    height: 32px;
    line-height: 32px;
    text-align: center;
    width: 188px;
}

div.flowstep ol li.step {
    background: url("bg_flow_step.png") no-repeat scroll 100% -64px #3164AF;
    color: #FFFFFF;
}

div.flowstep ol li.end {
    background: none repeat scroll 0 0 #E6E6E6;
}

div.flowstep ol li.pass {
    background: url("bg_flow_step.png") no-repeat scroll 100% 0 #CEE2FF;
}

</style>

</head>
<body>

    <div class="container">
      <div class="row">
	    <div class="span6">
	      <h1>&nbsp;长宁公证之窗</h1>
	    </div>
	    
	    <div class="span6 pull-right small-padding-top">
	      <div>
	        <p>
	          <span class="text-font text-b">尊敬的 </span>
	          <span class="text-font text-r">wangxudong1</span>
	          <span class="text-font text-b"> 欢迎登录！ </span>
	          <span class="text-font"><a href="#">[当事人中心]</a>&nbsp; <a href="#">[登出]</a></span>
	          <span class="text-font">|&nbsp;<a href="#">联系我们&nbsp;</a>|&nbsp;<a href="#">常见问题</a></span>
	        </p>
	      </div>
	    </div>
	  </div>
	  
	  <div class="masthead">
        <div class="navbar">
          <div class="navbar-inner navbg3">
            <div class="container">
              <ul class="nav">
                <li><a class="clean" href="#">首页</a></li>
                <li class="active"><a class="clean" href="#">网上办证</a></li>
                <li><a class="clean" href="#">网上预约</a></li>
                <li><a class="clean" href="#">办证指南</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      
      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="#">网上办证</a> <span class="divider">/</span></li>
        <li class="active">选择申办业务</li>
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
				<li class="">上门取证</li>
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
	              <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="username">申请人姓名</label>
			    	  <div class="controls">
			    		<input id="username" name="username" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
		          <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="gender">性别</label>
			    	  <div class="controls">
			    		<SELECT id="gender" name="gender">
							<OPTION selected value="MALE">男</OPTION>
							<OPTION  value="FEMALE">女</OPTION>
						</SELECT>
			    	  </div>
			    	</div>
	    		  </div>
	    		</div>
	    		<div class="row">
	    		  <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="mobile">手机号</label>
			    	  <div class="controls">
			    		<input id="mobile" name="mobile" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	    		  <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="email">邮箱</label>
			    	  <div class="controls">
			    		<input id="email" name="email" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	            </div>
	            <div class="row">
	              <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="address">地址</label>
			    	  <div class="controls">
			    		<input id="address" name="address" type="text"></input>
			    	  </div>
			    	</div>
	    		  </div>
	            </div>
	          
	    	</div>
	    </div>      
      </div>
	  
	  
	  <!-- 结婚公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;结婚公证信息</h5>
	        </div>
	      </div>
      </div>
	  
	  <div class="border">
        <br/>
        <div class="row">
	        <div class="span12">
	          <div class="row">
	            <div class="span6">
	    		    <div class="control-group">
			    	  <label class="control-label" for="JHZ">是否有结婚证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JHZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JHZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div class="span6">提示：若无结婚证则不可办理公证
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span6">
	                <div class="control-group">
			    	  <label class="control-label" for="SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div class="span6">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span6">
	                <div class="control-group">
			    	  <label class="control-label" for="SHJH">是否在沪结婚登记</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="SHJH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="SHJH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	    <hr/>
	    <br/>
	    <div class="row">
    		  <div class="span2 offset5">
    		    <button class="btn btn-large btn-block btn-info" type="submit">下一步</button>
    		  </div>    		  
    	</div>
    	<br/>
	  </div>
      
      </form>
      
      <br>
      <br>
      <br>
      <hr/>
      <br>
      
      <!-- footer -->
      <div class="row">
        <div class="span9">
          <p>
            <span>&nbsp;&nbsp;<a href="#">联系我们</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">服务条款</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">版权声明</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">网站地图</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">合作单位</a></span>            
          </p>
          <p>
            <span>&nbsp;&nbsp;Copyright &copy; 2013 SHANGHAI CHANGNING NOTARY PUBLIC OFFICE All Right Reserved</span>
          </p>
        </div>
        <div class="span3">
          <p><a id="moveTop" name="moveTop">沪ICP备00000000号</a></p>
        </div>
	    
      </div>
      
    </div>
    
	  
	<script src="jquery/jquery-1.10.1.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>