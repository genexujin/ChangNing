package com.xiangyun.notary.common;

public enum ReservationStatus {
    NULL(""),
    SUBMITTED("已创建"),
    FINISHED("已完成"),
    CANCELLED("已取消");
    
    private String text;
    
    private ReservationStatus(String text) {
        this.text = text;
    }

    public String getText() {
        return text;
    }
}
