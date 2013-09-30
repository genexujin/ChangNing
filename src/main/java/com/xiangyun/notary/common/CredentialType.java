package com.xiangyun.notary.common;

public enum CredentialType {
    NULL(""),
    ID_CARD("身份证"),
    ARMY_ID_CARD("军官证"),
    PASSPORT("护照"),
    HK_MC_TW_PASS("港澳台居民通行证"),
    OTHER("其他");
    
    public String getText() {
		return text;
	}

    private CredentialType(String text) {
        this.text = text;
    }

	private String text;
}
