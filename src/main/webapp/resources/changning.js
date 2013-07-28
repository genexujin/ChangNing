var validXL = true;
var validJH = true;

function tryToEnableGoToStep3Button() {
	if (validXL && validJH) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}