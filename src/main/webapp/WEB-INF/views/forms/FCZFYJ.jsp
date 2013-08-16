<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 房产证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;房产证复印件公证信息</h5>
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
			    	  <label class="control-label" for="FCZFYJ_SHFC">房产是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="FCZFYJ_SHFC" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="FCZFYJ_SHFC"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="FCZFYJ_SHFC_M" class="span4 tiny-pt">提示：若房产不在上海则不可办理公证
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareFCZFYJ() {
	    	validFCZFYJ = false;
	    	
	    	$("input[name='FCZFYJ_SHFC']").change(validateFCZFYJ_SHFC);
	    	
	    }
	    
	    function validateFCZFYJ_SHFC() {
	    	var fczfyj_shfc = $("input[name='FCZFYJ_SHFC']:checked").val();
		    if (fczfyj_shfc == 'true') {
		        $("#FCZFYJ_SHFC_M").removeClass("alert alert-error");
		        updateValidFCZFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#FCZFYJ_SHFC_M").addClass("alert alert-error");
		    	validFCZFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidFCZFYJ(){
		    var fczfyj_shfc = $("input[name='FCZFYJ_SHFC']:checked").val();
		    if(fczfyj_shfc=='true')
		    	validFCZFYJ=true;

	    }
	    
	    $(prepareFCZFYJ);
	  </script>