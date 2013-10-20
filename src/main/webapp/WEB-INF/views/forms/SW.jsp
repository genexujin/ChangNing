<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	  <!-- 死亡公证 -->
	  <div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <h5>&nbsp;&nbsp;&nbsp;&nbsp;死亡公证信息</h5>
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
			    	  <label class="control-label" for="SW_SH">死亡在上海</label>
			    	  <div class="controls">
				    	<label class="radio inline">
					      <input type="radio" value="true" name="SW_SH" checked> 是&nbsp;&nbsp;
					    </label>
					    <label class="radio inline">
					      <input type="radio" value="false" name="SW_SH"> 否&nbsp;&nbsp;
					    </label>
			    	  </div>
			    	</div>
			    </div>
			    <div id="SW_SH_M" class="span4 tiny-pt">提示：若死亡不在上海暂不开放网上公证业务
			    </div>
	          </div>
	          
	          <hr/>
	          <br/>
	          <input type="hidden" id="SW_COUNT" name="SW_COUNT" value="1"></input>
	          <!-- 第一行输入 -->
	          <div class="row">
	            <div class="span4 offset1">
	                <div class="control-group">
			    	  <label class="control-label" for="relativeType">和死亡人关系</label>
			    	  <div class="controls">
				    	<SELECT id="SW_RELATION_1" name="SW_RELATION_1" class="SW_OPTION">
						  <OPTION selected value="NULL">请选择</OPTION>
						  <OPTION  value="PARENT">父母</OPTION>
						  <OPTION  value="SPOUSE">配偶</OPTION>
						  <OPTION  value="CHILD">子女</OPTION>
						</SELECT>
			    	  </div>
			    	</div>
	            </div>
	            <div class="span5">
	                <div class="control-group">
			    	  <label class="control-label" for="relativeName">死亡人姓名</label>
			    	  <div class="controls">
		    		    <input id="SW_RELATION_1_NAME" name="SW_RELATION_1_NAME" type="text" class="SW_INPUT"></input>
		    	      </div>
		    	    </div>
	            </div>
	          </div>
	          
	          <div id="SW_ANCHOR"></div>
	          
	          <div class="row" style="margin-left: 25%">
	          <!--   <div class="span2 offset1" style="padding-top: 9px;">
	              <button id="SW_ADD" class="btn btn-small">+</button>
	              <button id="SW_REMOVE" class="btn btn-small">-</button>
	            </div>
	             -->
	            <div id="SW_RELATION_M" class="span6 tiny-pt" >提示：添加的死亡人必须选择关系类型，并且死亡人姓名不能为空
			    </div>
			    <br/>
	          </div>
	          
	          <br/>
	          
	        </div>
	    </div>        
        
      </div>
      
      <script>
	    function prepareSW() {
	    		    	
	    	validSW = false;
	    	validateSW_SH();
	    	validateSW_Relations();
	    	
	    	$("input[name='SW_SH']").change(validateSW_SH);
	    	
	    	$(".SW_OPTION").change(validateSW_Relations);
	    	
	    	$(".SW_INPUT").change(validateSW_Relations);
	    }
	    
	    function validateSW_SH() {
	    	var SW_sh = $("input[name='SW_SH']:checked").val();
		    if (SW_sh == 'true') {
		        $("#SW_SH_M").removeClass("alert alert-error");
		        updateValidSW();
		    	tryToEnableGoToStep3Button();
		    } else {
		    	$("#SW_SH_M").addClass("alert alert-error");
		    	validSW = false;
		    	disableGoToStep3Button();
		    }
	    }
	    
	    function validateSW_Relations() {
	    	if (validRelations1()) {
	    		$("#SW_RELATION_M").removeClass("alert alert-error");
	    		updateValidSW();
	    		tryToEnableGoToStep3Button();
	    	} else {
	    		$("#SW_RELATION_M").addClass("alert alert-error");
	    		validSW = false;
		    	disableGoToStep3Button();
	    	}
	    }
	    
	    function updateValidSW() {
	    	var SW_sh = $("input[name='SW_SH']:checked").val();
		    
		    if (SW_sh == 'true' && validRelations1())
		    	validSW = true;
	    }
	    
	    function bindAddRemoveRelation() {	    	
	    	$("#SW_ADD").click( function(event) {
	    		event.preventDefault();	    		

	    		var currCount = $("#SW_COUNT").val();
	    		if ($("#SW_COUNT").val() == 10) {
	    			alert("最多一次只能公证1个与死亡者关系！");
	    			return;
	    		}
	    		$("#SW_COUNT").val(++currCount);
	    		insertNewRelation1(currCount);
	    		//After add a new relation, need to validate the form again 
	    		validateSW_SH();
	    		validateSW_Relations();
	    		//Also need to bind the "change" event to the added inputs
	    		$(".SW_OPTION").change(validateSW_Relations);		    	
		    	$(".SW_INPUT").change(validateSW_Relations);
	    	});
	    	
	    	$("#SW_REMOVE").click( function(event) {
	    		event.preventDefault();
	    		
	    		var currCount = $("#SW_COUNT").val();
	    		if (currCount == 1) {
	    			alert("必须至少输入一个亲属关系！");
	    			return;
	    		}
	    		$("#SW_COUNT").val(--currCount);
	    		
	    		var anchor = $("#SW_ANCHOR");
	    		var toDelete = anchor.prev();
	    		toDelete.remove();
	    		//After remove a relation, need to validate the form again 
	    		validateSW_SH();
	    		validateSW_Relations();
	    	});
	    }
	    
	    function insertNewRelation1(currCount) {
    		var anchor = $("#SW_ANCHOR");
    		var toClone = anchor.prev();
    		var cloned = toClone.clone();
    		var option = cloned.find(".SW_OPTION");
    		var currId = option.attr("id");
    		var pos = currId.lastIndexOf("_");
    		var newId = currId.substr(0, pos) + "_" + currCount;
    		option.attr("id", newId);
    		option.attr("name", newId);
    		var input = cloned.find(".SW_INPUT");
    		input.attr("id", newId + "_NAME");
    		input.attr("name", newId + "_NAME");
    		toClone.after(cloned);
	    }
	    
	    function validRelations1() {
	    	var localValid = true;
			$.each($(".SW_OPTION"), function(index, object){
				if (object.value == 'NULL') {
					//Cannot return here. Because in this inner function, cannot return the outer function
					//return false;
					localValid = false;
				}
			});
			
			$.each($(".SW_INPUT"), function(index, object){
				if (object.value == '') {
					//return false;
					localValid = false;
				}
			});
			
			return localValid;
	    }
	    
	    $(prepareSW);
	    $(bindAddRemoveRelation);
	  </script>