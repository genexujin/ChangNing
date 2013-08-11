package com.xiangyun.notary.form;

import java.io.Serializable;

public class FormDocItemDef implements Serializable {
    private static final long serialVersionUID = 1L;
    
	private String docKey;
	private String docName;
	private boolean uploadAlone;
	private boolean needCrop;
	private boolean dependent;
	private String dependOn;
	
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
    public boolean isDependent() {
        return dependent;
    }
    public void setDependent(boolean dependent) {
        this.dependent = dependent;
    }
    public String getDependOn() {
        return dependOn;
    }
    public void setDependOn(String dependOn) {
        this.dependOn = dependOn;
    }

}
