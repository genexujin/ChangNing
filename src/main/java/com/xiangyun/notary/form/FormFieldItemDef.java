package com.xiangyun.notary.form;

import java.io.Serializable;

public class FormFieldItemDef implements Serializable {
	private String fieldKey;
	private String fieldName;
	
	public String getFieldKey() {
		return fieldKey;
	}
	public void setFieldKey(String fieldKey) {
		this.fieldKey = fieldKey;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

}
