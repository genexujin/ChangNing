<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 曾用名公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;曾用名公证信息</h5>
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
			    	  <label class="control-label" for="CYM_SHHJ">是否在沪户籍</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="CYM_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="CYM_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="CYM_SHHJ_M" class="span4 tiny-pt">提示：若非在沪户籍则不可办理该公证
			    </div>
	          </div>
	          
	          <hr/>	          
	          <br/>
	          
	          <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CYM_CYM">曾用名</label>
			    	  <div class="controls">
				    	<input id="CYM_CYM" name="CYM_CYM" type="text"></input>
			    	  </div>
			    	</div>
	            </div>
	            <div id="CYM_CYM_M" class="span4 tiny-pt">提示：此项不能为空
	            </div>
	          </div>
	          
	           <div class="row">
	            <div class="span5 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="CYM_CYMPY">曾用名拼音</label>
			    	  <div class="controls">
				    	<input id="CYM_CYMPY" name="CYM_CYMPY" type="text" onkeyup="this.value=this.value.replace(/[^\a-zA-Z ]/g,'')"></input>
			    	  </div>
			    	</div>
	            </div>
	            <div id="CYM_CYMPY_M" class="span4 tiny-pt">提示：此项不能为空且只能为字母
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <script>
	      function prepareCYM() {
		      //The form is invalid at the beginning, so set validCYM false and disable the button here
	          validCYM = false;
		      validateCYM_CYM();
		      validateCYM_CYMPY();
		    	
		      $("input[name='CYM_CYM']").change(validateCYM_CYM);
		      
		      $("#CYM_CYMPY").change(validateCYM_CYMPY);
		    	
		      $("input[name='CYM_SHHJ']").change(validateCYM_SHHJ);
		  }
	      
	      function validateCYM_SHHJ() {
		      var cym_shhj = $("input[name='CYM_SHHJ']:checked").val();
			  if (cym_shhj == 'true') {
			      $("#CYM_SHHJ_M").removeClass("alert alert-error");
			      updateValidCYM();
			      tryToEnableGoToStep3Button();
			  } else {
			      $("#CYM_SHHJ_M").addClass("alert alert-error");
			      validCYM = false;
			      disableGoToStep3Button();
			  }
		  }
	      
	      function validateCYM_CYM() {
	    	  var cym_cym = $("#CYM_CYM").val();
	    	  if (cym_cym != '') {
		    	  $("#CYM_CYM_M").removeClass("alert alert-error");
		    	  updateValidCYM();
		    	  tryToEnableGoToStep3Button();
		      } else {
		    	  $("#CYM_CYM_M").addClass("alert alert-error");
		    	  validCYM = false;
			      disableGoToStep3Button();
		      }
	      }
	      
	      function validateCYM_CYMPY() {
	    	  var cym_cympy = $("#CYM_CYMPY").val();
	    	  if (cym_cympy != '') {
		    	  $("#CYM_CYMPY_M").removeClass("alert alert-error");
		    	  updateValidCYM();
		    	  tryToEnableGoToStep3Button();
		      } else {
		    	  $("#CYM_CYMPY_M").addClass("alert alert-error");
		    	  validCYM = false;
			      disableGoToStep3Button();
		      }
	      }
	      
	      function updateValidCYM() {
	    	  var cym_shhj = $("input[name='CYM_SHHJ']:checked").val();
	    	  var cym_cym = $("#CYM_CYM").val();
	    	  var cym_cympy = $("#CYM_CYMPY").val();
			  if (cym_shhj == 'true' && cym_cym != ''&&cym_cympy!='')
				  validCYM = true;
		  }
	      $(prepareCYM);
	      
	    </script>