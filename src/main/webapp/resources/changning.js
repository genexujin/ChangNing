var validXL = true;
var validJH = true;
var validQSGX = true;

function tryToEnableGoToStep3Button() {
	if (validXL && validJH && validQSGX) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}