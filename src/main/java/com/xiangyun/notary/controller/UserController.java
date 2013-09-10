package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.CredentialType;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.Encrypt;
import com.xiangyun.notary.common.Gender;
import com.xiangyun.notary.common.Language;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.service.UserService;
import com.xiangyun.sms.SMSManager;

@Controller
public class UserController {

	private static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	/**
	 * 进入注册页面
	 * 
	 * @author binbin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/enterRegister.do")
	public ModelAndView enterRegister() {
		User user = new User();
		ModelAndView mav = new ModelAndView();
		mav.addObject("user", null);
		mav.setViewName("register");
		return mav;
	}

	/**
	 * 进入登陆页面
	 * 
	 * @author binbin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/enterLogin.do")
	public ModelAndView enterLogin() {
		User user = new User();
		ModelAndView mav = new ModelAndView();
		mav.addObject("title", "用户登录");
		mav.addObject("user", null);
		mav.setViewName("login");
		return mav;
	}
	
	/**
	 * 进入信息维护页面
	 * 
	 * @author binbin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/enterModify.do")
	public ModelAndView enterModify(HttpServletRequest request) {
		User user = (User) request.getSession(true).getAttribute("LOGIN_USER");
		ModelAndView mav = new ModelAndView();
		mav.addObject("user", user);
		mav.setViewName("modify");
		return mav;
	}

	/**
	 * 用户注册
	 * 
	 * @author binbin
	 * @param
	 * @return
	 * @throws IOException
	 */
    @RequestMapping(value = "register.do")
    public ModelAndView register(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        ModelAndView mav = new ModelAndView();
        user.setPassword(Encrypt.e(user.getPassword()));
        userService.save(user);
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.LOGIN_USER, user);
        mav.addObject("user", user);
        mav.setViewName("modify");
        return mav;
    }

	/**
	 * 检查手机号码是否存在
	 * 
	 * @author binbin
	 * @param request
	 * @param response
	 * @param mobile
	 */
	@RequestMapping(value = "checkRegisterMobile.do")
	public void checkRegisterMobile(String mobile,HttpServletRequest request,HttpServletResponse response) throws IOException {
		User u = userService.findByMobile(mobile);
		PrintWriter out = response.getWriter(); 
		if (u==null){
			out.println(0);
		}else{
			out.println(1);
		};
		
	}

	/**
	 * 短信验证
	 */
	@RequestMapping(value = "checkMessageProv.do")
	public void checkMessageProv(String mobile, HttpServletRequest request) {
		int checksmscode = this.creatCode();
		log.debug("SMS check code is: {}", checksmscode);
		HttpSession session = request.getSession(true);
		session.setAttribute("SMSCODE", checksmscode);
		System.out.println(mobile);
		SMSManager.sendSMS(new String[] { mobile }, "感谢您使用上海长宁公证处网上公证平台，您的验证码为："
				+ checksmscode, 1);		
		
		try {
			System.out.println("Available SMS: "
					+ Math.floor(SMSManager.checkBalance()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.err.println("ended!");
	}

	/**
	 * 生成6位随机验证码
	 */
	public int creatCode() {
		Random random = new Random();
		int smsCode = random.nextInt(999999);
		if (smsCode > 100000);
		return smsCode;
	}
	
	/**
	 * 注册页面检查短信验证码
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "checkSMSCode.do")
	public void checkSMSCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String smscodeString = String.valueOf(session.getAttribute("SMSCODE"));
		PrintWriter out = response.getWriter();
		if (!request.getParameter("reg_user_smscode").equals(smscodeString)) {
			out.println(0);
		}else{
			out.println(1);
		}

		
	}
	/**
	 * 修改页面检查短信验证码
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "checkSMSCode1.do")
	public void checkSMSCode1(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String smscodeString = String.valueOf(session.getAttribute("SMSCODE"));
		PrintWriter out = response.getWriter();
		if (!request.getParameter("modify_user_smscode").equals(smscodeString)) {
			out.println(0);
		}else{
			out.println(1);
		}
	}
	/**
	 * 找回页面检查短信验证码
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "checkSMSCode2.do")
	public void checkSMSCode2(HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String smscodeString = String.valueOf(session.getAttribute("SMSCODE"));
		PrintWriter out = response.getWriter();
		if (!request.getParameter("forget_user_smscode").equals(smscodeString)) {
			out.println(0);
		}else{
			out.println(1);
		}
	}
	
	/**
	 * 用户登录
	 * 
	 * @author binbin
	 * @param user
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login.do")
	public ModelAndView login(HttpServletRequest request, User user) {
		User u = userService.findByMobile(user.getMobile());
		ModelAndView mav = new ModelAndView();
		String msg = null;
		if (u == null) {
			msg = "输入的手机号码和密码不匹配，请重试！";
			mav.addObject("msg", msg);
			mav.addObject("title", "用户登录");
			mav.setViewName("login");
		} else if (!u.getPassword().equals(Encrypt.e(user.getPassword()))) {
			msg = "输入的手机号码和密码不匹配，请重试！";
			mav.addObject("msg", msg);
			mav.addObject("title", "用户登录");
			mav.setViewName("login");
		} else {
			HttpSession session = request.getSession();
			session.setAttribute(Constants.LOGIN_USER, u);
			String targetURL = (String)session.getAttribute("openURL");
//			mav.addObject("user", u);
//			mav.addObject("title", "个人信息");
			mav.setViewName("redirect:"+targetURL);
		}
		return mav;
	}
	
	@RequestMapping(value = "/logout.do")
	public ModelAndView logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) 
			session.invalidate();
		
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}

	/**
	 * 修改用户资料
	 * 
	 * @author binbin
	 * @param request
	 * @param user
	 */
	@RequestMapping(value = "/modify.do")
	public ModelAndView modify(HttpServletRequest request, User user) {
		ModelAndView mav = new ModelAndView();
		User u = userService.findByMobile(((User)request.getSession(true).getAttribute(Constants.LOGIN_USER)).getMobile());
		u.setGender(user.getGender());
		u.setAddress(user.getAddress());
		u.setEmail(user.getEmail());
		u.setName(user.getName());
		u.setCredentialType(user.getCredentialType());
		u.setCredentialId(user.getCredentialId());
		userService.save(u);
		
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.LOGIN_USER, u);
		return mav;
	}

	
	/**
	 * 修改用户密码
	 * 
	 * @author binbin
	 * @param request
	 * @param user
	 * @throws IOException 
	 */
	@RequestMapping(value = "/modifyPwd.do")
	public void modifyPwd(HttpServletRequest request, HttpServletResponse response) throws IOException {
		User u = userService.findByMobile(((User)request.getSession(true).getAttribute(Constants.LOGIN_USER)).getMobile());
		u.setPassword(Encrypt.e(request.getParameter("password")));
		userService.save(u);
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.LOGIN_USER, u);
		PrintWriter out = response.getWriter();
		out.println("修改成功！");
	}
	/**
	 * 进入忘记密码页面
	 * 
	 * @author binbin
	 * @param
	 * @return
	 */
	@RequestMapping(value = "/enterForget.do")
	public ModelAndView enterForget() {
		User user = new User();
		ModelAndView mav = new ModelAndView();
		mav.addObject("user", null);
		mav.setViewName("forget");
		return mav;
	}

	/**
	 * 忘记密码
	 * 
	 * @author binbin
	 * @param user
	 * @param request
	 */
	@RequestMapping("/forget.do")
	public ModelAndView forget(User user, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User u = userService.findByMobile(user.getMobile());
			u.setPassword(Encrypt.e(user.getPassword()));
			userService.save(u);
			HttpSession session = request.getSession(true);
			session.setAttribute(Constants.LOGIN_USER, u);
			mav.addObject("user", u);
			mav.setViewName("modify");
		return mav;
	}
	
	/**
	 * 
	 * @param response
	 */
	@RequestMapping(value = "/whichUser.do")
	public void whichUser(HttpServletRequest request,HttpServletResponse response)  {
		try {
			HttpSession session = request.getSession(true);
			User u = (User)session.getAttribute(Constants.LOGIN_USER);
			if(u!=null){
				String userName = u.getName();
				String mobile = u.getMobile();
				String email = u.getEmail();
				StringBuffer buffer = new StringBuffer();
				buffer.append("{\"UserName\":\"");
				buffer.append(userName);
				buffer.append("\",");
				buffer.append("\"UserPhone\":\"\",");
				buffer.append("\"UserMobile\":\"");
				buffer.append(mobile);
				buffer.append("\",");
				buffer.append("\"UserFax\":\"\",");
				buffer.append("\"UserQQ\":\"\",");
				buffer.append("\"UserMSN\":\"\",");
				buffer.append("\"UserEmail\":\"");
				buffer.append(email);
				buffer.append("\",");
				buffer.append("\"UserCompany\":\"\",");
				buffer.append("\"UserAddress\":\"\"");
				buffer.append("}");
				
				response.getWriter().print(buffer.toString());
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
