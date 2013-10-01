<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 法院判决调解裁定书复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;法院判决调解裁定书复印件公证信息</h5>
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
			    	  <label class="control-label" for="FYPJTJCDSFYJ_SHFY">由上海法院判决</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="FYPJTJCDSFYJ_SHFY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="FYPJTJCDSFYJ_SHFY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="FYPJTJCDSFYJ_SHFY_M" class="span4 tiny-pt">提示：若非上海法院判决则不可办理公证
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareFYPJTJCDSFYJ() {
	    	validFYPJTJCDSFYJ = false;
	    	validateFYPJTJCDSFYJ_SHFY();
	    	
	    	$("input[name='FYPJTJCDSFYJ_SHFY']").change(validateFYPJTJCDSFYJ_SHFY);
	    	
	    }
	    
	    function validateFYPJTJCDSFYJ_SHFY() {
	    	var fypjtjcdsfyj_shfy = $("input[name='FYPJTJCDSFYJ_SHFY']:checked").val();
		    if (fypjtjcdsfyj_shfy == 'true') {
		        $("#FYPJTJCDSFYJ_SHFY_M").removeClass("alert alert-error");
		        updateValidFYPJTJCDSFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#FYPJTJCDSFYJ_SHFY_M").addClass("alert alert-error");
		    	validFYPJTJCDSFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidFYPJTJCDSFYJ(){
		    var fypjtjcdsfyj_shfy = $("input[name='FYPJTJCDSFYJ_SHFY']:checked").val();
		    if(fypjtjcdsfyj_shfy=='true')
		    	validFYPJTJCDSFYJ=true;

	    }
	    
	    $(prepareFYPJTJCDSFYJ);
	  </script>