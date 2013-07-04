package com.xiangyun.sms;

import java.util.Date;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import cn.emay.sdk.client.api.Client;

public class SingletonSMSClient {

    private static Client client = null;
    //开发环境账号
    public static String password="220235";

    private SingletonSMSClient() {
    }

    public synchronized static Client getClient(String softwareSerialNo, String key) {
        if (client == null) {
            try {
                client = new Client(softwareSerialNo, key);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return client;
    }

    public synchronized static Client getClient() {
        ResourceBundle bundle = PropertyResourceBundle.getBundle("config");
        if (client == null) {
            try {
                client = new Client(bundle.getString("softwareSerialNo"), bundle.getString("key"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return client;
    }

    //执行一次，激活账号
    public static void main(String str[]) {
        Client theclient = SingletonSMSClient.getClient("0SDK-EBB-0130-NEVNN", "222769");
        //No need to register again, because we have already register it.
//        int i = theclient.registEx(password);
//        System.out.println("注册结果:" + i);

        theclient.sendSMS(new String[] { "13524173173" },
                          "测试短信,发送时间： " + new Date() + ",请查看是否收到及时 【祥韵公司】", 1);
        try {
			System.out.println("Available SMS: " +  Math.floor(theclient.getBalance() / 0.09));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.err.println("ended!");        
    }
}
