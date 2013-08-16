<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 高考成绩复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;高考成绩复印件公证信息</h5>
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
			    	  <label class="control-label" for="GKCJFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="GKCJFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="GKCJFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="GKCJFYJ_SHHJ_M" class="span4 tiny-pt">提示：若户籍不在上海则不可办理公证
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareGKCJFYJ() {
	    	validGKCJFYJ = false;
	    	
	    	$("input[name='GKCJFYJ_SHHJ']").change(validateGKCJFYJ_SHHJ);
	    	
	    }
	    
	    function validateGKCJFYJ_SHHJ() {
	    	var GKCJFYJ_SHHJ = $("input[name='GKCJFYJ_SHHJ']:checked").val();
		    if (GKCJFYJ_SHHJ == 'true') {
		        $("#GKCJFYJ_SHHJ_M").removeClass("alert alert-error");
		        updateValidGKCJFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#GKCJFYJ_SHHJ_M").addClass("alert alert-error");
		    	validGKCJFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidGKCJFYJ(){
		    var gkcjfyj_shhj = $("input[name='GKCJFYJ_SHHJ']:checked").val();
		    if(gkcjfyj_shhj=='true')
		    	validGKCJFYJ=true;

	    }
	    
	    $(prepareGKCJFYJ);
	  </script>