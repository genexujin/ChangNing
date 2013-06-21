package com.xiangyun.notary.form.v2;

public class FormDocItem {
	private String docKey;
	private String docName;
	private boolean uploadAlone;
	
	public String getDocKey() {
		return docKey;
	}
	public void setDocKey(String docKey) {
		this.docKey = docKey;
	}
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public boolean isUploadAlone() {
		return uploadAlone;
	}
	public void setUploadAlone(boolean uploadAlone) {
		this.uploadAlone = uploadAlone;
	}

}
