<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 学位公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;学位公证信息</h5>
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
			    	  <label class="control-label" for="XW_BYZXWZ">是否有毕业证学位证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XW_BYZXWZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XW_BYZXWZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="XW_BYZXWZ_M" class="span4 tiny-pt">提示：若无毕业证学位证则不可办理公证
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XW_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XW_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XW_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="XW_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XW_SHBY">是否在沪毕业</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XW_SHBY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XW_SHBY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareXW() {
	    	$("input[name='XW_BYZXWZ']").change(validateXW1);
	    	
	    	$("input[name='XW_SHHJ']").change(validateXW2);
	    	
	    	$("input[name='XW_SHBY']").change(validateXW2);
	    }
	    
		function validateXW1(){
		     var xw_byz = $("input[name='XW_BYZXWZ']:checked").val();
		     if (xw_byz == 'true') {
		    	 $("#XW_BYZXWZ_M").removeClass("alert alert-error");
		    	 updateValidXW();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XW_BYZXWZ_M").addClass("alert alert-error");
		    	 validXW = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateXW2(){
		     var xw_shhj = $("input[name='XW_SHHJ']:checked").val();
		     var xw_shby = $("input[name='XW_SHBY']:checked").val();
		     if (xw_shhj == 'true' || xw_shby == 'true') {
		    	 $("#XW_2_M").removeClass("alert alert-error");
		    	 updateValidXW();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XW_2_M").addClass("alert alert-error");
		    	 validXW = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidXW() {
		    var xw_byz = $("input[name='XW_BYZXWZ']:checked").val();
	    	var xw_shhj = $("input[name='XW_SHHJ']:checked").val();
		    var xw_shby = $("input[name='XW_SHBY']:checked").val();
		    
		    if (xw_byz == 'true' && (xw_shhj == 'true' || xw_shby == 'true'))
		    	validXW = true;
	    }
	    
	    $(prepareXW);
	  </script>