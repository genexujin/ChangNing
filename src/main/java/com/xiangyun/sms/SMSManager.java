package com.xiangyun.sms;

import java.util.HashMap;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.wondersgroup.sms.MessageServiceStub.SendMessageToCenterResponse;
import com.wondersgroup.sms.MessageServiceTest;

public class SMSManager {

	private static boolean useEmay = false;
	private static boolean enabled = true;
	private static String SURFFIX = " 【长宁公证处】";
	private static Logger log = LoggerFactory.getLogger(SMSManager.class);

	// 发送SMS
	public static int sendSMS(String[] mobiles, String messageContent,
			int priority) {
		// System.err.println("here");
		if (enabled) {

			log.debug("sending sms to : " + mobiles);
			if (useEmay) {
				log.debug("use emay sms provider");
				messageContent += SURFFIX;
				int res = SingletonSMSClient.getClient().sendSMS(mobiles,
						messageContent, priority);
				return res == 0 ? 1 : 0;

			} else {
				log.debug("use gov sms provider");
				sendSMSByGov(mobiles, messageContent);
				return 1;
			}

		} else
			return 0;
	}

	private static void sendSMSByGov(String[] mobiles, String messageContent) {
		HashMap info = new HashMap();
		Random rd = new Random();
		// info.put("receiveUser", "");
		info.put("elseReveive", mobiles[0]);
		info.put("receiveCode", "SMS");
		info.put("receiveTime", "");
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
	}

	/**
	 * 查看亿美SMS短消息余额
	 * 
	 * @return
	 */
	public static double checkBalance() {
		double result = 0;

		try {
			result = SingletonSMSClient.getClient().getBalance();
			result = result / 0.09;
			result = Math.floor(result);
		} catch (Exception e) {
			// TODO: Add catch code
			e.printStackTrace();
		}

		return result;
	}

	public synchronized static void setEnabled(boolean enabled) {
		SMSManager.enabled = enabled;
	}

	public synchronized static boolean isEnabled() {
		return enabled;
	}

	public static boolean isUseEmay() {
		return useEmay;
	}

	public static void setUseEmay(boolean useEmay) {
		SMSManager.useEmay = useEmay;
	}
}