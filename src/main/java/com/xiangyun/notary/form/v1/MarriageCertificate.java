package com.xiangyun.notary.form.v1;

public class MarriageCertificate extends BaseForm {
	
	private boolean marriedInSh;
	private String marriageCertDocPath;
	private String spouseIdCardPath;
	private String spousePhotoPath;
	
	public boolean isMarriedInSh() {
		return marriedInSh;
	}
	
	public void setMarriedInSh(boolean marriedInSh) {
		this.marriedInSh = marriedInSh;
	}
	
	public String getMarriageCertDocPath() {
		return marriageCertDocPath;
	}
	
	public void setMarriageCertDocPath(String marriageCertDocPath) {
		this.marriageCertDocPath = marriageCertDocPath;
	}
	
	public String getSpouseIdCardPath() {
		return spouseIdCardPath;
	}
	
	public void setSpouseIdCardPath(String spouseIdCardPath) {
		this.spouseIdCardPath = spouseIdCardPath;
	}
	
	public String getSpousePhotoPath() {
		return spousePhotoPath;
	}
	
	public void setSpousePhotoPath(String spousePhotoPath) {
		this.spousePhotoPath = spousePhotoPath;
	}

}
