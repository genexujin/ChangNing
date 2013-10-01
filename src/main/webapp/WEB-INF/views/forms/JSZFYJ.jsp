<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 驾驶证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;驾驶证复印件公证信息</h5>
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
			    	  <label class="control-label" for="JSZFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JSZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JSZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="JSZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="JSZFYJ_SHBF">驾驶证颁发地是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JSZFYJ_SHBF" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JSZFYJ_SHBF"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareJSZFYJ() {
	    	validJSZFYJ = false;
	    	validateJSZFYJ2();
	    	
	    	$("input[name='JSZFYJ_SHHJ']").change(validateJSZFYJ2);
	    	
	    	$("input[name='JSZFYJ_SHBF']").change(validateJSZFYJ2);
	    }
	    
		function validateJSZFYJ2(){
		     var jszfyj_shhj = $("input[name='JSZFYJ_SHHJ']:checked").val();
		     var jszfyj_shbf = $("input[name='JSZFYJ_SHBF']:checked").val();
		     if (jszfyj_shhj == 'true' || jszfyj_shbf == 'true') {
		    	 $("#JSZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidJSZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#JSZFYJ_2_M").addClass("alert alert-error");
		    	 validJSZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidJSZFYJ() {
	    	var jszfyj_shhj = $("input[name='JSZFYJ_SHHJ']:checked").val();
		    var jszfyj_shbf = $("input[name='JSZFYJ_SHBF']:checked").val();
		    
		    if (jszfyj_shhj == 'true' || jszfyj_shbf == 'true')
		    	validJSZFYJ = true;
	    }
	    
	    $(prepareJSZFYJ);
	  </script>