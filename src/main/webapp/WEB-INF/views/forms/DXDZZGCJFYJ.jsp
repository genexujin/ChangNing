<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 大学大专职高成绩复印件公证 -->
<div class="bar-bg">
	<div class="row">
		<div class="span12 navbg2">
			<h5>&nbsp;&nbsp;&nbsp;&nbsp;大学大专职高成绩复印件公证 信息</h5>
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
						<label class="control-label" for="DXDZZGCJFYJ_XN">学年</label>
						<div class="controls">
							<input id="DXDZZGCJFYJ_XN" name="DXDZZGCJFYJ_XN" type="text"></input>
						</div>
					</div>
				</div>
				<div id="DXDZZGCJFYJ_XN_M" class="span4 tiny-pt">提示：此项不能为空</div>
			</div>

			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="DXDZZGCJFYJ_SHHJ">是否在沪户籍</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="DXDZZGCJFYJ_SHHJ" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="DXDZZGCJFYJ_SHHJ"> 否&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
				<div id="DXDZZGCJFYJ_2_M" class="span4 tiny-pt">提示：若此两项全否则不可办理公证</div>
			</div>
			<div class="row">
				<div class="span5 offset1">
					<div class="control-group">
						<label class="control-label" for="DXDZZGCJFYJ_SHXX">学校是否在沪</label>
						<div class="controls">
							<label class="radio inline"> <input type="radio" value="true" name="DXDZZGCJFYJ_SHXX" checked> 是&nbsp;&nbsp;
							</label> <label class="radio inline"> <input type="radio" value="false" name="DXDZZGCJFYJ_SHXX"> 否&nbsp;&nbsp;
							</label>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<script>
	function prepareDXDZZGCJFYJ() {

		validDXDZZGCJFYJ = false;
		validateDXDZZGCJFYJ_XN();
		validateDXDZZGCJFYJ2();
		
		$("input[name='DXDZZGCJFYJ_XN']").change(validateDXDZZGCJFYJ_XN);

		$("input[name='DXDZZGCJFYJ_SHHJ']").change(validateDXDZZGCJFYJ2);

		$("input[name='DXDZZGCJFYJ_SHXX']").change(validateDXDZZGCJFYJ2);
	}

	function validateDXDZZGCJFYJ2() {
		var dxdzzgcjfyj_shhj = $("input[name='DXDZZGCJFYJ_SHHJ']:checked")
				.val();
		var dxdzzgcjfyj_shxx = $("input[name='DXDZZGCJFYJ_SHXX']:checked")
				.val();
		if (dxdzzgcjfyj_shhj == 'true' || dxdzzgcjfyj_shxx == 'true') {
			$("#DXDZZGCJFYJ_2_M").removeClass("alert alert-error");
			updateValidDXDZZGCJFYJ();
			tryToEnableGoToStep3Button();
		} else {
			$("#DXDZZGCJFYJ_2_M").addClass("alert alert-error");
			validDXDZZGCJFYJ = false;
			disableGoToStep3Button();
		}
	}

	function validateDXDZZGCJFYJ_XN() {
		var dxdzzgcjfyj_xn = $("#DXDZZGCJFYJ_XN").val();
		if (dxdzzgcjfyj_xn != '') {
			$("#DXDZZGCJFYJ_XN_M").removeClass("alert alert-error");
			updateValidDXDZZGCJFYJ();
			tryToEnableGoToStep3Button();
		} else {
			$("#DXDZZGCJFYJ_XN_M").addClass("alert alert-error");
			validDXDZZGCJFYJ = false;
			disableGoToStep3Button();
		}
	}

	function updateValidDXDZZGCJFYJ() {
		var dxdzzgcjfyj_xn = $("#DXDZZGCJFYJ_XN").val();
		
		var dxdzzgcjfyj_shhj = $("input[name='DXDZZGCJFYJ_SHHJ']:checked")
				.val();
		var dxdzzgcjfyj_shxx = $("input[name='DXDZZGCJFYJ_SHXX']:checked")
				.val();

		if (dxdzzgcjfyj_xn!=''&&(dxdzzgcjfyj_shhj == 'true' || dxdzzgcjfyj_shxx == 'true'))
			validDXDZZGCJFYJ = true;
	}

	$(prepareDXDZZGCJFYJ);
</script>