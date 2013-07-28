package com.xiangyun.notary.form;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FormDef implements Serializable {
	private String formKey;
	private String formName;
	private boolean containsItem = true;
	private boolean containsVarItem = true;
    private List<FormFieldItemDef> fields = new ArrayList<FormFieldItemDef>();
	private List<FormDocItemDef> docs = new ArrayList<FormDocItemDef>();
	
	public String getFormKey() {
		return formKey;
	}
	
	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

    public boolean isContainsItem() {
        return containsItem;
    }

    public void setContainsItem(boolean containsItem) {
        this.containsItem = containsItem;
    }

    public boolean isContainsVarItem() {
        return containsVarItem;
    }

    public void setContainsVarItem(boolean containsVarItem) {
        this.containsVarItem = containsVarItem;
    }

	public List<FormFieldItemDef> getFields() {
		return fields;
	}

	public void setFields(List<FormFieldItemDef> fields) {
		this.fields = fields;
	}

	public List<FormDocItemDef> getDocs() {
		return docs;
	}

	public void setDocs(List<FormDocItemDef> docs) {
		this.docs = docs;
	}
	
	public static void main(String[] args) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, FormDef> forms = mapper.readValue(Thread.currentThread().getContextClassLoader().getResourceAsStream("form_definition.json"), new TypeReference<Map<String, FormDef>>() {});
		for (FormDef form : forms.values()) {
			System.out.println("Form Key: " + form.getFormKey());
			System.out.println("Form Name: " + form.getFormName());
			System.out.println("Form Fields: ");
			for (FormFieldItemDef field : form.getFields()) {
				System.out.println("    Field Key: " + field.getFieldKey());
				System.out.println("    Field Name: " + field.getFieldName());
			}
			System.out.println("Form Docs: ");
			for (FormDocItemDef doc : form.getDocs()) {
				System.out.println("    Doc Key: " + doc.getDocKey());
				System.out.println("    Doc Name: " + doc.getDocName());
				System.out.println("    Upload Alone? " + doc.isUploadAlone());
			}
		}
	}

}
