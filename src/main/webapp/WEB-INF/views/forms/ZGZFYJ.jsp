<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 资格证技术等级证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;资格证技术等级证复印件公证信息</h5>
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
			    	  <label class="control-label" for="ZGZFYJ_SHJG">颁证机构是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZGZFYJ_SHJG" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZGZFYJ_SHJG"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="ZGZFYJ_SHJG_M" class="span4 tiny-pt">提示：若颁证机构不在上海则不可办理公证
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareZGZFYJ() {
	    	validZGZFYJ = false;
	    	
	    	$("input[name='ZGZFYJ_SHJG']").change(validateZGZFYJ_SHJG);
	    	
	    }
	    
	    function validateZGZFYJ_SHJG() {
	    	var zgzfyj_shjg = $("input[name='ZGZFYJ_SHJG']:checked").val();
		    if (zgzfyj_shjg == 'true') {
		        $("#ZGZFYJ_SHJG_M").removeClass("alert alert-error");
		        updateValidZGZFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#ZGZFYJ_SHJG_M").addClass("alert alert-error");
		    	validZGZFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidZGZFYJ(){
		    var zgzfyj_shjg = $("input[name='ZGZFYJ_SHJG']:checked").val();
		    if(zgzfyj_shjg=='true')
		    	validZGZFYJ=true;

	    }
	    
	    $(prepareZGZFYJ);
	  </script>