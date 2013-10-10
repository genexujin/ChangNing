<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 结婚证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;结婚证复印件公证信息</h5>
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
 						<label class="control-label" for="JHZFYJ_SHJH">结婚地是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JHZFYJ_SHJH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JHZFYJ_SHJH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="JHZFYJ_SHJH_M" class="span4 tiny-pt">提示：若结婚地不在上海暂不开放网上公证业务
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareJHZFYJ() {
	    	validJHZFYJ = false;
	    	validateJHZFYJ_SHJH();
	    	
	    	$("input[name='JHZFYJ_SHJH']").change(validateJHZFYJ_SHJH);
	    	
	    }
	    
	    function validateJHZFYJ_SHJH() {
	    	var jhzfyj_shjh = $("input[name='JHZFYJ_SHJH']:checked").val();
		    if (jhzfyj_shjh == 'true') {
		        $("#JHZFYJ_SHJH_M").removeClass("alert alert-error");
		        updateValidJHZFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#JHZFYJ_SHJH_M").addClass("alert alert-error");
		    	validJHZFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidJHZFYJ(){
		    var jhzfyj_shjh = $("input[name='JHZFYJ_SHJH']:checked").val();
		    if(jhzfyj_shjh=='true')
		    	validJHZFYJ=true;

	    }
	    
	    $(prepareJHZFYJ);
	  </script>
	  
	