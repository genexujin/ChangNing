<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 学位证书复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;学位证书复印件公证信息</h5>
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
			    	  <label class="control-label" for="XWZSFYJ_BYZXWZSFYJZ">是否有毕业证学位证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XWZSFYJ_BYZXWZSFYJZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XWZSFYJ_BYZXWZSFYJZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="XWZSFYJ_BYZXWZSFYJZ_M" class="span4 tiny-pt">提示：若无毕业证学位证则不可办理公证
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XWZSFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XWZSFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XWZSFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="XWZSFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XWZSFYJ_SHBY">是否在沪毕业</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XWZSFYJ_SHBY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XWZSFYJ_SHBY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareXWZSFYJ() {
	    	validateXWZSFYJ1();
	    	validateXWZSFYJ2();
	    	
	    	$("input[name='XWZSFYJ_BYZXWZSFYJZ']").change(validateXWZSFYJ1);
	    	
	    	$("input[name='XWZSFYJ_SHHJ']").change(validateXWZSFYJ2);
	    	
	    	$("input[name='XWZSFYJ_SHBY']").change(validateXWZSFYJ2);
	    }
	    
		function validateXWZSFYJ1(){
		     var xwzsfyj_byz = $("input[name='XWZSFYJ_BYZXWZSFYJZ']:checked").val();
		     if (xwzsfyj_byz == 'true') {
		    	 $("#XWZSFYJ_BYZXWZSFYJZ_M").removeClass("alert alert-error");
		    	 updateValidXWZSFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XWZSFYJ_BYZXWZSFYJZ_M").addClass("alert alert-error");
		    	 validXWZSFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateXWZSFYJ2(){
		     var xwzsfyj_shhj = $("input[name='XWZSFYJ_SHHJ']:checked").val();
		     var xwzsfyj_shby = $("input[name='XWZSFYJ_SHBY']:checked").val();
		     if (xwzsfyj_shhj == 'true' || xwzsfyj_shby == 'true') {
		    	 $("#XWZSFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidXWZSFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XWZSFYJ_2_M").addClass("alert alert-error");
		    	 validXWZSFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidXWZSFYJ() {
		    var xwzsfyj_byz = $("input[name='XWZSFYJ_BYZXWZSFYJZ']:checked").val();
	    	var xwzsfyj_shhj = $("input[name='XWZSFYJ_SHHJ']:checked").val();
		    var xwzsfyj_shby = $("input[name='XWZSFYJ_SHBY']:checked").val();
		    
		    if (xwzsfyj_byz == 'true' && (xwzsfyj_shhj == 'true' || xwzsfyj_shby == 'true'))
		    	validXWZSFYJ = true;
	    }
	    
	    $(prepareXWZSFYJ);
	  </script>