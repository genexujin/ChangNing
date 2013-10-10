<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 未婚公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;未婚公证信息</h5>
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
			    	  <label class="control-label" for="WH_SHHJ">户籍是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="WH_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="WH_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="WH_SHHJ_M" class="span4 tiny-pt">提示：若非上海户籍暂不开放网上公证业务
			    </div>
	          </div>

	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareWH() {
	    	validWH = false;
	    	validateWH_SHHJ();
	    	
	    	$("input[name='WH_SHHJ']").change(validateWH_SHHJ);
	    	
	    }
	    
	    function validateWH_SHHJ() {
	    	var wh_shhj = $("input[name='WH_SHHJ']:checked").val();
		    if (wh_shhj == 'true') {
		        $("#WH_SHHJ_M").removeClass("alert alert-error");
		        updateValidWH();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#WH_SHHJ_M").addClass("alert alert-error");
		    	validWH = false;
		    	disableGoToStep3Button();
		    }
	    }
	    function updateValidWH(){
		    var wh_shhj = $("input[name='WH_SHHJ']:checked").val();
		    if(wh_shhj=='true')
		    	validWH=true;

	    }
	    
	    $(prepareWH);
	  </script>