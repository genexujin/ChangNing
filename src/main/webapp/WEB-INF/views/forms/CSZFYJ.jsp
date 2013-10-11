<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 出生证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;出生证复印件公证信息</h5>
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
			    	  <label class="control-label" for="CSZFYJ_CSZM">是否有出生证明</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CSZFYJ_CSZM" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CSZFYJ_CSZM"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="CSZFYJ_CSZM_M" class="span4 tiny-pt">提示：若无出生证明暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CSZFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CSZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CSZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="CSZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CSZFYJ_SHCS">出生地是否上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CSZFYJ_SHCS" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CSZFYJ_SHCS"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          <!-- 12 -->
	               <hr/>
	          <br/>
	          
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CSZFYJ_SFJZ">生父是否健在</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CSZFYJ_SFJZ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CSZFYJ_SFJZ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CSZFYJ_SMJZ">生母是否健在</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CSZFYJ_SMJZ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CSZFYJ_SMJZ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          <!-- 23 -->
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareCSZFYJ() {
	    	validCSZFYJ = false;
	    	validateCSZFYJ1();
	    	validateCSZFYJ2();
	    	
	    	$("input[name='CSZFYJ_CSZM']").change(validateCSZFYJ1);
	    	
	    	$("input[name='CSZFYJ_SHHJ']").change(validateCSZFYJ2);
	    	
	    	$("input[name='CSZFYJ_SHCS']").change(validateCSZFYJ2);
	    }
	    
		function validateCSZFYJ1(){
		     var cszfyj_cszm = $("input[name='CSZFYJ_CSZM']:checked").val();
		     if (cszfyj_cszm == 'true') {
		    	 $("#CSZFYJ_CSZM_M").removeClass("alert alert-error");
		    	 updateValidCSZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#CSZFYJ_CSZM_M").addClass("alert alert-error");
		    	 validCSZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateCSZFYJ2(){
		     var cszfyj_shhj = $("input[name='CSZFYJ_SHHJ']:checked").val();
		     var cszfyj_shcs = $("input[name='CSZFYJ_SHCS']:checked").val();
		     if (cszfyj_shhj == 'true' || cszfyj_shcs == 'true') {
		    	 $("#CSZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidCSZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#CSZFYJ_2_M").addClass("alert alert-error");
		    	 validCSZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidCSZFYJ() {
	    	var cszfyj_cszm = $("input[name='CSZFYJ_CSZM']:checked").val();
	    	var cszfyj_shhj = $("input[name='CSZFYJ_SHHJ']:checked").val();
		    var cszfyj_shcs = $("input[name='CSZFYJ_SHCS']:checked").val();
		    
		    if (cszfyj_cszm == 'true' && (cszfyj_shhj == 'true' || cszfyj_shcs == 'true'))
		    	validCSZFYJ = true;
	    }
	    
	    $(prepareCSZFYJ);
	  </script>