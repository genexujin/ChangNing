<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 退休证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;退休证复印件公证信息</h5>
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
			    	  <label class="control-label" for="TXZFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="TXZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="TXZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="TXZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="TXZFYJ_SHTX">退休单位在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="TXZFYJ_SHTX" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="TXZFYJ_SHTX"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareTXZFYJ() {
	    	validTXZFYJ = false;
	    	validateTXZFYJ2();
	    	
	    	$("input[name='TXZFYJ_SHHJ']").change(validateTXZFYJ2);
	    	
	    	$("input[name='TXZFYJ_SHTX']").change(validateTXZFYJ2);
	    }
	    
		function validateTXZFYJ2(){
		     var txzfyj_shhj = $("input[name='TXZFYJ_SHHJ']:checked").val();
		     var txzfyj_shtx = $("input[name='TXZFYJ_SHTX']:checked").val();
		     if (txzfyj_shhj == 'true' || txzfyj_shtx == 'true') {
		    	 $("#TXZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidTXZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#TXZFYJ_2_M").addClass("alert alert-error");
		    	 validTXZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidTXZFYJ() {
	    	var txzfyj_shhj = $("input[name='TXZFYJ_SHHJ']:checked").val();
		    var txzfyj_shtx = $("input[name='TXZFYJ_SHTX']:checked").val();
		    
		    if (txzfyj_shhj == 'true' || txzfyj_shtx == 'true')
		    	validTXZFYJ = true;
	    }
	    
	    $(prepareTXZFYJ);
	  </script>