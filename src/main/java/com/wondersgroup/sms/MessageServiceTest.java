

/**
 * MessageServiceTest.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis2 version: 1.4.1  Built on : Aug 19, 2008 (10:13:39 LKT)
 */
package com.wondersgroup.sms;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Random;
import java.util.UUID;

import com.wondersgroup.sms.MessageServiceStub.ArrayOfstring;
import com.wondersgroup.sms.MessageServiceStub.Credential;
import com.wondersgroup.sms.MessageServiceStub.GetMessageState;
import com.wondersgroup.sms.MessageServiceStub.GetMessageStateResponse;
import com.wondersgroup.sms.MessageServiceStub.Message;
import com.wondersgroup.sms.MessageServiceStub.MessageState;
import com.wondersgroup.sms.MessageServiceStub.SendMessageToCenter;
import com.wondersgroup.sms.MessageServiceStub.SendMessageToCenterResponse;
import com.wondersgroup.sms.MessageServiceStub.SenderType;


    /*
     *  MessageServiceTest Junit test case	pst 追加
    */

    public class MessageServiceTest //extends junit.framework.TestCase
    {

    	//static String url="http://192.168.11.233:20001/MessageService/service";	//测试服务器地址
    	static String url="http://31.0.128.91:20001/MessageService/service";		//真实服务器地址
    	
        /**
         * Auto generated test method
         */
        public  void testGetReceiveMessage() throws java.lang.Exception{

        com.wondersgroup.sms.MessageServiceStub stub =
                    new com.wondersgroup.sms.MessageServiceStub();//the default implementation should point to the right endpoint

           com.wondersgroup.sms.MessageServiceStub.GetReceiveMessage getReceiveMessage10=
                                                        (com.wondersgroup.sms.MessageServiceStub.GetReceiveMessage)getTestObject(com.wondersgroup.sms.MessageServiceStub.GetReceiveMessage.class);
                    // TODO : Fill in the getReceiveMessage10 here
                
//                        assertNotNull(stub.GetReceiveMessage(getReceiveMessage10));
                        stub.GetReceiveMessage(getReceiveMessage10);

        }
        
        /**
         * Auto generated test method
         */
        public  void testUpdateReceiveMessageStatus() throws java.lang.Exception{

        com.wondersgroup.sms.MessageServiceStub stub =
                    new com.wondersgroup.sms.MessageServiceStub();//the default implementation should point to the right endpoint

           com.wondersgroup.sms.MessageServiceStub.UpdateReceiveMessageStatus updateReceiveMessageStatus12=
                                                        (com.wondersgroup.sms.MessageServiceStub.UpdateReceiveMessageStatus)getTestObject(com.wondersgroup.sms.MessageServiceStub.UpdateReceiveMessageStatus.class);
                    // TODO : Fill in the updateReceiveMessageStatus12 here
                
//                        assertNotNull(stub.UpdateReceiveMessageStatus(updateReceiveMessageStatus12));
                        stub.UpdateReceiveMessageStatus(updateReceiveMessageStatus12);
                  



        }
        
        /**
         * Auto generated test method
         */
        public  GetMessageStateResponse testGetMessageState() throws java.lang.Exception{

        com.wondersgroup.sms.MessageServiceStub stub =
                    new com.wondersgroup.sms.MessageServiceStub();//the default implementation should point to the right endpoint

           com.wondersgroup.sms.MessageServiceStub.GetMessageState getMessageState14=
                                                        (com.wondersgroup.sms.MessageServiceStub.GetMessageState)getTestObject(com.wondersgroup.sms.MessageServiceStub.GetMessageState.class);
                    // TODO : Fill in the getMessageState14 here
                
//                        assertNotNull(stub.GetMessageState(getMessageState14));
                        
           return stub.GetMessageState(getMessageState14);
                  
        }
        
        /**
         * Auto generated test method
         */
        public  void testGetMessageApplictionList() throws java.lang.Exception{

        com.wondersgroup.sms.MessageServiceStub stub =
                    new com.wondersgroup.sms.MessageServiceStub();//the default implementation should point to the right endpoint

           com.wondersgroup.sms.MessageServiceStub.GetMessageApplictionList getMessageApplictionList16=
                                                        (com.wondersgroup.sms.MessageServiceStub.GetMessageApplictionList)getTestObject(com.wondersgroup.sms.MessageServiceStub.GetMessageApplictionList.class);
                    // TODO : Fill in the getMessageApplictionList16 here
                
//           assertNotNull(stub.GetMessageApplictionList(getMessageApplictionList16));
           stub.GetMessageApplictionList(getMessageApplictionList16);



        }
        
        /**
         * Auto generated test method
         */
        public static  void testSendMessageToCenter() throws java.lang.Exception{

        MessageServiceStub stub = new MessageServiceStub();//the default implementation should point to the right endpoint

           com.wondersgroup.sms.MessageServiceStub.SendMessageToCenter sendMessageToCenter18=
                                                        (com.wondersgroup.sms.MessageServiceStub.SendMessageToCenter)getTestObject(com.wondersgroup.sms.MessageServiceStub.SendMessageToCenter.class);
                    // TODO : Fill in the sendMessageToCenter18 here
                
                        //assertNotNull(stub.SendMessageToCenter(sendMessageToCenter18));
                        stub.SendMessageToCenter(sendMessageToCenter18);
        }
        
        //Create an ADBBean and provide it as the test object
        public static org.apache.axis2.databinding.ADBBean getTestObject(java.lang.Class type) throws java.lang.Exception{
           return (org.apache.axis2.databinding.ADBBean) type.newInstance();
        }

        
        /** 
         * 发送消息 
         * 调用Web service中的SendMessageToCenter 发送信息
         * @return SendMessageToCenterResponse
         * 
         * 
         **/
        public static SendMessageToCenterResponse SendMessageToCenter(HashMap info) throws java.lang.Exception{
            try{
            	//设置参数
        	SendMessageToCenter sendMessageToCenter = new SendMessageToCenter();
        	/********************测试数据 开始******************************/
//        	String useraccount = "xzsp";
//        	String username = "行政审批";
//        	String corpcode = "ShangWuWei";
//        	String corpname = "长宁商务委";
        	 String useraccount = "xzsp";
             String username = "长宁公证处";
             String corpcode = "SiFaJu";
             String corpname = "区司法局";
        	/********************测试数据 结束******************************/
        	String receiveUser = (String)info.get("receiveUser");				// "pengst";   //接收人，测试时可修改此处内容
        	String elseReveive=(String)info.get("elseReveive");                             //直接发送到手机号
        	String receiveTime = (String)info.get("receiveTime");				//接收时间，测试时如需立即发送，可将此变量置为空
        	String content =  (String)info.get("content");
        	String receiveCode = "SMS";
        	Message msg = new Message();

        	msg.set_messageid(UUID.randomUUID().toString());
        	msg.set_title("行政审批");					//消息标题
            msg.set_content(content);					//消息内容
            msg.set_sendercode(useraccount);			//发送人编号
            msg.set_sendername(username);				//发送人姓名
            msg.set_sendertype(SenderType.User);		//发送类别（个人、系统）
            msg.set_sendercorpcode(corpcode);			//发送人单位编号
            msg.set_sendercorpname(corpname);			//发送人单位名称
            msg.set_sendappcode("CNBLSP");				//发送消息系统的编号
            
            //接收消息人编号
            ArrayOfstring receiveusercodes = new ArrayOfstring();
//            receiveusercodes.setString(new String[]{receiveUser});//用户组
            if(receiveUser!=null&&!receiveUser.equals("")){
            	System.out.println("adding user into recerver list...");
            	receiveusercodes.setString(receiveUser.split(","));	//用户组
            }
            msg.set_receiveusercodes(receiveusercodes);			
            
			//其他发送人（手机）
			//OA系统以外用户，可通过此方式发送，如无此类用户则传空值
			ArrayOfstring elseReveiveUsers = new ArrayOfstring();
			if(elseReveive!=null&&!elseReveive.equals("")){
				System.out.println("adding user into recerver list...");
				elseReveiveUsers.setString(elseReveive.split(","));
			}
			msg.set_elseReveiveUsers(elseReveiveUsers);	
            
            //接收消息系统编号
            ArrayOfstring receiveappcodes = new ArrayOfstring();
            receiveappcodes.setString(receiveCode.split(","));	//发送手机短信+邮件
            msg.set_receiveappcodes(receiveappcodes);	
            

            //定时发送时间	
            Calendar data = new GregorianCalendar();
            Date time = new Date();
            //接受时间为空，为立即发送，有数字，则表示定时发送
            //在传入的日期后加上时分秒
            if(receiveTime!=null&&!receiveTime.trim().equals("")){
            	System.out.println("send for later");
            	
            	//format yyyMMdd hhmmss
            	receiveTime += " 090000";
        		Locale locale = Locale.CHINA;
        		
        	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss",locale);
        	    time=formatter.parse(receiveTime); 
        		
            }
            /********************************************************************
             * 由于服务器时间与实际时间相差14小时，因此在发送时间中需减去14小时的时差
             * 如在本地环境中，需将下面代码注释
             */
//            time.setTime(time.getTime()- 50400000L);
            /*******************************************************************/
            data.setTime(time);
			msg.set_sendtime(data);		
            

//            //定时发送时间	
//            //此处时间为立即发送，具体发送时间需待确认
//            Calendar data = new GregorianCalendar();
//            Date trialTime = new Date();
//            data.setTime(trialTime);
//            msg.set_sendtime(data);		
	    	Credential cre = new Credential();
//	        cre.set_AppCode("CNBLSP");					//发送消息系统的编号
//	        cre.set_Password("1234");					//发送消息密码
	    	 
	         cre.set_AppCode("CNGZWSFWDT"); //发送消息系统的编号
	         cre.set_Password("cngzc6408"); //发送消息密码
	        
	        sendMessageToCenter.setMessage(msg);
        	sendMessageToCenter.setCredential(cre);

			 /***************************发送短信****************************************/
        	MessageThread mt=new MessageThread();
        	mt.setStc(sendMessageToCenter);
        	mt.start();
            }catch (Exception e){
            	e.printStackTrace();
            }
			return null;
			 /**************************************************************************/
			
			 /***************************本地环境中使用此段代码，避免发送测试数据****************************************/
			 /****************************************************************************************************/
        }

        /**
         * Auto generated test method
         */
        public  MessageState[] GetMessageState(GetMessageState gms) throws java.lang.Exception{

        	MessageServiceStub stub = new MessageServiceStub(url);

        	GetMessageStateResponse gmsr = stub.GetMessageState(gms);
        	MessageState[] ms = (gmsr.getGetMessageStateResult()).getMessageState();
        	
        	return ms;
                  
        }
        /**
         * 根据消息ID取得消息发送状态
         **/
        public HashMap getMessageState(HashMap[] xxtxfsjlDto){
        	HashMap hmState = new HashMap();
        	try {
				if(xxtxfsjlDto == null || xxtxfsjlDto.length<1){
					return null;
				}
				
		    	for(int i=0;i<xxtxfsjlDto.length;i++){
		    		String[] guid = xxtxfsjlDto[i].get("guid").toString().split(",");
		        	String stateTmp = "";
		        	for(int j=0;j<guid.length;j++){
			        	GetMessageState gms = new GetMessageState();
			        	gms.setMessageID(guid[j]);
			        	//将结果以MsgId为Key，存入HashMap
			        	MessageState[] ms = GetMessageState(gms);
			        	stateTmp += state(ms);
		        	}
		        	hmState.put(xxtxfsjlDto[i].get("guid").toString(), stateTmp);
		    	}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	return hmState;
        }
        
        private String state(MessageState[] ms){
        	StringBuffer stateBuffer = new StringBuffer();
        	//返回结果为空时跳出本次操作
        	if(ms != null){
//            	for(int i=0;i<ms.length;i++){
        		String state = ms[0].get_state().toString();
        		//判断发送状态
        		if(("DELIVRD").equals(state)){
        			//已发送
        			state = "0";
        		}else if(("UNDELIV").equals(state)){
        			//失败
        			state = "1";
        		}else if(("UnDefine").equals(state)){
        			//发送中
        			state = "2";
        		}
        		stateBuffer.append(state);
        		stateBuffer.append(",");
//            	}
        	}else{
        		stateBuffer.append("2");
        		stateBuffer.append(",");
        	}
        	
        	return stateBuffer.toString();
        }
        
        public  static void main(String args[]) throws Exception{
        	HashMap info=new HashMap();
        	Random rd=new Random();
        	//info.put("receiveUser", "");
        	info.put("elseReveive","18621910893");
        	info.put("receiveCode", "SMS");
        	info.put("receiveTime","");
        	info.put("content", "测试内容1ss");
        	info.put("msgId", java.util.UUID.randomUUID().toString());
        	SendMessageToCenter(info);
        	System.out.println(java.util.UUID.randomUUID().toString());
        }
    }
    