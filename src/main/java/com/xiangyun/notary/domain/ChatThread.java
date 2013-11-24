package com.xiangyun.notary.domain;

import java.util.Date;

public class ChatThread {
	
	private int threadid;
	
	private String userName;
	
	private String agentName;
	
	private Date threadStart;
	
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	private Date threadEnd;
	
	private String mobile;

	public int getThreadid() {
		return threadid;
	}

	public void setThreadid(int threadid) {
		this.threadid = threadid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAgentName() {
		return agentName;
	}

	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}

	public Date getThreadStart() {
		return threadStart;
	}

	public void setThreadStart(Date threadStart) {
		this.threadStart = threadStart;
	}

	public Date getThreadEnd() {
		return threadEnd;
	}

	public void setThreadEnd(Date threadEnd) {
		this.threadEnd = threadEnd;
	}
	
	

}
