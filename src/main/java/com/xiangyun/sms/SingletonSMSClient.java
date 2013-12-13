package com.xiangyun.sms;

import java.util.Date;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import cn.emay.sdk.client.api.Client;

public class SingletonSMSClient {

	private static Client client = null;
	// 开发环境账号
	// public static String password="220235";

	// HJY环境账号
	//public static String password = "704168";

	// CNGZC环境账号
	 public static String password = "993873";

	private SingletonSMSClient() {
	}

	public synchronized static Client getClient(String softwareSerialNo,
			String key) {
		if (client == null) {
			try {
				client = new Client(softwareSerialNo, key);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return client;
	}

	/**
	 * 注册
	 * @return
	 */
	public static String register() {

		int i = getClient().registEx(password);
		System.out.println("注册结果:" + i);

		return new Integer(i).toString();
	}
	
	/**
	 * 注销
	 * @return
	 */
	public static String logout() {

		int i = getClient().logout();
		System.out.println("注册结果:" + i);

		return new Integer(i).toString();
	}

	public synchronized static Client getClient() {
		ResourceBundle bundle = PropertyResourceBundle.getBundle("config");
		if (client == null) {
			try {
				client = new Client(bundle.getString("softwareSerialNo"),
						bundle.getString("key"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return client;
	}

	// 执行一次，激活账号
	public static void main(String str[]) {
		Client theclient = SingletonSMSClient.getClient();
		//int result = theclient.serialPwdUpd(password, "800809");
		//System.out.println("result: " + result);
		// No need to register again, because we have already register it.
		// int i = theclient.registEx(password);
		// System.out.println("注册结果:" + i);

		 theclient.sendSMS(new String[] { "13621927920","18221889387" },
		 "测试短信,发送时间： " + new Date() + ",请查看是否收到及时 【长宁公证】", 1);
		try {
			System.out.println("Available SMS: "
					+ Math.floor(theclient.getBalance() / 0.09));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.err.println("ended!");
	}
}
