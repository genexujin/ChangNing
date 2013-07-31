<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 出生公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;出生公证信息</h5>
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
			    	  <label class="control-label" for="CS_CSZ">是否有出生证或独生子女证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CS_CSZ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CS_CSZ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="CS_CSZ_M" class="span6 tiny-pt">提示：若无则不可办理该公证
			    </div>
	          </div>
	          
	          <hr/>
	          <br/>
	          
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CS_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CS_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CS_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="CS_2_M" class="span6 large-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CS_SHCS">出生地是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CS_SHCS" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CS_SHCS"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	          <hr/>
	          <br/>
	          
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CS_SFJZ">生父是否健在</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CS_SFJZ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CS_SFJZ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CS_SMJZ">生母是否健在</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CS_SMJZ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CS_SMJZ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	        
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareCS() {
	    	
	        $("input[name='CS_CSZ']").change(validateCS_CSZ);
	    	
	        $("input[name='CS_SHHJ']").change(validateCS2);
	        
	        $("input[name='CS_SHCS']").change(validateCS2);
	    }
	    
	    function validateCS_CSZ() {
	    	var cs_csz = $("input[name='CS_CSZ']:checked").val();
		    if (cs_csz == 'true') {
		        $("#CS_CSZ_M").css("color", "");
		        updateValidCS();
		        tryToEnableGoToStep3Button();
		    } else {
		        $("#CS_CSZ_M").css("color", "red");
		        validCS = false;
		        disableGoToStep3Button();
		    }
	    }
	    
	    function validateCS2(){
		    var cs_shhj = $("input[name='CS_SHHJ']:checked").val();
		    var cs_shcs = $("input[name='CS_SHCS']:checked").val();
		    if (cs_shhj == 'true' || cs_shcs == 'true') {
		   	    $("#CS_2_M").css("color", "");
		   	    updateValidCS();
		   	    tryToEnableGoToStep3Button();
		    } else {
		   	    $("#CS_2_M").css("color", "red");
		   	    validCS = false;
		   	    disableGoToStep3Button();
		    }
		}
	    
	    function updateValidCS() {
	    	var cs_csz = $("input[name='CS_CSZ']:checked").val();
	    	var cs_shhj = $("input[name='CS_SHHJ']:checked").val();
		    var cs_shcs = $("input[name='CS_SHCS']:checked").val();
		    
		    if (cs_csz == 'true' && (cs_shhj == 'true' || cs_shcs == 'true'))
		    	validCS = true;
	    }
	    
	    $(prepareCS);
	  </script>