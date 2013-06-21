package com.xiangyun.notary.form.v2;

import java.util.Map;

public class Form {
	private String formKey;
	private Map<String, FormFieldItem> fields;
	private Map<String, FormDocItem> docs;
	
	public String getFormKey() {
		return formKey;
	}
	
	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}
	
	public Map<String, FormFieldItem> getFields() {
		return fields;
	}
	
	public void setFields(Map<String, FormFieldItem> fields) {
		this.fields = fields;
	}
	
	public Map<String, FormDocItem> getDocs() {
		return docs;
	}
	
	public void setDocs(Map<String, FormDocItem> docs) {
		this.docs = docs;
	}

}
