<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 学历公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;学历公证信息</h5>
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
			    	  <label class="control-label" for="XL_BYZ">是否有毕业证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XL_BYZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XL_BYZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="XL_BYZ_M" class="span6 tiny-pt">提示：若无毕业证则不可办理公证
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XL_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XL_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XL_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="XL_2_M" class="span6 large-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="XL_SHBY">是否在沪毕业</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="XL_SHBY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="XL_SHBY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    validXL = true;
	    function validateXL() {
	    	$("input[name='XL_BYZ']").change(validateXL1);
	    	
	    	$("input[name='XL_SHHJ']").change(validateXL2);
	    	
	    	$("input[name='XL_SHBY']").change(validateXL2);
	    }
	    
		function validateXL1(){
		     var xl_byz = $("input[name='XL_BYZ']:checked").val();
		     if (xl_byz == 'true') {
		    	 $("#XL_BYZ_M").css("color", "");
		    	 updateValidXL();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XL_BYZ_M").css("color", "red");
		    	 validXL = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateXL2(){
		     var xl_shhj = $("input[name='XL_SHHJ']:checked").val();
		     var xl_shby = $("input[name='XL_SHBY']:checked").val();
		     if (xl_shhj == 'true' || xl_shby == 'true') {
		    	 $("#XL_2_M").css("color", "");
		    	 updateValidXL();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#XL_2_M").css("color", "red");
		    	 validXL = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidXL() {
		    var xl_byz = $("input[name='XL_BYZ']:checked").val();
	    	var xl_shhj = $("input[name='XL_SHHJ']:checked").val();
		    var xl_shby = $("input[name='XL_SHBY']:checked").val();
		    
		    if (xl_byz == 'true' && (xl_shhj == 'true' || xl_shby == 'true'))
		    	validXL = true;
	    }
	    
	    $(validateXL);
	  </script>