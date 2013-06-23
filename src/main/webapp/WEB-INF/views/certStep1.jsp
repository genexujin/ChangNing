<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
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
				<li class="step">选择申办业务</li>
				<li class="">输入信息</li>
		        <li class="">上传资料</li>
				<li class="">上门取证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>

      <br>
	  
	  <div class="bar-bg">
      <div class="row">
        <div class="span12 navbg2">
          <div class="row">
            <div class="span9">
              <h5>&nbsp;&nbsp;&nbsp;&nbsp;选择申办业务</h5>
            </div>
            <div class="span3 pull-right">
              <h5>预收费用：0元</h5>
            </div>
          </div>
        </div>
      </div>
      </div>

      <div class="border">
            
      <br/>
      <div class="row">
        <div class="span12">
          <form class="form-horizontal" action="certStep2.do" method="POST">
    		<div class="row">
    		  <div class="span4">
    		    <div class="control-group">
		    	  <label class="control-label" for="dest">前往国家和地区</label>
		    	  <div class="controls">
		    		<SELECT id="dest" name="dest">
						<OPTION selected value="NULL">请选择</OPTION>
						<OPTION  value="UNITED_STATES">美国</OPTION>
						<OPTION  value="ENGLAND">英国</OPTION>
						<OPTION  value="FRANCH">法国</OPTION>
						<OPTION  value="GERMANY">德国</OPTION>
						<OPTION  value="ITALY">意大利</OPTION>						
						<OPTION  value="SPAIN">西班牙</OPTION>
						<OPTION  value="PORTUGAL">葡萄牙</OPTION>
						<OPTION  value="JAPAN">日本</OPTION>
						<OPTION  value="KOREA">韩国</OPTION>
					</SELECT>
		    	  </div>
		    	</div>
    		  </div>
    		  <div class="span4">
    		    <div class="control-group">
		    	  <label class="control-label" for="trans">公证翻译</label>
		    	  <div class="controls">
		    		<SELECT id="trans" name="trans">
						<OPTION selected value="false">请选择</OPTION>
						<OPTION  value="true">翻译</OPTION>
						<OPTION  value="false">不翻译</OPTION>						
					</SELECT>
		    	  </div>
		    	</div>
    		  </div>
    		  <div class="span4">
    		    <div class="control-group">
		    	  <label class="control-label" for="copies">公证书</label>
		    	  <div class="controls">
		    		<input class="thin" id="copies" name="copies" type="text" value="1"></input>&nbsp;本
		    	  </div>
		    	</div>
    		  </div>
    		</div>
    		<div class="row">
    		  <div class="span12">
    		    <div class="control-group">
    		      <label class="control-label" for="purpose">选择办证用途</label>
    		      <div class="controls">
    		        <label class="radio inline">
				      <input type="radio" value="RESIDENCE" name="purpose" checked> 定居&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="VISIT" name="purpose"> 探亲&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="WORK" name="purpose"> 工作&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="STUDY" name="purpose"> 学习&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="MARRIAGE" name="purpose"> 结婚&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="OTHER" name="purpose"> 其他&nbsp;&nbsp;
				    </label>
    		      </div>
    		    </div>
    		  </div>
    		</div>
    		<hr/>
    		<br>
    		
    		<div class="row">
    		  <div class="span12">
    		    <div class="control-group">
    		      <label class="control-label">可选公证业务</label>
    		    </div>
    		  </div>
    		</div>
    		<div class="row">
    		  <div class="span11 offset1">
    		    <table class="table">
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 出生</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 受过/未受刑事处分</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 亲属关系</td>
    		        <td><input type="checkbox" value="JH" name="notory_key"> 结婚</td>
    		        <td><input type="checkbox" value="XL" name="notory_key"> 学历</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 学位</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 曾用名</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 国籍</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 死亡</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 离休/退休/退职</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 出生证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 身份证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 护照复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 驾驶证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 户口簿复印件</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 婚姻状况证明复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 结婚证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 离婚证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 退休证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 房产证复印件</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 存款证明复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 毕业证书复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 学位证书复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 中小学毕业证（带成绩）复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 初中/高中成绩复印件</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 高考成绩复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 大学/大专/职高成绩复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 在读证明复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 资格证/技术等级证书复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 法院判决/调解/裁定书复印件</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 未婚</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 未再婚声明书</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 同意出国声明书</td>
    		        <td></td>
    		        <td></td>
    		      </tr>
    		      
    		    </table>
    		  </div>
    		</div>
    		<br/>
    		<hr/>
    		<br/>
    		
    		<div class="row">
    		  <div class="span2 offset5">
    		    <button class="btn btn-large btn-block btn-info" type="submit">下一步</button>
    		  </div>    		  
    		</div>
    	  </form>
        </div>
        
        <hr/>
        
      </div>
      </div>
      
      <br>
      <br>
      <br>
      <br>
      <hr/>
      <br>
      
      
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