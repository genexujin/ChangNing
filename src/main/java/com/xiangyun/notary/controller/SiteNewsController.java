package com.xiangyun.notary.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.SiteNews;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.service.SiteNewsService;

@Controller
public class SiteNewsController {

	private static Logger log = LoggerFactory
			.getLogger(SiteNewsController.class);

	@Autowired
	private SiteNewsService siteNewsService;

	@RequestMapping(value = "/listSiteNews.do")
	public ModelAndView goToHome(HttpServletRequest request) {

		// 如果不是管理员，则不能进入该页面
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if (!user.isAdmin())
			return null;

		ModelAndView mav = new ModelAndView("backend/siteNews");
		mav.addObject("title", "站点通知");

		List<SiteNews> news = siteNewsService.findAll();
		SiteNews theNews = (news == null || news.isEmpty()) ? new SiteNews()
				: (SiteNews) news.get(0);
		mav.addObject("id", theNews.getId());
		mav.addObject("content", theNews.getContent());

		return mav;
	}

	@RequestMapping(value = "/updateSiteNews.do")
	public ModelAndView updateSiteNews(SiteNews news, Long news_id,
			HttpServletRequest request) {

		// 如果不是管理员，则不能进入该页面
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		if (!user.isAdmin())
			return null;
		
		
		ModelAndView mav = new ModelAndView("backend/siteNews");
		mav.addObject("title", "站点通知");
				
		news = siteNewsService.save(news);	
		
		request.getSession().getServletContext()
		.setAttribute("theNews", news.getContent());
		
		mav.addObject("id", news.getId());
		mav.addObject("content", news.getContent());
		mav.addObject("success", "Y");
		
		return mav;

	}

}
