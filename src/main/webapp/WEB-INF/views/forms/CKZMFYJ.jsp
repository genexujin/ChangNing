<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 存款证明复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;存款证明复印件公证信息</h5>
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
			    	  <label class="control-label" for="CKZMFYJ_YHINSH">存款证明颁发银行在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CKZMFYJ_YHINSH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CKZMFYJ_YHINSH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="CKZMFYJ_YHINSH_M" class="span4 tiny-pt">提示：若存款证明颁发银行不在上海暂不开放网上公证业务
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareCKZMFYJ() {
	    	validCKZMFYJ = false;
	    	validateCKZMFYJ_YHINSH();
	    	
	    	$("input[name='CKZMFYJ_YHINSH']").change(validateCKZMFYJ_YHINSH);
	    	
	    }
	    
	    function validateCKZMFYJ_YHINSH() {
	    	var ckzmfyj_yhinsh = $("input[name='CKZMFYJ_YHINSH']:checked").val();
		    if (ckzmfyj_yhinsh == 'true') {
		        $("#CKZMFYJ_YHINSH_M").removeClass("alert alert-error");
		        updateValidCKZMFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#CKZMFYJ_YHINSH_M").addClass("alert alert-error");
		    	validCKZMFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidCKZMFYJ(){
		    var ckzmfyj_yhinsh = $("input[name='CKZMFYJ_YHINSH']:checked").val();
		    if(ckzmfyj_yhinsh=='true')
		    	validCKZMFYJ=true;

	    }
	    
	    $(prepareCKZMFYJ);
	  </script>