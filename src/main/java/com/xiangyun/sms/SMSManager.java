package com.xiangyun.sms;

import java.util.HashMap;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.wondersgroup.sms.MessageServiceStub.SendMessageToCenterResponse;
import com.wondersgroup.sms.MessageServiceTest;

public class SMSManager {

    private static boolean enabled = true;
    private static String SURFFIX = " 【长宁公证】";
    private static Logger log = LoggerFactory
			.getLogger(SMSManager.class);

    //发送SMS
    public static int sendSMS(String[] mobiles, String messageContent, int priority) {
//        System.err.println("here");
        if (enabled){
            messageContent += SURFFIX;
            
            log.debug("-------------------------sending sms to : "+mobiles[0]);
//            System.err.println("sent sms");
            HashMap info=new HashMap();
        	Random rd=new Random();
        	//info.put("receiveUser", "");
        	info.put("elseReveive",mobiles[0]);
        	info.put("receiveCode", "SMS");
        	info.put("receiveTime","");
        	info.put("content", messageContent);
        	info.put("msgId", java.util.UUID.randomUUID().toString());
        	MessageServiceTest tester = new MessageServiceTest();
        	SendMessageToCenterResponse resp = null;
        	try {
				resp = tester.SendMessageToCenter(info);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	return 1;
            //return SingletonSMSClient.getClient().sendSMS(mobiles, messageContent, priority);
        }
        else
            return 0;
    }

//    public static double checkBalance() {
//        double result = 0;
//
//        try {
//            result = SingletonSMSClient.getClient().getBalance();            
//            result = result / 0.09;
//            result = Math.floor(result);
//        } catch (Exception e) {
//            // TODO: Add catch code
//            e.printStackTrace();
//        }
//
//        return result;
//    }


    public synchronized static void setEnabled(boolean enabled) {
        SMSManager.enabled = enabled;
    }

    public synchronized static boolean isEnabled() {
        return enabled;
    }
}