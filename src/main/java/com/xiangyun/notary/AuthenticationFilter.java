package com.xiangyun.notary;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuthenticationFilter implements Filter {
	private static final Logger log = LoggerFactory.getLogger(AuthenticationFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// Do nothing
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		log.debug("Context Path : {}", req.getContextPath());
		log.debug("Servlet Path : {}", req.getServletPath());
		
		String servletPath = req.getServletPath();
		if (servletPath.indexOf("/home") >= 0 
				|| servletPath.indexOf("/enterLogin") >= 0 
				|| servletPath.indexOf("/login") >= 0				
				|| servletPath.indexOf("/onPaymentReturn.do")>=0
				|| servletPath.indexOf("/onPaymentNotify.do")>=0				
				|| servletPath.indexOf("/onRefundNotify.do")>=0
				|| servletPath.indexOf("/whichUser.do")>=0) {
			chain.doFilter(request, response);
			return;
		}
		
		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute(Constants.LOGIN_USER) == null) {
			log.debug("Not logging yet. Redirecting to login page...");
			resp.sendRedirect(req.getContextPath() + "/enterLogin.do");
			return;
		}
		
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// Do nothing
	}

}
