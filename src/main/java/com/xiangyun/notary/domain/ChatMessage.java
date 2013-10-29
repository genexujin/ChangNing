package com.xiangyun.notary.domain;

import java.util.Date;

public class ChatMessage {
	
	private int messageid;
	
	private String tname;
	
	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	private int threadid;
	
	private int ikind;
	
	private String content;
	
	private Date msgTime;

	public int getMessageid() {
		return messageid;
	}

	public void setMessageid(int messageid) {
		this.messageid = messageid;
	}

	public int getThreadid() {
		return threadid;
	}

	public void setThreadid(int threadid) {
		this.threadid = threadid;
	}

	public int getIkind() {
		return ikind;
	}

	public void setIkind(int ikindid) {
		this.ikind = ikindid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getMsgTime() {
		return msgTime;
	}

	public void setMsgTime(Date msgTime) {
		this.msgTime = msgTime;
	}
	
	

}
