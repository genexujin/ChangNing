package com.xiangyun.notary.form;

import java.io.Serializable;

public class DocMeta implements Serializable {
	private String docName;
	private long docSize;
	private String docType;
	
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public long getDocSize() {
		return docSize;
	}
	public void setDocSize(long docSize) {
		this.docSize = docSize;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	
	

}
