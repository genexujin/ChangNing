package com.xiangyun.notary.form.v1;

public class GraduateCertificate extends BaseForm {
	
	private boolean graduateInSh;
	
	private String graduateCertDocPath;

	public boolean isGraduateInSh() {
		return graduateInSh;
	}

	public void setGraduateInSh(boolean graduateInSh) {
		this.graduateInSh = graduateInSh;
	}
	
	public String getGraduateCertDocPath() {
		return graduateCertDocPath;
	}

	public void setGraduateCertDocPath(String graduateCertDocPath) {
		this.graduateCertDocPath = graduateCertDocPath;
	}

}
