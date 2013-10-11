<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 离婚证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;离婚证复印件公证信息</h5>
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
			    	  <label class="control-label" for="LHZFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="LHZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="LHZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="LHZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="LHZFYJ_SHLH">离婚地是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="LHZFYJ_SHLH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="LHZFYJ_SHLH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareLHZFYJ() {
	    	validLHZFYJ = false;
	    	validateLHZFYJ2();
	    	
	    	$("input[name='LHZFYJ_SHHJ']").change(validateLHZFYJ2);
	    	
	    	$("input[name='LHZFYJ_SHLH']").change(validateLHZFYJ2);
	    }
	    
		function validateLHZFYJ2(){
		     var lhzfyj_shhj = $("input[name='LHZFYJ_SHHJ']:checked").val();
		     var lhzfyj_shlh = $("input[name='LHZFYJ_SHLH']:checked").val();
		     if (lhzfyj_shhj == 'true' || lhzfyj_shlh == 'true') {
		    	 $("#LHZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidLHZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#LHZFYJ_2_M").addClass("alert alert-error");
		    	 validLHZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidLHZFYJ() {
	    	var lhzfyj_shhj = $("input[name='LHZFYJ_SHHJ']:checked").val();
		    var lhzfyj_shlh = $("input[name='LHZFYJ_SHLH']:checked").val();
		    
		    if (lhzfyj_shhj == 'true' || lhzfyj_shlh == 'true')
		    	validLHZFYJ = true;
	    }
	    
	    $(prepareLHZFYJ);
	  </script>