var validXL = true;
var validJH = true;
var validQSGX = true;
var validCYM = true;
var validCS = true;

function tryToEnableGoToStep3Button() {
	if (validXL && validJH && validQSGX && validCYM && validCS) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}