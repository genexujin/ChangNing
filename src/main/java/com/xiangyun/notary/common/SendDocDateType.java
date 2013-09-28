package com.xiangyun.notary.common;

public enum SendDocDateType {
	NULL(""),
	WORKDAY("工作日"),
	NON_WORKDAY("非工作日"),
	BOTH("两者皆可");
	
    private String text;
    
    private SendDocDateType(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }

}
