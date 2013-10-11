package com.xiangyun.notary.common;

public enum CertificatePurpose {
    NULL(""),
    RESIDENCE("定居"),
    VISIT("探亲"),
    WORK("工作"),
    STUDY("学习"),
    MARRIAGE("结婚"),
    TRAVEL("旅游"),
    OTHER("其他");
    
    private String text;
    
    private CertificatePurpose(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
