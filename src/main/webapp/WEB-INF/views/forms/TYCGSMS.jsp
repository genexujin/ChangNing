<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 同意出国声明书公证 -->
<div class="bar-bg">
	<div class="row">
		<div class="span12 navbg2">
			<h5>&nbsp;&nbsp;&nbsp;&nbsp;同意出国声明书公证信息</h5>
		</div>
	</div>
</div>

<div class="border">
	<br />
	<div class="row">
		<div class="span12">
			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="TYCGSMS_SHHJ">户籍是否在上海</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="TYCGSMS_SHHJ" checked> 有&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="TYCGSMS_SHHJ"> 无&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
				<div id="TYCGSMS_SHHJ_M" class="span4 tiny-pt">提示：若户籍不在上海则不可办理公证</div>
			</div>

			<hr />

			<br />
			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="TYCGSMS_XHCSZ">有小孩出生证明</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="TYCGSMS_XHCSZ" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="TYCGSMS_XHCSZ"> 否&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
				<div id="TYCGSMS_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证</div>
			</div>
			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="TYCGSMS_XHDSZNZ">有小孩独生子女证</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="TYCGSMS_XHDSZNZ" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="TYCGSMS_XHDSZNZ"> 否&nbsp;&nbsp;
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
						<label class="control-label" >请下载声明书</label>
						<div class="controls">
							<button href="#" class="btn" type="button">下载</button>
						</div>
					</div>
				</div>
				<div  class="span4 tiny-pt">提示：下载后请签字、扫描并上传</div>
			</div>
		</div>
	</div>
</div>

<script>
	function prepareTYCGSMS() {
		$("input[name='TYCGSMS_SHHJ']").change(validateTYCGSMS1);

		$("input[name='TYCGSMS_XHCSZ']").change(validateTYCGSMS2);

		$("input[name='TYCGSMS_XHDSZNZ']").change(validateTYCGSMS2);
	}

	function validateTYCGSMS1() {
		var tycgsms_shhj = $("input[name='TYCGSMS_SHHJ']:checked").val();
		if (tycgsms_shhj == 'true') {
			$("#TYCGSMS_SHHJ_M").removeClass("alert alert-error");
			updateValidTYCGSMS();
			tryToEnableGoToStep3Button();
		} else {
			$("#TYCGSMS_SHHJ_M").addClass("alert alert-error");
			validTYCGSMS = false;
			disableGoToStep3Button();
		}
	}

	function validateTYCGSMS2() {
		var tycgsms_xhcsz = $("input[name='TYCGSMS_XHCSZ']:checked").val();
		var tycgsms_xhdsznz = $("input[name='TYCGSMS_XHDSZNZ']:checked").val();
		if (tycgsms_xhcsz == 'true' || tycgsms_xhdsznz == 'true') {
			$("#TYCGSMS_2_M").removeClass("alert alert-error");
			updateValidTYCGSMS();
			tryToEnableGoToStep3Button();
		} else {
			$("#TYCGSMS_2_M").addClass("alert alert-error");
			validTYCGSMS = false;
			disableGoToStep3Button();
		}
	}

	function updateValidTYCGSMS() {
		var tycgsms_shhj = $("input[name='TYCGSMS_SHHJ']:checked").val();
		var tycgsms_xhcsz = $("input[name='TYCGSMS_XHCSZ']:checked").val();
		var tycgsms_xhdsznz = $("input[name='TYCGSMS_XHDSZNZ']:checked").val();

		if (tycgsms_shhj == 'true'
				&& (tycgsms_xhcsz == 'true' || tycgsms_xhdsznz == 'true'))
			validTYCGSMS = true;
	}

	$(prepareTYCGSMS);
</script>