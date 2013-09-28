<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>

<%@ include file="header.jspf"%>

      <script src="datepicker/js/bootstrap-datepicker.js"></script>

      <ul class="breadcrumb">
        <b>您的位置：</b>
        <li><a href="#">首页</a> <span class="divider">/</span></li>
        <li><a href="certStep1.do">网上办证</a> <span class="divider">/</span></li>
        <li class="active">上门送证</li>
      </ul>
      
      <hr/>
      
      <div class="row">
        <div class="span12">
          <h2>网上办证</h2>
        </div>
      </div>
      
	  <div class="row">
	    <div class="span12">
		  <div class="flowstep">
			<ol>
				<li class="pass">选择申办业务</li>
				<li class="pass">输入信息</li>
		        <li class="ago">上传资料</li>
				<li class="step">上门送证</li>
		        <li class="end">支付</li>
			</ol>
		  </div>
	    </div>
	  </div>
	  
	  <br>
	  <form class="form-horizontal" action="certStep5.do" method="POST">
	  
		<div class="bar-bg">
	      <div class="row">
	        <div class="span12 navbg2">
	          <div class="row">
	            <div class="span9">
	              <h5>&nbsp;&nbsp;&nbsp;&nbsp;上门送证</h5>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <div class="border">
	      <br/>
	      <div class="row">
		      <div class="span5 offset1">上门送证费用：<font color=red>100.00</font>元人民币。</div>
		  </div>
		  
		  <br/>
		  <hr/>
		  <br/>
		  
		  <div class="row">
	        <div class="span5 offset1">
	    	  <div class="control-group">
			    <label class="control-label" for="sendDoc">是否需要上门送证</label>
			    <div class="controls">
				  <label class="radio inline">
				    <input type="radio" value="true" name="sendDoc"> 是&nbsp;&nbsp;
				  </label>
				  <label class="radio inline">
				    <input type="radio" value="false" name="sendDoc" checked> 否&nbsp;&nbsp;
				  </label>
			    </div>
			  </div>
			</div>
	      </div>
	      
          <div class="row toggle hide">
            <div class="span5 offset1">
                <div class="control-group">
		    	  <label class="control-label" for="sendAddress">联系地址</label>
		    	  <div class="controls">
			    	<input id="sendAddress" name="sendAddress" type="text"></input>
		    	  </div>
		    	</div>
            </div>
            <div id="sendInfoMsg" class="span4">提示：必须输入送证地址</div>            
          </div>
          
          <div class="row toggle hide">
            <div class="span8 offset1">
                <div class="control-group">
		    	  <label class="control-label" for="sendDate">送证时间</label>
		    	  <div class="controls">
		    	    <label class="radio inline">
				      <input type="radio" value="WORKDAY" name="workday" checked> 工作日&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="NON_WORKDAY" name="workday"> 非工作日&nbsp;&nbsp;
				    </label>
				    <label class="radio inline">
				      <input type="radio" value="BOTH" name="workday"> 两者皆可&nbsp;&nbsp;
				    </label>
		    	  </div>
		    	</div>
		    </div>
		  </div>
          
<!--           <div class="row toggle hide">
            <div class="span5 offset1">
                <div class="control-group">
		    	  <label class="control-label" for="sendDate">送证时间</label>
		    	  <div class="controls">
			    	<div data-date-format="mm/dd/yyyy" data-date="now" id="sendDate" class="input-append date">
				      <input type="text" readonly size="16" class="span2" name="sendDate">
				      <span class="add-on"><i class="icon-calendar"></i></span>
			        </div>
		    	  </div>
		    	</div>
            </div>
          </div>	  -->
          
          <div class="row toggle hide">
            <div class="span6 offset2">具体送达时间是在所有材料齐备后，根据以上选择，4个工作日后送达。
            </div>
          </div>
          
          <br/>
		  
	    </div>
	    
	    <br>
        <br>
    		
   	    <div class="row">
   		  <div class="span2 offset5">
   		    <button id="goToStep5" class="btn btn-large btn-block btn-info" type="submit">下一步</button>
   		  </div>    		  
   	    </div>
      
	  </form>
	  
	  <script>
	    function prepareCertStep4() {

		    $("input[name='sendDoc']").change(toggleInput);
	    	
		    var nowTemp = new Date();
		    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
		    
		    $('#sendDate').datepicker({
		    	onRender: function(date) {
		    		return date.valueOf() < now.valueOf() ? 'disabled' : '';
		    	}
		    });
	    }
	    
	    function toggleInput() {
	    	var sendDoc = $("input[name='sendDoc']:checked").val();
	    	if (sendDoc == 'true') {
	    		$(".toggle").removeClass('hide');
	    		$("input[name='sendAddress']").change(validateCertStep4Input);
				//$("input[name='sendDate']").change(validateCertStep4Input);
				$('#sendDate').datepicker().on("changeDate", validateCertStep4Input);
				
		    	validateCertStep4Input();
	    	} else {
	    		$(".toggle").addClass("hide");
	    		$("input[name='sendAddress']").unbind("change", validateCertStep4Input);
	    		$('#sendDate').datepicker().off("changeDate");
	    		//If toggle to false, enable the button anyway
	    		$("#goToStep5").removeAttr("disabled");
	    	}
	    }
	    
	    function validateCertStep4Input() {
	    	var address = $("input[name='sendAddress']").val();
		    var date = $("input[name='sendDate']").val();
		    
		    if (address != '' && date != '') {
		    	$('#sendInfoMsg').removeClass("alert alert-error");
		    	$("#goToStep5").removeAttr("disabled");
		    } else {
		    	$('#sendInfoMsg').addClass("alert alert-error");
		    	$("#goToStep5").attr("disabled", "disabled");
		    }
	    }
	    
	    $(prepareCertStep4);
	  </script>
	  
<%@ include file="footer.jspf"%>