package com.xiangyun.notary.common;

public enum Language {
    NULL(""),
    English("英语"),
    French("法语"),
    Italian("意大利语"),
    German("德语"),
    Portuguese("葡萄牙语"),
    Spanish("西班牙语"),
    Japanese("日语"),
    Thai("泰语"),
    Korean("韩语"),
    Vietnamese("越南语"),
    Russian("俄语"),
    Dutch("荷兰语"),
    Greek("希腊语"),
    Hungarian("匈牙利语"),
    Czech("捷克语"),
    Ukrainian("乌克兰语"),
    Arabic("阿拉伯语");
    
    private String text;
    
    private Language(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
