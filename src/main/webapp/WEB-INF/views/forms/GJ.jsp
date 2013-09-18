<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	  <!-- 国籍公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;国籍公证信息</h5>
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
			    	  <label class="control-label" for="GJ_SHHJ">现户籍是上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="GJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="GJ_SHHJ" > 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          <div class="row" id="ZXHJ" style="display:none">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="GJ_SHZX">注销户籍是上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="GJ_SHZX" > 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="GJ_SHZX" checked="checked"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="GJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareGJ() {
	    	
	    	$("input[name='GJ_SHHJ']").change(validateGJ2);
	    	
	    	$("input[name='GJ_SHZX']").change(validateGJ2);
	    }
	    
		function validateGJ2(){
		     var gj_shhj = $("input[name='GJ_SHHJ']:checked").val();
		     var gj_shzx = $("input[name='GJ_SHZX']:checked").val();
		     if(gj_shhj != 'true' ){
		    	 $("#ZXHJ").show(1000);
		     }else if(gj_shhj == 'true'){
		    	 $("#ZXHJ").hide(1000);
		     }
		     if (gj_shhj == 'true' || gj_shzx == 'true') {
		    	 $("#GJ_2_M").removeClass("alert alert-error");
		    	 updateValidGJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#GJ_2_M").addClass("alert alert-error");
		    	 validGJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidGJ() {
	    	var gj_shhj = $("input[name='GJ_SHHJ']:checked").val();
		    var gj_shzx = $("input[name='GJ_SHZX']:checked").val();
		    
		    if (gj_shhj == 'true' || gj_shzx == 'true')
		    	validGJ = true;
	    }
	    
	    $(prepareGJ);
	  </script>