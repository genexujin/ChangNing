package com.xiangyun.notary.controller;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.ChatMessage;
import com.xiangyun.notary.domain.ChatThread;
import com.xiangyun.notary.domain.User;

@Controller
public class ChatHistoryController {
	private static Logger log = LoggerFactory.getLogger(ChatHistoryController.class);
	private static String dbURL;
    private static String queryThreadStmt="select threadid, userName, agentName, dtmcreated,dtmmodified from chatthread where referer like ?";
    private static String queryThreadByIdStmt="select threadid, userName, agentName, dtmcreated,dtmmodified from chatthread where threadid = ?";
    private static String queryMsgStmt="select messageid, threadid, ikind, tmessage,dtmcreated,tname from chatmessage where threadid = ? and ikind<=3 order by messageid";
	
	static {
		Properties prop = new Properties();
		InputStream in = ChatHistoryController.class.getClassLoader().getResourceAsStream("config.properties");
		try {
			prop.load(in);
			dbURL = prop.getProperty("chatDBURL");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 *  查看聊天thread
	 * @param request
	 * @param mobile
	 * @return
	 */
	@RequestMapping(value = "/checkChatHistory")
	public ModelAndView checkChatHistory(HttpServletRequest request,
			@RequestParam("mobile") String mobile) {

		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);
		
		ModelAndView mv = null;
		if (user != null && (user.isAdmin() || user.isStaff())&&mobile!=null) {
			
			log.debug("checking chat history for: " + mobile);
			ChatThread theThread = null;
			ArrayList<ChatThread> threads = new ArrayList<ChatThread>();
			Connection conn = this.getConnection();
			try {
				PreparedStatement ps = conn.prepareStatement(queryThreadStmt);
				ps.setString(1, "%"+mobile+"%");
				ResultSet rs = ps.executeQuery();
				Calendar cal = Calendar.getInstance();
				
				while(rs.next()){
					theThread =  new ChatThread();					
					theThread.setAgentName(rs.getString("agentName"));
					//矫正时间
					cal.setTimeInMillis(rs.getTimestamp("dtmmodified").getTime());
					cal.add(Calendar.HOUR_OF_DAY, -12);								
					theThread.setThreadEnd(new Date(cal.getTimeInMillis()));
					//矫正时间
					cal.setTimeInMillis(rs.getTimestamp("dtmcreated").getTime());
					cal.add(Calendar.HOUR_OF_DAY, -12);					
					theThread.setThreadStart(new Date(cal.getTimeInMillis()));
					
					theThread.setUserName(rs.getString("userName"));
					theThread.setThreadid(rs.getInt("threadid"));					
					threads.add(theThread);
				}
				log.debug("thread size: " +  threads.size());
				mv = new ModelAndView("chatHistoryThread");
				mv.addObject("threads", threads);
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				this.closeConnection(conn);
			}

			return mv;

		} else {
			return null;
		}

	}
	
	/**
	 *  查看聊天thread
	 * @param request
	 * @param mobile
	 * @return
	 */
	@RequestMapping(value = "/chatDetail")
	public ModelAndView chatDetail(HttpServletRequest request,
			@RequestParam("threadid") int threadid) {

		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);
		
		ModelAndView mv = null;
		if (user != null && (user.isAdmin() || user.isStaff())) {
			
			log.debug("checking chat details for: " + threadid);
			ChatThread thread =null;
			ArrayList<ChatMessage> messages = new ArrayList<ChatMessage>();
			Connection conn = this.getConnection();
			try {
				PreparedStatement ps = conn.prepareStatement(queryThreadByIdStmt);
				ps.setInt(1, threadid);
				ResultSet rs = ps.executeQuery();
				Calendar cal = Calendar.getInstance();
				
				if(rs.next()){
					thread = new ChatThread();
					thread.setAgentName(rs.getString("agentName"));
					//矫正时间
					cal.setTimeInMillis(rs.getTimestamp("dtmmodified").getTime());
					cal.add(Calendar.HOUR_OF_DAY, -12);								
					thread.setThreadEnd(new Date(cal.getTimeInMillis()));
					//矫正时间
					cal.setTimeInMillis(rs.getTimestamp("dtmcreated").getTime());
					cal.add(Calendar.HOUR_OF_DAY, -12);					
					thread.setThreadStart(new Date(cal.getTimeInMillis()));
					thread.setUserName(rs.getString("userName"));
					thread.setThreadid(rs.getInt("threadid"));
					
					
					PreparedStatement ps1 = conn.prepareStatement(queryMsgStmt);
					ps1.setInt(1, threadid);
					ResultSet rs1 = ps1.executeQuery();
					while(rs1.next()){
						ChatMessage msg = new ChatMessage();
						msg.setContent(rs1.getString("tmessage"));
						msg.setTname(rs1.getString("tname"));
						msg.setIkind(rs1.getInt("ikind"));
						//矫正时间
						cal.setTimeInMillis(rs1.getTimestamp("dtmcreated").getTime());
						cal.add(Calendar.HOUR_OF_DAY, -12);							
						msg.setMsgTime(new Date(cal.getTimeInMillis()));						
						messages.add(msg);
					}
					
				}
				log.debug("messages size: " +  messages.size());
				mv = new ModelAndView("chatDetail");
				mv.addObject("messages", messages);
				mv.addObject("thread",thread);
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				this.closeConnection(conn);
			}

			return mv;

		} else {
			return null;
		}

	}
	
	/**
	 * 获取链接
	 * @return
	 */
	public Connection getConnection() {
		Connection con = null;	//创建用于连接数据库的Connection对象
		try {
			Class.forName("com.mysql.jdbc.Driver");// 加载Mysql数据驱动
			
			con = DriverManager.getConnection(
					dbURL);// 创建数据连接
			
		} catch (Exception e) {
			System.out.println("数据库连接失败" + e.getMessage());
		}
		return con;	//返回所建立的数据库连接
	}
	
	/**
	 * 关闭链接
	 * @param con
	 */
	public void closeConnection(Connection con) {
		
		try {
			if(con!=null){
				con.close();
			}			
		} catch (Exception e) {
			System.out.println("数据库关闭失败" + e.getMessage());
		}
	}



}
