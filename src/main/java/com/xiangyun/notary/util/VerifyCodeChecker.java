package com.xiangyun.notary.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.xiangyun.notary.Constants;

public class VerifyCodeChecker {

	public static boolean isCodeValid(String code, HttpServletRequest request) {
		boolean result = true;
		HttpSession session = request.getSession();
		String verifyCodeinSession = (String) session
				.getAttribute(Constants.VERIFY_SESSION_KEY);
		if (code != null && verifyCodeinSession != null) {
			if (!code.equals(verifyCodeinSession)){
				result = false;				
			}
		} else
			result = false;
		
		//验证码只能用一次
		session.setAttribute(Constants.VERIFY_SESSION_KEY, null);
		
		return result;
	}

}
