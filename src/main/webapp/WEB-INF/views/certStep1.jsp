<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

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
	  
      <form class="form-horizontal" action="certStep2.do" method="POST">
	  
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
        </div>
        
      </div>
      </div>
      
      <br>
      <br>
    		
   	  <div class="row">
   		  <div class="span2 offset5">
   		    <button class="btn btn-large btn-block btn-info" type="submit">下一步</button>
   		  </div>    		  
   	  </div>
      
      </form>
      
<%@ include file="footer.jspf"%>