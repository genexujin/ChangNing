<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 初中高中成绩复印件公证 -->
<div class="bar-bg">
	<div class="row">
		<div class="span12 navbg2">
			<h5>&nbsp;&nbsp;&nbsp;&nbsp;初中高中成绩复印件公证 信息</h5>
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
						<label class="control-label" for="CZGZCJFYJ_XN">学年</label>
						<div class="controls">
							<input id="CZGZCJFYJ_XN" name="CZGZCJFYJ_XN" type="text"></input>
						</div>
					</div>
				</div>
				<div id="CZGZCJFYJ_XN_M" class="span4 tiny-pt">提示：此项不能为空</div>
			</div>

			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="CZGZCJFYJ_SHHJ">是否在沪户籍</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="CZGZCJFYJ_SHHJ" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="CZGZCJFYJ_SHHJ"> 否&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
				<div id="CZGZCJFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证</div>
			</div>
			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="CZGZCJFYJ_SHXX">学校是否在沪</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="CZGZCJFYJ_SHXX" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="CZGZCJFYJ_SHXX"> 否&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<script>
	function prepareCZGZCJFYJ() {
		
		validCZGZCJFYJ = false;
		validateCZGZCJFYJ_XN();
		
		$("input[name='CZGZCJFYJ_XN']").change(validateCZGZCJFYJ_XN);

		$("input[name='CZGZCJFYJ_SHHJ']").change(validateCZGZCJFYJ2);

		$("input[name='CZGZCJFYJ_SHXX']").change(validateCZGZCJFYJ2);
	}
	
	function validateCZGZCJFYJ_XN() {
		var czgzcjfyj_xn = $("#CZGZCJFYJ_XN").val();
		
		if (czgzcjfyj_xn != ''){
			//alert('有值');
			$("#CZGZCJFYJ_XN_M").removeClass("alert alert-error");
			//updateCZGZCJFYJ();
			updateValidCZGZCJFYJ();//?调用这里
			tryToEnableGoToStep3Button();
		} else {
			//alert('无值');
			$("#CZGZCJFYJ_XN_M").addClass("alert alert-error");
			validCZGZCJFYJ = false;
			disableGoToStep3Button();
		}
	}

	function validateCZGZCJFYJ2() {
		var czgzcjfyj_shhj = $("input[name='CZGZCJFYJ_SHHJ']:checked").val();
		var czgzcjfyj_shxx = $("input[name='CZGZCJFYJ_SHXX']:checked").val();
		if (czgzcjfyj_shhj == 'true' || czgzcjfyj_shxx == 'true') {
			$("#CZGZCJFYJ_2_M").removeClass("alert alert-error");
			updateValidCZGZCJFYJ();
			tryToEnableGoToStep3Button();
		} else {
			$("#CZGZCJFYJ_2_M").addClass("alert alert-error");
			validCZGZCJFYJ = false;
			disableGoToStep3Button();
		}
	}

	function updateValidCZGZCJFYJ() {
		var czgzcjfyj_xn = $("#CZGZCJFYJ_XN").val();
		var czgzcjfyj_shhj = $("input[name='CZGZCJFYJ_SHHJ']:checked").val();
		var czgzcjfyj_shxx = $("input[name='CZGZCJFYJ_SHXX']:checked").val();

		if (czgzcjfyj_xn!='' &&(czgzcjfyj_shhj == 'true' || czgzcjfyj_shxx == 'true'))
			validCZGZCJFYJ = true;
	}

	$(prepareCZGZCJFYJ);
</script>