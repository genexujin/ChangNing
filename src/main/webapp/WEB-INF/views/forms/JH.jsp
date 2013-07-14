<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 结婚公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;结婚公证信息</h5>
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
			    	  <label class="control-label" for="JHZ">是否有结婚证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JH_JHZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JH_JHZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="JH_JHZ_M" class="span6 tiny-pt">提示：若无结婚证则不可办理公证
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JH_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JH_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="JH_2_M" class="span6 large-pt">提示：若此两项全否则不可办理公证
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="SHJH">是否在沪结婚登记</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="JH_SHJH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="JH_SHJH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    var validJH = true;
	    
	    function validateJH() {
	    	$("input[name='JH_JHZ']").change(validateJH1);
	    	
	    	$("input[name='JH_SHHJ']").change(validateJH2);
	    	
	    	$("input[name='JH_SHJH']").change(validateJH2);
	    }
	    
		function validateJH1(){
		     var jh_jhz = $("input[name='JH_JHZ']:checked").val();
		     if (jh_jhz == 'true') {
		    	 $("#JH_JHZ_M").css("color", "");
		    	 updateValidJH();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#JH_JHZ_M").css("color", "red");
		    	 validXL = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateJH2(){
		     var jh_shhj = $("input[name='JH_SHHJ']:checked").val();
		     var jh_shjh = $("input[name='JH_SHJH']:checked").val();
		     if (jh_shhj == 'true' || jh_shjh == 'true') {
		    	 $("#JH_2_M").css("color", "");
		    	 updateValidJH();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#JH_2_M").css("color", "red");
		    	 validJH = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidJH() {
	    	var jh_jhz = $("input[name='JH_JHZ']:checked").val();
	    	var jh_shhj = $("input[name='JH_SHHJ']:checked").val();
		    var jh_shjh = $("input[name='JH_SHJH']:checked").val();
		    
		    if (jh_jhz == 'true' && (jh_shhj == 'true' || jh_shjh == 'true'))
		    	validJH = true;
	    }
	    
	    $(validateJH);
	  </script>