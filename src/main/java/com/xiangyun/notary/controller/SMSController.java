package com.xiangyun.notary.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.User;
import com.xiangyun.sms.SMSManager;

@Controller
public class SMSController {

	private static Logger log = LoggerFactory.getLogger(SMSController.class);

	@RequestMapping(value = "/enterSMS.do")
	public ModelAndView enterSMS(HttpServletRequest request) {

		// 如果不是管理员，则不能进入该页面
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if (!user.isAdmin())
			return null;

		ModelAndView mav = new ModelAndView("backend/smsManage");
		mav.addObject("title", "短信管理");

		mav.addObject("useEmay", SMSManager.isUseEmay());
		mav.addObject("balance", SMSManager.checkBalance());

		return mav;
	}

	@RequestMapping(value = "/sendTestSMS.do")
	public void sendTestSMS(String content, String mobile,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception{
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 如果不是管理员，则不能进入该页面
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if (!user.isAdmin()||mobile==null){
			out.write("{\"success\": \"0\"}");
			return;
		}
		
		int success = SMSManager.sendSMS(mobile.split(" "), content, 1);
		out.write("{\"success\": \""+success+"\"}");
	}

	/**
	 *  切换SMS通道
	 * @param useEmay
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/switchSMSSender.do")
	public void switchSMSSender(String useEmay, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		// 如果不是管理员，则不能进行改操作
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if (!user.isAdmin()) {
			out.write("{\"success\": \"0\"}");
			return;
		}

		log.debug("value set to use emay is:" + useEmay);

		if (useEmay != null && useEmay.equals("Y")) {
			SMSManager.setUseEmay(true);
		} else {
			SMSManager.setUseEmay(false);
		}

		out.write("{\"success\": \"1\"}");

	}

}
