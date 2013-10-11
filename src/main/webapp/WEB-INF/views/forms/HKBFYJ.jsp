<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 户口本复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;户口本复印件公证信息</h5>
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
			    	  <label class="control-label" for="HKBFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="HKBFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="HKBFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="HKBFYJ_SHHJ_M" class="span4 tiny-pt">提示：若非上海户籍暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="HKBFYJ_YS">户口本有字页页数</label>
						<div class="controls">
							<input id="HKBFYJ_YS" name="HKBFYJ_YS" type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'')"></input>
						</div>
					</div>
				</div>
				<div id="HKBFYJ_YS_M" class="span4 tiny-pt">提示：请填写阿拉伯数字，上限50</div>
			  </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareHKBFYJ() {
	    	validHKBFYJ = false;
	    	validateHKBFYJ_SHHJ();
	    	validateHKBFYJ_YS();
	    	
	    	$("input[name='HKBFYJ_SHHJ']").change(validateHKBFYJ_SHHJ);
	    	
	    	$("#HKBFYJ_YS").keyup(validateHKBFYJ_YS); //Why "change" event is not working on IE? Very strange!
	    	
	    }
	    
	    function validateHKBFYJ_SHHJ() {
	    	var hkbfyj_shhj = $("input[name='HKBFYJ_SHHJ']:checked").val();
		    if (hkbfyj_shhj == 'true') {
		        $("#HKBFYJ_SHHJ_M").removeClass("alert alert-error");
		        updateValidHKBFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#HKBFYJ_SHHJ_M").addClass("alert alert-error");
		    	validHKBFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    
	    function validateHKBFYJ_YS() {
	    	var hkbfyj_ys = $("input[name='HKBFYJ_YS']").val();
		    if (hkbfyj_ys != '' && (hkbfyj_ys <= 50) && (hkbfyj_ys > 0)) {
		        $("#HKBFYJ_YS_M").removeClass("alert alert-error");
		        updateValidHKBFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#HKBFYJ_YS_M").addClass("alert alert-error");
		    	validHKBFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    
	    function updateValidHKBFYJ(){
		    var hkbfyj_shhj = $("input[name='HKBFYJ_SHHJ']:checked").val();
		    var hkbfyj_ys = $("input[name='HKBFYJ_YS']").val();
		    if(hkbfyj_shhj=='true' && hkbfyj_ys != '')
		    	validHKBFYJ=true;

	    }
	    
	    $(prepareHKBFYJ);
	  </script>
