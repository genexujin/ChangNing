package com.xiangyun.notary.common;

public enum OrderStatus {
    NULL(""),
    SUBMITTED("已创建"),
    PAID("已付款"),
    FINISHED("已完成"),
    CANCELLED("已取消");
    
    private String text;
    
    private OrderStatus(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
