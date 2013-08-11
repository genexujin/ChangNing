/************* certStep2 *************/
var validBasic = true;
var validXL = true;
var validJH = true;
var validQSGX = true;
var validCYM = true;
var validCS = true;
var validHKBFYJ = true;

function tryToEnableGoToStep3Button() {
	if (validBasic && validXL && validJH && validQSGX && validCYM && validCS && validHKBFYJ) {
		$("#goToStep3").removeAttr("disabled");
	}
}

function disableGoToStep3Button() {
	$("#goToStep3").attr("disabled", "disabled");
}



/************* certStep1 *************/
function enableGoToStep2Button() {
	$("#goToStep2").removeAttr("disabled");
}

function disableGoToStep2Button() {
	$("#goToStep2").attr("disabled", "disabled");
}

function setLangAndVerify(event) {
	//setLanguage
	setLanguage(event.target.value);
	
	//setVerify
	setVerify(event);
	
	//Update copies and 译文相符
	if (isCountryOfYWXF()) {
		$("#copies").val(2);
		$(".yw").prop("checked", true);
	} else {
		$("#copies").val(1);
		$(".yw").prop("checked", false);
	}
	
	//One edge case: if select "请选择", disable the "下一步" button
	if (event.target.value == 'NULL') {
		disableGoToStep2Button();
	} else if ($("#sel_region").find(".sel_item").length > 0) {
		enableGoToStep2Button();
	}
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

function isCountryOfYWXF() {
	if ($("#dest").val() == 'United_States' 
		|| $("#dest").val() == 'Korea'
		|| $("#dest").val() == 'Austria'
		|| $("#dest").val() == 'Russia') {
		return true;
	}
	return false;
}

function onNotaryKeyChange(event) {
	//First check if country has been selected.
	if ($("#dest").val() == 'NULL') {
		event.target.checked = false;
		alert("请先选择前往国家或地区");
	} else {
    	//Show sel_region if it is hidden
    	if ($("#sel_region").hasClass("hide") ) {
    		$("#sel_region").removeClass("hide");
    		enableGoToStep2Button();
    	}
    	
    	var kValue = event.target.value;
    	var kText = event.target.nextSibling.nodeValue;
    	var kChecked = event.target.checked;
    	
    	if (kChecked) {
    		//Add an item
    		$("#anchor").before(createSelItem(kValue, kText));
    	} else {
    		//Remove an item
    		$("#" + kValue + "_div").remove();
    	}
    	
    	//Hide sel_region if no one is selected
    	if ($("#sel_region").find(".sel_item").length == 0) {
    		$("#sel_region").addClass("hide");
    		disableGoToStep2Button();
    	}
	}

}

function createSelItem(value, text) {
	var rowDiv = $('<div class="row tiny-pb sel_item" id="' + value + '_div"></div>');
	var spanDiv = $('<div class="span8"></div>');
	rowDiv.append(spanDiv);
	
	var nInput = $('<input type="checkbox" value="' + value + '" name="n_key" checked>');
	nInput.change(onSelItemChange);
	
	var ywInput;
	if (isCountryOfYWXF()) {
		ywInput = $('<input type="checkbox" value="' + value + '_YW" name="n_key_yw" class="yw" checked>');
	} else {
		ywInput = $('<input type="checkbox" value="' + value + '_YW" name="n_key_yw" class="yw">');
	}
	
	spanDiv.append(nInput).append(text + '&nbsp;&nbsp;+&nbsp;&nbsp;').append(ywInput).append(' 译文相符');
	
	return rowDiv;
}

function onSelItemChange(event) {
	//Un-check the item in li_region
	var selValue = event.target.value;
	var li = $("#li_region").find("input[value='" + selValue + "']");
	li.get(0).checked = false;
	
	//Remove the item from sel_region
	$(event.target).parent().parent().remove();
	
	//Hide sel_region if no one is selected
	if ($("#sel_region").find(".sel_item").length == 0) {
		$("#sel_region").addClass("hide");
		disableGoToStep2Button();
	}
}

/************* certStep3 *************/
