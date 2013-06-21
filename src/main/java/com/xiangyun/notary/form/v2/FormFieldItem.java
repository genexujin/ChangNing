package com.xiangyun.notary.form.v2;

public class FormFieldItem<T> {
	private String fieldKey;
	private T fieldValue;
	
	public String getFieldKey() {
		return fieldKey;
	}
	public void setFieldKey(String fieldKey) {
		this.fieldKey = fieldKey;
	}
	public T getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(T fieldValue) {
		this.fieldValue = fieldValue;
	}

}
