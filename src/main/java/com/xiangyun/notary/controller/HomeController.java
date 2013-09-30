package com.xiangyun.notary.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	public void registerSMS(HttpServletResponse response) throws Exception {
		String msg = SingletonSMSClient.register();
		PrintWriter out = response.getWriter();
		out.print(msg);
	}

	@RequestMapping(value = "/smsLogout.do")
	public void logoutSMS(HttpServletResponse response) throws Exception {
		String msg = SingletonSMSClient.logout();
		PrintWriter out = response.getWriter();
		out.print(msg);
	}

}
