package com.xiangyun.notary.common;

public enum Gender {
	NULL(""),
	MALE("男"),
	FEMALE("女");
	
    private String text;
    
    private Gender(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }

}
