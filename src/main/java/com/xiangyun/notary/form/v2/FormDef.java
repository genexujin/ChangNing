package com.xiangyun.notary.form.v2;

import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class FormDef {
	private String formKey;
	private String formName;
	private List<FormFieldItemDef> fields;
	private List<FormDocItemDef> docs;
	
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
		
		List<FormDef> forms = mapper.readValue(mapper.getClass().getClassLoader().getResourceAsStream("form_definition.json"), new TypeReference<List<FormDef>>() {});
		for (FormDef form : forms) {
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
