package com.xiangyun.notary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	 @RequestMapping(value = "/home.do")
	    public ModelAndView goToHome() {
	    	ModelAndView mav = new ModelAndView("home");
	    	mav.addObject("title", "网上办证");
	    	return mav;
	    }

}
