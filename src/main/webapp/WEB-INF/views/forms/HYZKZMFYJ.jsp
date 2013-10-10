<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 婚姻状况证明复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;婚姻状况证明复印件公证信息</h5>
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
			    	  <label class="control-label" for="HYZKZMFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="HYZKZMFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="HYZKZMFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="HYZKZMFYJ_SHHJ_M" class="span4 tiny-pt">提示：若非上海户籍暂不开放网上公证业务
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareHYZKZMFYJ() {
	    	validHYZKZMFYJ = false;
	    	validateHYZKZMFYJ_SHHJ();
	    	
	    	$("input[name='HYZKZMFYJ_SHHJ']").change(validateHYZKZMFYJ_SHHJ);
	    	
	    }
	    
	    function validateHYZKZMFYJ_SHHJ() {
	    	var hyzkzmfyj_shhj = $("input[name='HYZKZMFYJ_SHHJ']:checked").val();
		    if (hyzkzmfyj_shhj == 'true') {
		        $("#HYZKZMFYJ_SHHJ_M").removeClass("alert alert-error");
		        updateValidHYZKZMFYJ();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#HYZKZMFYJ_SHHJ_M").addClass("alert alert-error");
		    	validHYZKZMFYJ = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidHYZKZMFYJ(){
		    var hyzkzmfyj_shhj = $("input[name='HYZKZMFYJ_SHHJ']:checked").val();
		    if(hyzkzmfyj_shhj=='true')
		    	validHYZKZMFYJ=true;

	    }
	    
	    $(prepareHYZKZMFYJ);
	  </script>