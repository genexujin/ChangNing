package com.xiangyun.notary.form.v2;

import java.io.File;
import java.util.List;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Form {
	private String formKey;
	private String formName;
	private List<FormFieldItem> fields;
	private List<FormDocItem> docs;
	
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

	public List<FormFieldItem> getFields() {
		return fields;
	}

	public void setFields(List<FormFieldItem> fields) {
		this.fields = fields;
	}

	public List<FormDocItem> getDocs() {
		return docs;
	}

	public void setDocs(List<FormDocItem> docs) {
		this.docs = docs;
	}
	
	public static void main(String[] args) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		
		List<Form> forms = mapper.readValue(mapper.getClass().getClassLoader().getResourceAsStream("form_definition.json"), new TypeReference<List<Form>>() {});
		for (Form form : forms) {
			System.out.println("Form Key: " + form.getFormKey());
			System.out.println("Form Name: " + form.getFormName());
			System.out.println("Form Fields: ");
			for (FormFieldItem field : form.getFields()) {
				System.out.println("    Field Key: " + field.getFieldKey());
				System.out.println("    Field Name: " + field.getFieldName());
			}
			System.out.println("Form Docs: ");
			for (FormDocItem doc : form.getDocs()) {
				System.out.println("    Doc Key: " + doc.getDocKey());
				System.out.println("    Doc Name: " + doc.getDocName());
				System.out.println("    Upload Alone? " + doc.isUploadAlone());
			}
		}
	}

}
