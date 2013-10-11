<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>
	

      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="certStep1.do">网上办证</a> <span class="divider">/</span></li>
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
				<li class="">上门送证</li>
				<li class="">确认订单</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>

      <br>
	  
      <form id="theform" class="form-horizontal" action="certStep2.do" method="POST">
	  
	  <div class="bar-bg">
      <div class="row">
        <div class="span12 navbg2">
          <div class="row">
            <div class="span9">
              <h5>&nbsp;&nbsp;&nbsp;&nbsp;选择申办业务</h5>
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
		    	  <label class="control-label" for="dest"><strong>前往国家或地区</strong></label>
		    	  <div class="controls">
		    		<SELECT id="dest" name="dest">
						<OPTION selected value="NULL">请选择</OPTION>
						<OPTION  value="United_States">美国</OPTION>
						<OPTION  value="France" class="yes">法国</OPTION>
						<OPTION  value="England">英国</OPTION>
						<OPTION  value="Austria" class="yes">奥地利</OPTION>
						<OPTION  value="Germany" class="yes">德国</OPTION>
						<OPTION  value="Australia">澳大利亚</OPTION>
						<OPTION  value="Libya">利比亚</OPTION>
						<OPTION  value="UAE" class="yes">阿联酋</OPTION>
						<OPTION  value="Brazil" class="yes">巴西</OPTION>
						<OPTION  value="Canada">加拿大</OPTION>
						<OPTION  value="South_Africa" class="yes">南非</OPTION>
						<OPTION  value="Japan">日本</OPTION>
						<OPTION  value="Thailand" class="yes">泰国</OPTION>
						<OPTION  value="Myanmar">缅甸</OPTION>
						<OPTION  value="Iran" class="yes">伊朗</OPTION>
						<OPTION  value="India" class="yes">印度</OPTION>
						<OPTION  value="Jordan">约旦</OPTION>
						<OPTION  value="Korea" class="yes">韩国</OPTION>
						<OPTION  value="Bengal">孟加拉</OPTION>
						<OPTION  value="Singapore" class="yes">新加坡</OPTION>
						<OPTION  value="Nepal" class="yes">尼泊尔</OPTION>
						<OPTION  value="Saudi_Arabia">沙特</OPTION>
						<OPTION  value="Kuwait">科威特</OPTION>
						<OPTION  value="Iraq">伊拉克</OPTION>
						<OPTION  value="Yemen">也门</OPTION>
						<OPTION  value="Turkey" class="yes">土耳其</OPTION>
						<OPTION  value="Syria">叙利亚</OPTION>
						<OPTION  value="Qatar">卡塔尔</OPTION>
						<OPTION  value="Philippines" class="yes">菲律宾</OPTION>
						<OPTION  value="Malaysia" class="yes">马来西亚</OPTION>
						<OPTION  value="Pakistan" class="yes">巴基斯坦</OPTION>
						<OPTION  value="Sri_Lanka" class="yes">斯里兰卡</OPTION>
						<OPTION  value="Maldives" class="yes">马尔代夫</OPTION>
						<OPTION  value="Cyprus">塞浦路斯</OPTION>
						<OPTION  value="Vietnam" class="yes">越南</OPTION>
						<OPTION  value="Sweden" class="yes">瑞典</OPTION>
						<OPTION  value="Russia" class="yes">俄罗斯</OPTION>
						<OPTION  value="Netherlands" class="yes">荷兰</OPTION>
						<OPTION  value="Switzerland" class="yes">瑞士</OPTION>
						<OPTION  value="Greece" class="yes">希腊</OPTION>
						<OPTION  value="Finland" class="yes">芬兰</OPTION>
						<OPTION  value="Norway" class="yes">挪威</OPTION>
						<OPTION  value="Denmark" class="yes">丹麦</OPTION>
						<OPTION  value="Spain" class="yes">西班牙</OPTION>
						<OPTION  value="Portugal" class="yes">葡萄牙</OPTION>
						<OPTION  value="Belgium" class="yes">比利时</OPTION>
						<OPTION  value="Italy" class="yes">意大利</OPTION>
						<OPTION  value="Luxembourg" class="yes">卢森堡</OPTION>
						<OPTION  value="Estonia" class="yes">爱沙尼亚</OPTION>
						<OPTION  value="Bulgaria" class="yes">保加利亚</OPTION>
						<OPTION  value="Uzbekistan" class="yes">乌兹别克斯坦</OPTION>
						<OPTION  value="Israel" class="yes">以色列</OPTION>
						<OPTION  value="Cuba" class="yes">古巴</OPTION>
						<OPTION  value="Indonesia" class="yes">印度尼西亚</OPTION>
						<OPTION  value="Ethiopia" class="yes">埃塞俄比亚</OPTION>
						<OPTION  value="PNG" class="yes">巴布亚新几内亚</OPTION>
						<OPTION  value="Cambodia" class="yes">柬埔寨</OPTION>
						<OPTION  value="Monaco" class="yes">摩纳哥</OPTION>
						<OPTION  value="Slovenia" class="yes">斯洛文尼亚</OPTION>
						<OPTION  value="Vanuatu" class="yes">瓦努阿图</OPTION>
						<OPTION  value="Mongolia" class="yes">蒙古</OPTION>
						<OPTION  value="Hungary" class="yes">匈牙利</OPTION>
						<OPTION  value="Romania" class="yes">罗马尼亚</OPTION>
						<OPTION  value="Serbia" class="yes">塞尔维亚</OPTION>
						<OPTION  value="Montenegro">黑山</OPTION>
						<OPTION  value="San_Marino">圣马力诺</OPTION>
						<OPTION  value="Czech" class="yes">捷克</OPTION>
						<OPTION  value="Slovakia" class="yes">斯洛伐克</OPTION>
						<OPTION  value="Ireland">爱尔兰</OPTION>
						<OPTION  value="Poland" class="yes">波兰</OPTION>
						<OPTION  value="Iceland">冰岛</OPTION>
						<OPTION  value="Ukraine" class="yes">乌克兰</OPTION>
						<OPTION  value="Belarus" class="yes">白俄罗斯</OPTION>
						<OPTION  value="Saipan">塞班岛</OPTION>
						<OPTION  value="Solomon">所罗门</OPTION>
						<OPTION  value="New_Zealand">新西兰</OPTION>
						<OPTION  value="Chile" class="yes">智利</OPTION>
						<OPTION  value="Trinidad">特立尼达和多巴哥</OPTION>
						<OPTION  value="Uruguay" class="yes">乌拉圭</OPTION>
						<OPTION  value="Mexico" class="yes">墨西哥</OPTION>
						<OPTION  value="Panama">巴拿马</OPTION>
						<OPTION  value="Argentina" class="yes">阿根廷</OPTION>
						<OPTION  value="Paraguay">巴拉圭</OPTION>
						<OPTION  value="Peru" class="yes">秘鲁</OPTION>
						<OPTION  value="Jamaica">牙买加</OPTION>
						<OPTION  value="Dominica">多米尼加</OPTION>
						<OPTION  value="Colombia" class="yes">哥伦比亚</OPTION>
						<OPTION  value="Venezuela" class="yes">委内瑞拉</OPTION>
						<OPTION  value="Ecuador" class="yes">厄瓜多尔</OPTION>
						<OPTION  value="Bolivia">玻利维亚</OPTION>
						<OPTION  value="Costa_Rica">哥斯达黎加</OPTION>
						<OPTION  value="SWST">圣维圣特</OPTION>
						<OPTION  value="Belize">伯利兹</OPTION>
						<OPTION  value="Egypt" class="yes">埃及</OPTION>
						<OPTION  value="Togo">多哥</OPTION>
						<OPTION  value="Sudan">苏丹</OPTION>
						<OPTION  value="Palau">贝劳</OPTION>
						<OPTION  value="Mali">马里</OPTION>
						<OPTION  value="Ghana">加纳</OPTION>
						<OPTION  value="Surinam">苏里南</OPTION>
						<OPTION  value="Burundi">布隆迪</OPTION>
						<OPTION  value="Morocco">摩洛哥</OPTION>
						<OPTION  value="Somalia">索马里</OPTION>
						<OPTION  value="Uganda">乌干达</OPTION>
						<OPTION  value="Kenya">肯尼亚</OPTION>
						<OPTION  value="Tunisia">突尼斯</OPTION>
						<OPTION  value="Rwanda">卢旺达</OPTION>
						<OPTION  value="Zaire">扎伊尔</OPTION>
						<OPTION  value="Bo_Mier">伯米尔</OPTION>
						<OPTION  value="Lesotho">莱索托</OPTION>
						<OPTION  value="Guinea">几内亚</OPTION>
						<OPTION  value="Angola">安哥拉</OPTION>
						<OPTION  value="Nigeria" class="yes">尼日利亚</OPTION>
						<OPTION  value="Nicaragua">尼加拉瓜</OPTION>
						<OPTION  value="Kazakhstan" class="yes">哈萨克斯坦</OPTION>
					</SELECT>
		    	  </div>
		    	</div>
    		  </div>
    		  <div class="span4">
    		    <div class="control-group">
		    	  <label class="control-label" for="trans"><strong>公证翻译</strong></label>
		    	  <div class="controls">
		    		<SELECT id="trans" name="trans">
						<OPTION selected value="English">英语</OPTION>
						<OPTION  value="NULL">不翻译</OPTION>						
					</SELECT>
		    	  </div>
		    	</div>
    		  </div>
    		  <div class="span4">
    		    <div class="control-group">
		    	  <label class="control-label" for="copies"><strong>公证书</strong></label>
		    	  <div class="controls">
		    		<input class="thin" id="copies" name="copies" type="text" value="1">&nbsp;本
		    	  </div>
		    	</div>
    		  </div>
    		</div>
    		<div class="row">
    		  <div class="span12">
    		    <div class="control-group">
    		      <label class="control-label" for="verify"><strong>是否认证</strong></label>
    		      <div class="controls">
    		        <label class="radio inline">
				      <input type="radio" value="true" name="verify" checked> 是&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="false" name="verify"> 否&nbsp;&nbsp;
				    </label>
				  </div>
    		    </div>
    		  </div>
    		</div>
    		<div class="row">
    		  <div class="span12">
    		    <div class="control-group">
    		      <label class="control-label" for="purpose"><strong>选择办证用途</strong></label>
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
				      <input type="radio" value="TRAVEL" name="purpose"> 旅游&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="OTHER" name="purpose"> 其他&nbsp;&nbsp;
				    </label>
				    <input class="thin hide" id="custom_purpose" name="custom_purpose" type="text">
    		      </div>
    		    </div>
    		  </div>
    		</div>
    		<hr/>
    		<br>
    		<div id="sel_region" class="row hide">
    		  <div class="span2">
    		    <label class="control-label" for="verify"><strong>已选公证业务</strong></label>
    		  </div>
    		  <div class="span9 tiny-pt">
    		      
    		    <div id="anchor" class="hide"></div>
    		    <!-- Put a dummy input here, so that even no YWXF is selected here, Spring Controller can still have this parameter -->
    		    <input type="hidden" value="dummy" name="n_key_yw">
    		  </div>
    		  <div>
    		  </div>
    		</div>
    		<br>
    		<hr/>
    		<br>
    		<div class="row">
    		  <div class="span12">
    		    <div class="control-group">
    		      <label class="control-label"><strong>可选公证业务</strong></label>
    		      
    		    </div>
    		  </div>
    		</div>
    		<div class="row">
    			<div class="span12">
    				<label class="offset1" style="color:gray;padding-bottom:10px;">注：单击 <img src="resources/info.jpg" style="padding-right:2px;display: inline;"/>符号可以查看示例公证书证词及所需提交的相关材料样本。</label>
    			</div>
    		</div>
    		<div id="li_region" class="row">
    		  <div class="span11 offset1">
    		    <table class="table td-no-border" style="width:auto" id="notrayTable">
    		      <tr>
    		        <td style="width:250px">
    		     
    		        <input type="checkbox" value="CS" name="notory_key"> 出生  
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('chusheng.png','出生 公证书样本')"></img>    		        
    		        </td>
    		        <td><input type="checkbox" value="CSZFYJ" name="notory_key"> 出生证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('cszfy_copy1.jpg','出生证复印件 公证书样本', 'cszfy_copy2.jpg','cszfy.png')"></img>
    		        </td>
    		        <td style="width:250px">
    		        	<input type="checkbox" value="TYCGSMS" name="notory_key"> 同意出国声明书
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('tycg_fm.png','同意出国声明书 样本','tycg_ls.png')"></img>
    		        
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        	<input type="checkbox" value="QSGX" name="notory_key"> 亲属关系
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('qsgx.png','亲属关系 公证书样本')"></img>
    		        </td>
    		        <td>
    		        <input type="checkbox" value="JH" name="notory_key"> 已婚
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('yh.png','已婚 公证书样本')"></img>
    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="JHZFYJ" name="notory_key"> 结婚证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('jhzfy_copy4.jpg','结婚证复印件 公证书样本','jhzfy_copy1.jpg','jhzfy_copy2.jpg','jhzfy_copy3.jpg','jhzfy.png')"></img>
    		        
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="HYZKZMFYJ" name="notory_key"> 婚姻状况证明复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('whdj_fy.jpg','无婚姻登记证明公证书样本','whdj.png')"></img>
    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="LHZFYJ" name="notory_key"> 离婚证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('lhzfy.png','结婚证复印件 公证书样本')"></img>    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="XL" name="notory_key"> 学历
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('xl.png','学历 公证书样本')"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="XW" name="notory_key"> 学位
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('xw.png','学位 公证书样本')"></img>
    		        
    		        </td>
    		        <td style="width:250px">
    		        <input type="checkbox" value="BYZSFYJ" name="notory_key"> 毕业证书复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('dxby_copy1.jpg','毕业证书复印件 公证书样本','dxby.png','byzs.png')"></img>
    		        
    		        </td>
    		        <td>
    		        	<input type="checkbox" value="XWZSFYJ" name="notory_key"> 学位证书复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('xwzsfy_copy2.jpg','学位证书复印件 公证书样本','xwzsfy_copy1.jpg','xwzsfy.png')"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="DXDZZGCJFYJ" name="notory_key"> 大学/大专/职高成绩复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('dxcjfy.png','大学/大专/职高成绩复印件 公证书样本')"></img>
    		       
    		        </td>
    		        <td>
    		        <input type="checkbox" value="CZGZCJFYJ" name="notory_key"> 初中/高中成绩复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('cgzcjdfy.png','初中/高中成绩复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		        <input type="checkbox" value="SGWSXSCF" name="notory_key"> 受过/未受刑事处分
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('wx.png','受过/未受刑事处分 公证书样本')"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="JSZFYJ" name="notory_key"> 驾驶证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('jszfy.png','驾驶证复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		         <input type="checkbox" value="HKBFYJ" name="notory_key"> 户口本复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('hkbfy.png','户口簿复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		        	<input type="checkbox" value="HZFYJ" name="notory_key"> 护照复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('hzfy.png','护照复印件 公证书样本')"></img>
    		        </td>    		        
    		      </tr>
    		    </table>
    		    
    		    <div id="expand" style="cursor: pointer;"><i class="icon-plus"></i><font>更多</font></div>
    		    <div id="collpase" class="hide" style="cursor: pointer;"><i class="icon-minus"></i><font>收起</font></div>
    		    <div id="more_notary" class="hide">
    		    <table class="table td-no-border" style="width:auto" id="hiddenNotrayTable">
    		      <tr>
    		        <td style="width:250px">
    		        <input type="checkbox" value="SW" name="notory_key"> 死亡
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('sw.png','死亡 公证书样本')"></img>
    		        
    		        </td>
    		        <td style="width:250px"><input type="checkbox" value="GJ" name="notory_key"> 国籍
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('gj.png','国籍 公证书样本')"></img>
    		        </td>
    		        <td style="width:250px">
    		        <input type="checkbox" value="WH" name="notory_key"> 未婚
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('whzm.png','未婚 公证书样本')"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="WZHSMS" name="notory_key"> 未再婚声明书
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('wzhsm.png','未再婚声明书')"></img>
    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="ZDZMFYJ" name="notory_key"> 在读证明复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('zdzm.png','在读证明复印件 公证书样本')"></img>
    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="ZXXBYZFYJ" name="notory_key">中小学毕业证（带成绩）复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('byzs.png','毕业证书复印件 公证书样本')"></img>
    		       
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="SFZFYJ" name="notory_key"> 身份证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('sfzfy.png','资格证/技术等级证书复印件 公证书样本')"></img>
    		        
    		        </td>
    		        <td>
    		        <input type="checkbox" value="FCZFYJ" name="notory_key"> 房产证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('txz.png','退休证复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		        <input type="checkbox" value="GKCJFYJ" name="notory_key"> 高考成绩复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td>
    		        <input type="checkbox" value="FYPJTJCDSFYJ" name="notory_key"> 法院判决/调解/裁定书复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('tjs.png','法院判决/调解/裁定书复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		        <input type="checkbox" value="CYM" name="notory_key"> 曾用名
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('cym.png','曾用名 公证书样本')"></img>
    		        
    		        </td>    		        
    		        <td>
    		        <input type="checkbox" value="TXZFYJ" name="notory_key"> 退休证复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('txz.png','退休证复印件 公证书样本')"></img>
    		        </td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="TX" name="notory_key"> 离休/退休/退职
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('txlx.png','法院判决/调解/裁定书复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		        <input type="checkbox" value="ZGZFYJ" name="notory_key"> 资格证/技术等级证书复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('zgzsfy.png','资格证/技术等级证书复印件 公证书样本')"></img>
    		        </td>
    		        <td>
    		         <input type="checkbox" value="CKZMFYJ" name="notory_key"> 存款证明复印件
    		        	<img src="resources/info.jpg" style="cursor: pointer; display: inline;" onclick="showImage('ckzm.png','存款证明复印件 公证书样本')"></img>
    		        </td>
    		      </tr>
    		    </table>
    		    </div>
    		    <br/>
    		  </div>
    		</div>
        </div>
        
      </div>
      </div>
      
      <br>
      <br>
    		
   	  <div class="row">
   		  <div class="span2 offset5">
   		    <button id="goToStep2"  class="btn btn-large btn-block btn-info" type="submit">下一步</button>
   		  </div>    		  
   	  </div>
   	  
   	  
      
      </form>
      
<div id="myModal1" class="modal hide fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="width:780px;">
	<div class="modal-header" style="height:10px;">		
		<p id="myModalLabel">图片标题</p>
	</div>
	<div class="modal-body">
		<img id="sampleImage" src="#"></img>
		<img id="sampleImage2" src="#"></img>
		<img id="sampleImage3" src="#"></img>
		<img id="sampleImage4" src="#"></img>
		<img id="sampleImage5" src="#"></img>
		<img id="sampleImage6" src="#"></img>
		<img id="sampleImage7" src="#"></img>
	</div>
	<div class="modal-footer" style="height:20px;">
		<button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
	</div>
</div>

      <script>
      
      var prefix = "resources/samples/";
      
      function showImage(imgURL1, title,imgURL2,imgURL3,imgURL4,imgURL5,imgURL6,imgURL7) {
    	  $("#myModalLabel").text(title);
    	  $("#sampleImage").attr("src", prefix+imgURL1);
    	  
    	  if(imgURL2==null)
    		  $("#sampleImage2").hide();
    	  else{
    		  $("#sampleImage2").attr("src", prefix+imgURL2);
    		  $("#sampleImage2").show();
    	  }
    	  
    	  if(imgURL3==null)
    		  $("#sampleImage3").hide();
    	  else{
    		  $("#sampleImage3").attr("src", prefix+imgURL3);
    		  $("#sampleImage3").show();
    	  }
    	  
    	  if(imgURL4==null)
    		  $("#sampleImage4").hide();
    	  else{
    		  $("#sampleImage4").attr("src", prefix+imgURL4);
    		  $("#sampleImage4").show();
    	  }
    	  
    	  if(imgURL5==null)
    		  $("#sampleImage5").hide();
    	  else{
    		  $("#sampleImage5").attr("src", prefix+imgURL5);
    		  $("#sampleImage5").show();
    	  }
    	  
    	  if(imgURL6==null)
    		  $("#sampleImage6").hide();
    	  else{
    		  $("#sampleImage6").attr("src", prefix+imgURL6);
    		  $("#sampleImage6").show();
    	  }
    	  
    	  if(imgURL7==null)
    		  $("#sampleImage7").hide();
    	  else{
    		  $("#sampleImage7").attr("src", prefix+imgURL7);
    		  $("#sampleImage7").show();
    	  }
    	  
    	  
    	  $("#myModal1").modal("show");  		
      }     
            
      
        function prepareStep1() {
        	$("#notrayTable").css("font-weight","bold");
        	$("#hiddenNotrayTable").css("font-weight","bold");
        	
        	$("input[name='notory_key']").prop("checked", false);
        	
        	$("#goToStep2").click(disableButtonAfterClick);
        	
        	$("#expand").click(expandMoreRegion);
        	$("#collpase").click(collpaseMoreRegion);
        	$("#dest").change(setLangAndVerify);
        	$("#trans").change(setAccordingTranslation);
        	$("input[name='notory_key']").change(onNotaryKeyChange);
        	$("input[name='purpose']").change(onPurposeChange);
        	//When entering the page, the button should be disabled
        	disableGoToStep2Button();
        }
        
        function expandMoreRegion() {
        	$("#expand").hide();
        	$("#collpase").show();
        	$("#more_notary").show("slow");
        }
        
        function collpaseMoreRegion() {
        	$("#expand").show();
        	$("#collpase").hide();
        	$("#more_notary").hide("slow");
        }
        
        function onPurposeChange(event) {
        	if (event.target.value == 'OTHER') {
        		$("#custom_purpose").removeClass("hide");
        	} else {
        		$("#custom_purpose").addClass("hide");
        	}
        }
        
        $(prepareStep1);
        
      </script>
    		      
    		    
      
<%@ include file="footer.jspf"%>