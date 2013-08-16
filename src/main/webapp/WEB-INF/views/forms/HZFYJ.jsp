<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 护照复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;护照复印件公证 信息</h5>
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
			    	  <label class="control-label" for="HZFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="HZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="HZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="HZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="HZFYJ_SHQF">学校是否在沪</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="HZFYJ_SHQF" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="HZFYJ_SHQF"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareHZFYJ() {
	    	
	    	$("input[name='HZFYJ_SHHJ']").change(validateHZFYJ2);
	    	
	    	$("input[name='HZFYJ_SHQF']").change(validateHZFYJ2);
	    }
	    
		function validateHZFYJ2(){
		     var hzfyj_shhj = $("input[name='HZFYJ_SHHJ']:checked").val();
		     var hzfyj_shqf = $("input[name='HZFYJ_SHQF']:checked").val();
		     if (hzfyj_shhj == 'true' || hzfyj_shqf == 'true') {
		    	 $("#HZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidHZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#HZFYJ_2_M").addClass("alert alert-error");
		    	 validHZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidHZFYJ() {
	    	var hzfyj_shhj = $("input[name='HZFYJ_SHHJ']:checked").val();
		    var hzfyj_shqf = $("input[name='HZFYJ_SHQF']:checked").val();
		    
		    if (hzfyj_shhj == 'true' || hzfyj_shqf == 'true')
		    	validHZFYJ = true;
	    }
	    
	    $(prepareHZFYJ);
	  </script>