<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 户口本复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;户口本复印件公证信息</h5>
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
			    	  <label class="control-label" for="HKBFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="HKBFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="HKBFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="HKBFYJ_SHHJ_M" class="span4 tiny-pt">提示：若否则不可办理公证
			    </div>
	          </div>
	      </div>
        </div>
      </div>
      
      <script>
        function prepareHKBFYJ() {
	    	$("input[name='HKBFYJ_SHHJ']").change(validateHKBFYJ);
	    }
        
        function validateHKBFYJ() {
        	 var hkbfyj_shhj = $("input[name='HKBFYJ_SHHJ']:checked").val();
		     if (hkbfyj_shhj == 'true') {
		    	 $("#HKBFYJ_SHHJ_M").removeClass("alert alert-error");
		    	 validJH = true;
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#HKBFYJ_SHHJ_M").addClass("alert alert-error");
		    	 validJH = false;
		    	 disableGoToStep3Button();
		     }
        }
        
        $(prepareHKBFYJ);
      
      </script>