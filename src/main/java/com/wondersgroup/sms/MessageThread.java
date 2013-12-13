package com.wondersgroup.sms;

import org.apache.axis2.AxisFault;

import com.wondersgroup.sms.MessageServiceStub.SendMessageToCenter;

public class MessageThread extends Thread{
	
	//static String url="http://192.168.11.233:20001/MessageService/service";	//���Է�������ַ
	//static String url="http://31.0.128.91:20001/MessageService/service";		//��ʵ��������ַ
	static String url="http://31.0.128.91:20001/MessageService/service";		//��ʵ��������ַ
	
	
	private SendMessageToCenter stc;
	
	public MessageThread(){
		
	}

	public SendMessageToCenter getStc() {
		return stc;
	}

	public void setStc(SendMessageToCenter stc) {
		this.stc = stc;
	}
	
	public void run(){
		try {
			
			System.out.println("message to "+stc.getMessage().local_elseReveiveUsers.getString()[0].toString());
			MessageServiceStub stub = new MessageServiceStub(url);
			stub.SendMessageToCenter(stc);
			System.out.println("message end");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
