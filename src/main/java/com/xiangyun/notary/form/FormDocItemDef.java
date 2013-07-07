package com.xiangyun.notary.form;

import java.io.Serializable;

public class FormDocItemDef implements Serializable {
	private String docKey;
	private String docName;
	private boolean uploadAlone;
	private boolean needCrop;
	
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
    public boolean isNeedCrop() {
        return needCrop;
    }
    public void setNeedCrop(boolean needCrop) {
        this.needCrop = needCrop;
    }

}
