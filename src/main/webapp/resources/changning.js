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

function setLangAndVerify(event) {
	//setLanguage
	setLanguage(event.target.value);
	
	//setVerify
	setVerify(event);
}

function setLanguage(country) {
	var langs = $("#trans").find("option");
	//阿根廷 may remove English, so here to add it back
	var first = langs.get(0);
	if (first.value != 'English') {
		//Clone one and put it as the first one
		$(first).before(createOptionByClone($(first), "English", "英语"));
	}
	
	//Get langs again
	langs = $("#trans").find("option");
	
	//Remove the dynamic ones
	if (langs.length > 2) {
		for (var i = 1; i < langs.length - 1; i++) {
			langs.get(i).remove();
		}
	}
	
	//Now insert language according country
	first = langs.get(0);
	if (country == 'France') {
		$(first).after(createOptionByClone($(first), "French", "法语"));
	} else if (country == 'Austria') {
		$(first).after(createOptionByClone($(first), "German", "德语"));
	} else if (country == 'Germany') {
		$(first).after(createOptionByClone($(first), "German", "德语"));
	} else if (country == 'Brazil') {
		$(first).after(createOptionByClone($(first), "Spanish", "西班牙语"));
		$(first).after(createOptionByClone($(first), "Portuguese", "葡萄牙语"));
	} else if (country == 'Canada') {
		$(first).after(createOptionByClone($(first), "French", "法语"));
	} else if (country == 'Japan') {
		$(first).after(createOptionByClone($(first), "Japanese", "日语"));
	} else if (country == 'Thailand') {
		$(first).after(createOptionByClone($(first), "Thai", "泰语"));
	} else if (country == 'Korea') {
		$(first).after(createOptionByClone($(first), "Korean", "韩语"));
	} else if (country == 'Vietnam') {
		$(first).after(createOptionByClone($(first), "Vietnamese", "越南语"));
	} else if (country == 'Russia') {
		$(first).after(createOptionByClone($(first), "Russian", "俄语"));
	} else if (country == 'Netherlands') {
		$(first).after(createOptionByClone($(first), "Dutch", "荷兰语"));
	} else if (country == 'Greece') {
		$(first).after(createOptionByClone($(first), "Greek", "希腊语"));
	} else if (country == 'Spain') {
		$(first).after(createOptionByClone($(first), "Spanish", "西班牙语"));
	} else if (country == 'Portugal') {
		$(first).after(createOptionByClone($(first), "Portuguese", "葡萄牙语"));
	} else if (country == 'Belgium') {
		$(first).after(createOptionByClone($(first), "French", "法语"));
	} else if (country == 'Italy') {
		$(first).after(createOptionByClone($(first), "Italian", "意大利语"));
	} else if (country == 'Hungary') {
		$(first).after(createOptionByClone($(first), "Hungarian", "匈牙利语"));
	} else if (country == 'Czech') {
		$(first).after(createOptionByClone($(first), "Czech", "捷克语"));
	} else if (country == 'Ukraine') {
		$(first).after(createOptionByClone($(first), "Russian", "俄语"));
		$(first).after(createOptionByClone($(first), "Ukrainian", "乌克兰语"));
	} else if (country == 'Belarus') {
		$(first).after(createOptionByClone($(first), "Russian", "俄语"));
	} else if (country == 'Argentina') {
		$(first).after(createOptionByClone($(first), "Spanish", "西班牙语"));
		//阿根廷 needs to remove the first one
		$(first).remove();
	} else if (country == 'Venezuela') {
		$(first).after(createOptionByClone($(first), "Spanish", "西班牙语"));
	}
}

function setVerify(event) {
	var index = event.target.selectedIndex;
	var sOption = $(event.target).find("option").get(index);
	if ($(sOption).hasClass("yes")) {
		$("input[name='verify']").get(0).checked = true;
	} else {
		$("input[name='verify']").get(1).checked = true;
	}
}

function createOptionByClone(proto, lang, langText) {
	var cloned = proto.clone();
	cloned.attr("value", lang);
	cloned.text(langText);
	cloned.attr("selected", false);
	return cloned;
}