var validXL = true;
var validJH = true;
var validQSGX = true;
var validCYM = false;

function tryToEnableGoToStep3Button() {
	if (validXL && validJH && validQSGX && validCYM) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}