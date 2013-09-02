package com.xiangyun.notary.common;

public enum RelativeType {
    NULL(""),
    PARENT("父母"),
    SPOUSE("配偶"),
    CHILD("子女");
    
    private String text;
    
    private RelativeType(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }

}
