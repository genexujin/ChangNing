package com.xiangyun.notary.common;

public enum InteractionType {
    NULL(""),
    ADD_DOCS("补充材料"),
    ADD_PAYMENT("附加费用");
    
    private String text;
    
    private InteractionType(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
