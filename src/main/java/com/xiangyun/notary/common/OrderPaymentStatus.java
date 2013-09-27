package com.xiangyun.notary.common;

public enum OrderPaymentStatus {
    NULL(""),
    NOT_PAID("未完成付款"),
    PARTIAL_PAID("部分付款"),
    FULL_PAID("全额付款"),
    PENDING_REFUND("退款中"),
    REFUNDED("已退款");
    
    private String text;
    
    private OrderPaymentStatus(String text) {
        this.text = text;
    }
    
    public String getText() {
        return text;
    }
}
