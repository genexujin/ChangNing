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
				<li class="">上门送证</li>
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
		    	  <label class="control-label" for="trans">公证翻译</label>
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
    		      <label class="control-label" for="verify">是否认证</label>
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
    		<div id="sel_region" class="row ">
    		  <div class="span2">
    		    <label class="control-label" for="verify">已选公证业务</label>
    		  </div>
    		  <div class="span9">
    		    <table class="table">
    		      <tr>
    		        <td><input type="checkbox" value="CS" name="notory_key"> 出生</td>
    		      </tr>
    		    </table>
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
    		      <label class="control-label">可选公证业务</label>
    		    </div>
    		  </div>
    		</div>
    		<div class="row">
    		  <div class="span11 offset1">
    		    <table class="table">
    		      <tr>
    		        <td><input type="checkbox" value="CS" name="notory_key"> 出生</td>
    		        <td><input type="checkbox" value="SGWSXSCF" name="notory_key"> 受过/未受刑事处分</td>
    		        <td><input type="checkbox" value="QSGX" name="notory_key"> 亲属关系</td>
    		        <td><input type="checkbox" value="JH" name="notory_key"> 结婚</td>
    		        <td><input type="checkbox" value="XL" name="notory_key"> 学历</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 学位</td>
    		        <td><input type="checkbox" value="CYM" name="notory_key"> 曾用名</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 国籍</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 死亡</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 离休/退休/退职</td>
    		      </tr>
    		      <tr>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 出生证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 身份证复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 护照复印件</td>
    		        <td><input type="checkbox" value="RESIDENCE" name="notory_key"> 驾驶证复印件</td>
    		        <td><input type="checkbox" value="HKBFYJ" name="notory_key"> 户口簿复印件</td>
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
      
      <script>
        function prepareStep1() {
        	$("#dest").change(setLangAndVerify);
        	$("input[name='notory_key']").change(setVerify);
        }
        
        $(prepareStep1);
      </script>
      
<%@ include file="footer.jspf"%>