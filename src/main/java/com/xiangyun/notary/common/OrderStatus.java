package com.xiangyun.notary.common;

public enum OrderStatus {
    NULL(""),
    SUBMITTED("已创建"),
    ACCEPTED("已受理"),
    FINISHED("已完成"),
    CANCEL_REQUESTED("已申请撤销"),
    CANCELLED("已取消");
    
    private String text;
    
    private OrderStatus(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
