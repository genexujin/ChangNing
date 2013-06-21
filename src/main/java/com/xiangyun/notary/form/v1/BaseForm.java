package com.xiangyun.notary.form.v1;

public class BaseForm {
	private boolean ownCertificate;
	private boolean shHukou;
	private String ownerPhotoPath;
	
	public boolean isOwnCertificate() {
		return ownCertificate;
	}

	public void setOwnCertificate(boolean ownCertificate) {
		this.ownCertificate = ownCertificate;
	}
	
	public boolean isShHukou() {
		return shHukou;
	}

	public void setShHukou(boolean shHukou) {
		this.shHukou = shHukou;
	}
	
	public String getOwnerPhotoPath() {
		return ownerPhotoPath;
	}

	public void setOwnerPhotoPath(String ownerPhotoPath) {
		this.ownerPhotoPath = ownerPhotoPath;
	}

}
