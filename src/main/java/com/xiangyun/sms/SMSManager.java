package com.xiangyun.sms;

public class SMSManager {

    private static boolean enabled = false;
    private static String SURFFIX = " 【长宁公证】";

    //发送SMS
    public static int sendSMS(String[] mobiles, String messageContent, int priority) {
//        System.err.println("here");
        if (enabled){
            messageContent += SURFFIX;
//            System.err.println("sent sms");
            return SingletonSMSClient.getClient().sendSMS(mobiles, messageContent, priority);
        }
        else
            return 0;
    }

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
}