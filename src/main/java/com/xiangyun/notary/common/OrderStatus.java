package com.xiangyun.notary.common;

public enum OrderStatus {
    NULL(""),
    SUBMITTED("已创建"),
    PAYING("付款中"),
    PAID("已付款"),
    ACCEPTED("已受理"),    
    CANCEL_REQUESTED("已申请撤销"),
    EXTRADOC_REQUESTED("要求补充材料"),
    ADD_CHARGE("附加费用"),    
    CANCELLED("已撤销"),
    FINISHED("已完成");
    
    private String text;
    
    private OrderStatus(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
