<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 亲属关系公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;亲属关系公证信息</h5>
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
			    	  <label class="control-label" for="QSGX_SHHJ">申请人户籍在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="QSGX_SHHJ" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="QSGX_SHHJ"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="QSGX_SHHJ_M" class="span4 tiny-pt">提示：若户籍不在上海暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          <br/>
	          <input type="hidden" id="QSGX_COUNT" name="QSGX_COUNT" value="1"></input>
	          <!-- 第一行输入 -->
	          <div class="row">
	            <div class="span4 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="relativeType">和申请人关系</label>
			    	  <div class="controls">
				    	<SELECT id="QSGX_RELATION_1" name="QSGX_RELATION_1" class="QSGX_OPTION">
						  <OPTION selected value="NULL">请选择</OPTION>
						  <OPTION  value="PARENT">父母</OPTION>
						  <OPTION  value="SPOUSE">配偶</OPTION>
						  <OPTION  value="CHILD">子女</OPTION>
						</SELECT>
			    	  </div>
			    	</div>
	            </div>
	            <div class="span3">
	                <div class="control-group">
			    	  <label class="control-label" for="relativeName">关系人姓名</label>
			    	  <div class="controls">
		    		    <input id="QSGX_RELATION_1_NAME" name="QSGX_RELATION_1_NAME" type="text" class="thin QSGX_INPUT"></input>
		    	      </div>
		    	    </div>
	            </div>
	            
	            <div class="span3">
	                <div class="control-group">
			    	  <label class="control-label" for="relativeName">拼音</label>
			    	  <div class="controls">
		    		    <input id="QSGX_RELATION_1_PINYIN" name="QSGX_RELATION_1_PY" type="text" class="thin QSGX_INPUT_PY"
		    		           onkeyup="this.value=this.value.replace(/[^\a-zA-Z ]/g,'')"></input>
		    	      </div>
		    	    </div>
	            </div>
	          </div>
	          
	          <div id="QSGX_ANCHOR"></div>
	          
	          <div class="row">
	            <div class="span2 offset1" style="padding-top: 9px;">
	              <button id="QSGX_ADD" class="btn btn-small"><font size="5">+</font></button>
	              <button id="QSGX_REMOVE" class="btn btn-small"><font size="5">-</font></button>
	            </div>
	            <div id="QSGX_RELATION_M" class="span6 tiny-pt">提示：添加的亲属必须选择关系类型，并且关系人姓名不能为空
			    </div>
			    <br/>
	          </div>
	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareQSGX() {
	    		    	
	    	validQSGX = false;
	    	validateQSGX_SHHJ();
	    	validateQSGX_Relations();
	    	
	    	$("input[name='QSGX_SHHJ']").change(validateQSGX_SHHJ);
	    	
	    	$(".QSGX_OPTION").change(validateQSGX_Relations);
	    	
	    	$(".QSGX_INPUT").change(validateQSGX_Relations);
	    }
	    
	    function validateQSGX_SHHJ() {
	    	var qsgx_shhj = $("input[name='QSGX_SHHJ']:checked").val();
		    if (qsgx_shhj == 'true') {
		        $("#QSGX_SHHJ_M").removeClass("alert alert-error");
		        updateValidQSGX();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#QSGX_SHHJ_M").addClass("alert alert-error");
		    	validQSGX = false;
		    	disableGoToStep3Button();
		    }
	    }
	    
	    function validateQSGX_Relations() {
	    	if (validRelations()) {
	    		$("#QSGX_RELATION_M").removeClass("alert alert-error");
	    		updateValidQSGX();
	    		tryToEnableGoToStep3Button();
	    	} else {
	    		$("#QSGX_RELATION_M").addClass("alert alert-error");
	    		validQSGX = false;
		    	disableGoToStep3Button();
	    	}
	    }
	    
	    function updateValidQSGX() {
	    	var qsgx_shhj = $("input[name='QSGX_SHHJ']:checked").val();
		    
		    if (qsgx_shhj == 'true' && validRelations())
		    	validQSGX = true;
	    }
	    
	    function bindAddRemoveRelation() {	    	
	    	$("#QSGX_ADD").click( function(event) {
	    		event.preventDefault();	    		

	    		var currCount = $(".QSGX_OPTION").length;
	    		if ($("#QSGX_COUNT").val() == 10) {
	    			alert("最多一次只能公证10个亲属关系！");
	    			return;
	    		}
	    		$("#QSGX_COUNT").val(++currCount);
	    		insertNewRelation(currCount);
	    		//After add a new relation, need to validate the form again 
	    		validateQSGX_SHHJ();
	    		validateQSGX_Relations();
	    		//Also need to bind the "change" event to the added inputs
	    		$(".QSGX_OPTION").change(validateQSGX_Relations);		    	
		    	$(".QSGX_INPUT").change(validateQSGX_Relations);
	    	});
	    	
	    	$("#QSGX_REMOVE").click( function(event) {
	    		event.preventDefault();
	    		
	    		var currCount = $(".QSGX_OPTION").length;
	    		if (currCount == 1) {
	    			alert("必须至少输入一个亲属关系！");
	    			return;
	    		}
	    		$("#QSGX_COUNT").val(--currCount);
	    		
	    		var anchor = $("#QSGX_ANCHOR");
	    		var toDelete = anchor.prev();
	    		toDelete.remove();
	    		//After remove a relation, need to validate the form again 
	    		validateQSGX_SHHJ();
	    		validateQSGX_Relations();
	    	});
	    }
	    
	    function insertNewRelation(currCount) {
    		var anchor = $("#QSGX_ANCHOR");
    		var toClone = anchor.prev();
    		var cloned = toClone.clone();
    		var option = cloned.find(".QSGX_OPTION");
    		var currId = option.attr("id");
    		var pos = currId.lastIndexOf("_");
    		var newId = currId.substr(0, pos) + "_" + currCount;
    		option.attr("id", newId);
    		option.attr("name", newId);
    		var input = cloned.find(".QSGX_INPUT");
    		input.attr("id", newId + "_NAME");
    		input.attr("name", newId + "_NAME");
    		var input = cloned.find(".QSGX_INPUT_PY");
    		input.attr("id", newId + "_PY");
    		input.attr("name", newId + "_PY");
    		toClone.after(cloned);
	    }
	    
	    function validRelations() {
	    	var localValid = true;
			$.each($(".QSGX_OPTION"), function(index, object){
				if (object.value == 'NULL') {
					//Cannot return here. Because in this inner function, cannot return the outer function
					//return false;
					localValid = false;
				}
			});
			
			$.each($(".QSGX_INPUT"), function(index, object){
				if (object.value == '') {
					//return false;
					localValid = false;
				}
			});
			
			return localValid;
	    }
	    
	    $(prepareQSGX);
	    $(bindAddRemoveRelation);
	  </script>