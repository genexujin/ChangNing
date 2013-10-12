package com.xiangyun.notary.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.User;
import com.xiangyun.sms.SingletonSMSClient;

@Controller
public class HomeController {

	@RequestMapping(value = "/home.do")
	public ModelAndView goToHome() {
		ModelAndView mav = new ModelAndView("home");
		mav.addObject("title", "网上办证");
		return mav;
	}

	@RequestMapping(value = "/smsRegister.do")	
	public void registerSMS(HttpServletRequest request,HttpServletResponse response) throws Exception {
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if(!user.isAdmin()) return;
		
		String msg = SingletonSMSClient.register();
		PrintWriter out = response.getWriter();
		out.print(msg);
	}

	@RequestMapping(value = "/smsLogout.do")
	public void logoutSMS(HttpServletRequest request,HttpServletResponse response) throws Exception {
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if(!user.isAdmin()) return;
		
		String msg = SingletonSMSClient.logout();
		PrintWriter out = response.getWriter();
		out.print(msg);
	}

}
