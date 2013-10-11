<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 退休公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;退休公证信息</h5>
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
			    	  <label class="control-label" for="TX_TXZ">是否有退休证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="TX_TXZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="TX_TXZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="TX_TXZ_M" class="span4 tiny-pt">提示：若无退休证暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="TX_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="TX_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="TX_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="TX_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="TX_SHDW">退休单位是否在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="TX_SHDW" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="TX_SHDW"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareTX() {
	    	validTX = false;
	    	validateTX1();
	    	validateTX2();
	    	
	    	$("input[name='TX_TXZ']").change(validateTX1);
	    	
	    	$("input[name='TX_SHHJ']").change(validateTX2);
	    	
	    	$("input[name='TX_SHDW']").change(validateTX2);
	    }
	    
		function validateTX1(){
		     var tx_txz = $("input[name='TX_TXZ']:checked").val();
		     if (tx_txz == 'true') {
		    	 $("#TX_TXZ_M").removeClass("alert alert-error");
		    	 updateValidTX();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#TX_TXZ_M").addClass("alert alert-error");
		    	 validTX = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateTX2(){
		     var tx_shhj = $("input[name='TX_SHHJ']:checked").val();
		     var tx_shdw = $("input[name='TX_SHDW']:checked").val();
		     if (tx_shhj == 'true' || tx_shdw == 'true') {
		    	 $("#TX_2_M").removeClass("alert alert-error");
		    	 updateValidTX();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#TX_2_M").addClass("alert alert-error");
		    	 validTX = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidTX() {
	    	var tx_txz = $("input[name='TX_TXZ']:checked").val();
	    	var tx_shhj = $("input[name='TX_SHHJ']:checked").val();
		    var tx_shdw = $("input[name='TX_SHDW']:checked").val();
		    
		    if (tx_txz == 'true' && (tx_shhj == 'true' || tx_shdw == 'true'))
		    	validTX = true;
	    }
	    
	    $(prepareTX);
	  </script>