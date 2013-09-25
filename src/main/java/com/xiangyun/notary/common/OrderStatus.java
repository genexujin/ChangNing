package com.xiangyun.notary.common;

public enum OrderStatus {
    NULL(""),
    SUBMITTED("已创建"),
    PAYING("付款中"),
    ACCEPTED("已受理"),
    PAID("已付款"),
    FINISHED("已完成"),
    CANCEL_REQUESTED("已申请撤销"),
    ADD_CHARGE("附加费用"),
    CANCELLED("已撤销");
    
    private String text;
    
    private OrderStatus(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
