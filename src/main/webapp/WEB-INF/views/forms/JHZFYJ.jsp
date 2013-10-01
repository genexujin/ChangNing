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
			    	  <label class="control-label" for="JHZFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JHZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JHZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="JHZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
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
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareJHZFYJ() {
	    	validJHZFYJ = false;
	    	validateJHZFYJ2();
	    	
	    	$("input[name='JHZFYJ_SHHJ']").change(validateJHZFYJ2);
	    	
	    	$("input[name='JHZFYJ_SHJH']").change(validateJHZFYJ2);
	    }
	    
		function validateJHZFYJ2(){
		     var jhzfyj_shhj = $("input[name='JHZFYJ_SHHJ']:checked").val();
		     var jhzfyj_shjh = $("input[name='JHZFYJ_SHJH']:checked").val();
		     if (jhzfyj_shhj == 'true' || jhzfyj_shjh == 'true') {
		    	 $("#JHZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidJHZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#JHZFYJ_2_M").addClass("alert alert-error");
		    	 validJHZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidJHZFYJ() {
	    	var jhzfyj_shhj = $("input[name='JHZFYJ_SHHJ']:checked").val();
		    var jhzfyj_shjh = $("input[name='JHZFYJ_SHJH']:checked").val();
		    
		    if (jhzfyj_shhj == 'true' || jhzfyj_shjh == 'true')
		    	validJHZFYJ = true;
	    }
	    
	    $(prepareJHZFYJ);
	  </script>