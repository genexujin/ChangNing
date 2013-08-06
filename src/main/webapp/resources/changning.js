var validXL = true;
var validJH = true;
var validQSGX = true;
var validCYM = true;
var validCS = true;
var validHKBFYJ = true;

function tryToEnableGoToStep3Button() {
	if (validXL && validJH && validQSGX && validCYM && validCS && validHKBFYJ) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}

function setVerify(event) {
	if (event.target.value == 'France') {
		$("input[name='verify']").get(0).checked = true;
	} else {
		$("input[name='verify']").get(1).checked = true;
	}
}