<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 在读证明复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;在读证明复印件公证信息</h5>
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
			    	  <label class="control-label" for="ZDZMFYJ_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZDZMFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZDZMFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="ZDZMFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="ZDZMFYJ_SHXX">学校是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZDZMFYJ_SHXX" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZDZMFYJ_SHXX"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareZDZMFYJ() {
	    	validateZDZMFYJ2();
	    	
	    	$("input[name='ZDZMFYJ_SHHJ']").change(validateZDZMFYJ2);
	    	
	    	$("input[name='ZDZMFYJ_SHXX']").change(validateZDZMFYJ2);
	    }
	    
		function validateZDZMFYJ2(){
		     var zdzmfyj_shhj = $("input[name='ZDZMFYJ_SHHJ']:checked").val();
		     var zdzmfyj_shxx = $("input[name='ZDZMFYJ_SHXX']:checked").val();
		     if (zdzmfyj_shhj == 'true' || zdzmfyj_shxx == 'true') {
		    	 $("#ZDZMFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidZDZMFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#ZDZMFYJ_2_M").addClass("alert alert-error");
		    	 validZDZMFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidZDZMFYJ() {
	    	var zdzmfyj_shhj = $("input[name='ZDZMFYJ_SHHJ']:checked").val();
		    var zdzmfyj_shxx = $("input[name='ZDZMFYJ_SHXX']:checked").val();
		    
		    if (zdzmfyj_shhj == 'true' || zdzmfyj_shxx == 'true')
		    	validZDZMFYJ = true;
	    }
	    
	    $(prepareZDZMFYJ);
	  </script>