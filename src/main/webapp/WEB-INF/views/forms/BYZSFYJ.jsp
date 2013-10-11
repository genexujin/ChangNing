<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 毕业证书复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;毕业证书复印件公证信息</h5>
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
			    	  <label class="control-label" for="BYZSFYJ_BYZ">是否有毕业证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="BYZSFYJ_BYZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="BYZSFYJ_BYZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="BYZSFYJ_BYZ_M" class="span4 tiny-pt">提示：若无毕业证则暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="BYZSFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="BYZSFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="BYZSFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="BYZSFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="BYZSFYJ_SHBY">是否在沪毕业</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="BYZSFYJ_SHBY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="BYZSFYJ_SHBY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareBYZSFYJ() {
	    	validBYZSFYJ = false;
	    	validateBYZSFYJ1();
	    	validateBYZSFYJ2();
	    	
	    	$("input[name='BYZSFYJ_BYZ']").change(validateBYZSFYJ1);
	    	
	    	$("input[name='BYZSFYJ_SHHJ']").change(validateBYZSFYJ2);
	    	
	    	$("input[name='BYZSFYJ_SHBY']").change(validateBYZSFYJ2);
	    }
	    
		function validateBYZSFYJ1(){
		     var byzsfyj_byz = $("input[name='BYZSFYJ_BYZ']:checked").val();
		     if (byzsfyj_byz == 'true') {
		    	 $("#BYZSFYJ_BYZ_M").removeClass("alert alert-error");
		    	 updateValidBYZSFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#BYZSFYJ_BYZ_M").addClass("alert alert-error");
		    	 validBYZSFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateBYZSFYJ2(){
		     var byzsfyj_shhj = $("input[name='BYZSFYJ_SHHJ']:checked").val();
		     var byzsfyj_shby = $("input[name='BYZSFYJ_SHBY']:checked").val();
		     if (byzsfyj_shhj == 'true' || byzsfyj_shby == 'true') {
		    	 $("#BYZSFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidBYZSFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#BYZSFYJ_2_M").addClass("alert alert-error");
		    	 validBYZSFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidBYZSFYJ() {
		    var byzsfyj_byz = $("input[name='BYZSFYJ_BYZ']:checked").val();
	    	var byzsfyj_shhj = $("input[name='BYZSFYJ_SHHJ']:checked").val();
		    var byzsfyj_shby = $("input[name='BYZSFYJ_SHBY']:checked").val();
		    
		    if (byzsfyj_byz == 'true' && (byzsfyj_shhj == 'true' || byzsfyj_shby == 'true'))
		    	validBYZSFYJ = true;
	    }
	    
	    $(prepareBYZSFYJ);
	  </script>