package com.xiangyun.notary.form;

import java.io.Serializable;

public class FormFieldItemDef implements Serializable {
    private static final long serialVersionUID = 1L;
    
	private String fieldKey;
	private String fieldName;
	private boolean composite;
	
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
    public boolean isComposite() {
        return composite;
    }
    public void setComposite(boolean composite) {
        this.composite = composite;
    }

}
