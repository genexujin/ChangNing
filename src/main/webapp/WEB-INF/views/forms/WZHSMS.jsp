<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 未再婚证明书公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;未再婚证明书公证信息</h5>
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
			    	  <label class="control-label" for="WZHSMS_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="WZHSMS_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="WZHSMS_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="WZHSMS_SHHJ_M" class="span4 tiny-pt">提示：若非上海户籍则不可办理公证
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareWZHSMS() {
	    	//validWZHSMS = false;
	    	
	    	$("input[name='WZHSMS_SHHJ']").change(validateWZHSMS_SHHJ);
	    	
	    }
	    
	    function validateWZHSMS_SHHJ() {
	    	var wzhsms_shhj = $("input[name='WZHSMS_SHHJ']:checked").val();
		    if (wzhsms_shhj == 'true') {
		        $("#WZHSMS_SHHJ_M").removeClass("alert alert-error");
		        updateValidWZHSMS();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#WZHSMS_SHHJ_M").addClass("alert alert-error");
		    	validWZHSMS = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidWZHSMS(){
		    var wzhsms_shhj = $("input[name='WZHSMS_SHHJ']:checked").val();
		    if(wzhsms_shhj=='true')
		    	validWZHSMS=true;

	    }
	    
	    $(prepareWZHSMS);
	  </script>