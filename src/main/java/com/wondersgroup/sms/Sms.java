package com.wondersgroup.sms;

import java.sql.Timestamp;

public class Sms {
  private String sms_id = "";
  private String sender = "";
  private String mobile_no = "";
  private String msg = "";
  private Timestamp send_date;

  public String getSmsId() {
    return this.sms_id;
  }

  public void setSmsId(String str) {
    this.sms_id = str;
  }

  public String getSender() {
    return this.sender;
  }

  public void setSender(String str) {
    this.sender = str;
  }

  public String getMobileNo() {
    return this.mobile_no;
  }

  public void setMobileNo(String str) {
    this.mobile_no = str;
  }

  public String getMsg() {
    return this.msg;
  }

  public void setMsg(String str) {
    this.msg = str;
  }

  public Timestamp getSendDate() {
    return this.send_date;
  }

  public void setSendDate(Timestamp time) {
    this.send_date = time;
  }

  public String toString() {
    StringBuffer sb = new StringBuffer();
    sb.append("[Sms:");
    sb.append("sms_id = ");
    sb.append(getSmsId());
    sb.append(",");
    sb.append("sender = ");
    sb.append(getSender());
    sb.append(",");
    sb.append("mobile_no = ");
    sb.append(getMobileNo());
    sb.append(",");
    sb.append("msg = ");
    sb.append(getMsg());
    sb.append(",");
    sb.append("send_date = ");
    sb.append(getSendDate());
    sb.append("]");
    return sb.toString();
  }
}
