package com.xiangyun.sms;

import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import cn.emay.sdk.client.api.Client;

public class SingletonSMSClient {

    private static Client client = null;
    //开发环境账号
    public static String password="220235";
    
    //生产环境账号
//    public static String password = "704168";

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
//        Client theclient = SingletonSMSClient.getClient("3SDK-EMY-0130-OJXQS", "068075");
//        int i = theclient.registEx(password);
//        System.out.println("注册结果:" + i);
//        //
//        //        theclient.sendSMS(new String[] { "18621910893", "13817245519", "13524173173" },
//        //                          "测试短信,发送时间： " + new Date() + ",请查看是否收到及时 【祥韵公司】", 1);
//        System.err.println("ended!");
//        theclient.registEx(password);
    }
}
