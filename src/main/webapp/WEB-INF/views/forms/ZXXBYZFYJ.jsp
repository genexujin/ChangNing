<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 中小学毕业证书复印件公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;中小学毕业证书复印件公证信息</h5>
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
			    	  <label class="control-label" for="ZXXBYZFYJ_BYZ">是否有毕业证</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZXXBYZFYJ_BYZ" checked> 有&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZXXBYZFYJ_BYZ"> 无&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="ZXXBYZFYJ_BYZ_M" class="span4 tiny-pt">提示：若无毕业证暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          
	          <br/>	         
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="ZXXBYZFYJ_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZXXBYZFYJ_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZXXBYZFYJ_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	            <div id="ZXXBYZFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否暂不开放网上公证业务
	            </div>
	          </div>
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="ZXXBYZFYJ_SHBY">是否在沪毕业</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="ZXXBYZFYJ_SHBY" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="ZXXBYZFYJ_SHBY"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
	            </div>
	          </div>
	          
	        </div>
	    </div>
	  </div>
	  
	  <script>
	    function prepareZXXBYZFYJ() {
	    	validateZXXBYZFYJ1();
	    	validateZXXBYZFYJ2();
	    	
	    	$("input[name='ZXXBYZFYJ_BYZ']").change(validateZXXBYZFYJ1);
	    	
	    	$("input[name='ZXXBYZFYJ_SHHJ']").change(validateZXXBYZFYJ2);
	    	
	    	$("input[name='ZXXBYZFYJ_SHBY']").change(validateZXXBYZFYJ2);
	    }
	    
		function validateZXXBYZFYJ1(){
		     var zxxbyzfyj_byz = $("input[name='ZXXBYZFYJ_BYZ']:checked").val();
		     if (zxxbyzfyj_byz == 'true') {
		    	 $("#ZXXBYZFYJ_BYZ_M").removeClass("alert alert-error");
		    	 updateValidZXXBYZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#ZXXBYZFYJ_BYZ_M").addClass("alert alert-error");
		    	 validZXXBYZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
		function validateZXXBYZFYJ2(){
		     var zxxbyzfyj_shhj = $("input[name='ZXXBYZFYJ_SHHJ']:checked").val();
		     var zxxbyzfyj_shby = $("input[name='ZXXBYZFYJ_SHBY']:checked").val();
		     if (zxxbyzfyj_shhj == 'true' || zxxbyzfyj_shby == 'true') {
		    	 $("#ZXXBYZFYJ_2_M").removeClass("alert alert-error");
		    	 updateValidZXXBYZFYJ();
		    	 tryToEnableGoToStep3Button();
		     } else {
		    	 $("#ZXXBYZFYJ_2_M").addClass("alert alert-error");
		    	 validZXXBYZFYJ = false;
		    	 disableGoToStep3Button();
		     }
		}
	    
	    function updateValidZXXBYZFYJ() {
		    var zxxbyzfyj_byz = $("input[name='ZXXBYZFYJ_BYZ']:checked").val();
	    	var zxxbyzfyj_shhj = $("input[name='ZXXBYZFYJ_SHHJ']:checked").val();
		    var zxxbyzfyj_shby = $("input[name='ZXXBYZFYJ_SHBY']:checked").val();
		    
		    if (zxxbyzfyj_byz == 'true' && (zxxbyzfyj_shhj == 'true' || zxxbyzfyj_shby == 'true'))
		    	validZXXBYZFYJ = true;
	    }
	    
	    $(prepareZXXBYZFYJ);
	  </script>