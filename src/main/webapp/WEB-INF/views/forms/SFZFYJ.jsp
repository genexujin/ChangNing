<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 身份证复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;身份证复印件公证信息</h5>
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
			    	  <label class="control-label" for="SFZFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="SFZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="SFZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="SFZFYJ_SHHJ_M" class="span4 tiny-pt">提示：若非在沪户籍则不可办理该公证
			    </div>
	          </div>
	          
	          <hr/>	          
	          <br/>
	          
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="SFZFYJ_GZYT">公证用途</label>
			    	  <div class="controls">
				    	<input id="SFZFYJ_GZYT" name="SFZFYJ_GZYT" type="text"></input>
			    	  </div>
			    	</div>
	            </div>
	            <div id="SFZFYJ_GZYT_M" class="span4 tiny-pt">提示：此项不能为空
	            </div>
	          </div>
	          
	        </div>
	      </div>
	    </div>
	    
	    <script>
	      function prepareSFZFYJ() {
		      //The form is invalid at the beginning, so set validSFZFYJ false and disable the button here
	          validSFZFYJ = false;
		      validateSFZFYJ_GZYT();
		    	
		      $("input[name='SFZFYJ_GZYT']").change(validateSFZFYJ_GZYT);
		    	
		      $("input[name='SFZFYJ_SHHJ']").change(validateSFZFYJ_SHHJ);
		  }
	      
	      function validateSFZFYJ_SHHJ() {
		      var sfzfyj_shhj = $("input[name='SFZFYJ_SHHJ']:checked").val();
			  if (sfzfyj_shhj == 'true') {
			      $("#SFZFYJ_SHHJ_M").removeClass("alert alert-error");
			      updateValidSFZFYJ();
			      tryToEnableGoToStep3Button();
			  } else {
			      $("#SFZFYJ_SHHJ_M").addClass("alert alert-error");
			      validSFZFYJ = false;
			      disableGoToStep3Button();
			  }
		  }
	      
	      function validateSFZFYJ_GZYT() {
	    	  var sfzfyj_gzyt = $("#SFZFYJ_GZYT").val();
	    	  if (sfzfyj_gzyt != '') {
		    	  $("#SFZFYJ_GZYT_M").removeClass("alert alert-error");
		    	  updateValidSFZFYJ();
		    	  tryToEnableGoToStep3Button();
		      } else {
		    	  $("#SFZFYJ_GZYT_M").addClass("alert alert-error");
		    	  validSFZFYJ = false;
			      disableGoToStep3Button();
		      }
	      }
	      
	      function updateValidSFZFYJ() {
	    	  var sfzfyj_shhj = $("input[name='SFZFYJ_SHHJ']:checked").val();
	    	  var sfzfyj_gzyt = $("#SFZFYJ_GZYT").val();
			    
			  if (sfzfyj_shhj == 'true' && sfzfyj_gzyt != '')
				  validSFZFYJ = true;
		  }
	      
	      $(prepareSFZFYJ);
	    </script>