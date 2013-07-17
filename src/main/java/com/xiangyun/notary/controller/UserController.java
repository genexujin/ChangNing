package com.xiangyun.notary.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.emay.sdk.client.api.Client;

import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.CredentialType;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.Encrypt;
import com.xiangyun.notary.common.Gender;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.service.UserService;
import com.xiangyun.sms.SMSManager;
import com.xiangyun.sms.SingletonSMSClient;

@Controller
public class UserController {

	private static Logger log = LoggerFactory.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/createUser.do")
	public ModelAndView createUser() {

		Order o = new Order();
		o.setCertificateCopyCount(2);
		o.setCertificatePurpose(CertificatePurpose.RESIDENCE);
		o.setDestination(DestinationCountry.GERMANY);
		o.setNeedTranslation(true);
		o.setOrderDate(new Date());
		o.setOrderStatus(OrderStatus.SUBMITTED);
		o.setPaymentPaid(0);
		o.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
		o.setPaymentTotal(240);
		o.setVisitForDoc(false);

		User u = new User();
		u.setAddress("adresssss");
		u.setBirthDate(new Date());
		u.setCredentialType(CredentialType.ID_CARD);
		u.setEmail("pairliu@gmail.com");
		u.setMobile("1351111111");
		u.setName("刘峻");
		u.setPassword("abcd1234");
		u.setCredentialId("132412341");
		u.setGender(Gender.MALE);
		// The relation is managed in this method for both ends.
		u.addOrder(o);

		// This will also create the new Order entry, as CascadeType.PERSIST is
		// set on the relationship.
		u = userService.save(u);

		ModelAndView mav = new ModelAndView("user");
		mav.addObject("user", u);

		return mav;
	}

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
	public ModelAndView register(User user, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		ModelAndView mav = new ModelAndView();
		String msg = null;
		HttpSession session = request.getSession();
		String smscodeString = String.valueOf(session.getAttribute("SMSCODE"));
		if (!request.getParameter("reg_user_smscode").equals(smscodeString)) {
			msg = "短信验证码错误！";
			mav.addObject("msg", msg);
			mav.setViewName("regErrPage");
		}else if (checkRegisterMobile(user)) {
			msg = "用户已经存在，请检查手机号码或者直接登陆！";
			mav.addObject("msg", msg);
			mav.setViewName("regErrPage");
		} else {
			user.setPassword(Encrypt.e(user.getPassword()));
			userService.save(user);
			mav.addObject("user", user);
			mav.setViewName("regSuccessPage");
		}
		return mav;
	}

	/**
	 * 检查手机号码是否存在
	 * 
	 * @author binbin
	 * @param user
	 * @return
	 */
	public boolean checkRegisterMobile(User user) {
		Boolean booleanReg = true;
		User u = userService.findByMobile(user.getMobile());
		if (u != null) {
			return booleanReg;
		} else {
			booleanReg = false;
			return booleanReg;
		}
	}

	/**
	 * 短信验证
	 */
	@RequestMapping(value = "checkMessageProv.do")
	public void checkMessageProv(String mobile, HttpServletRequest request) {
		int checksmscode = this.creatCode();
		HttpSession session = request.getSession(true);
		session.setAttribute("SMSCODE", checksmscode);
		Client theclient = SingletonSMSClient.getClient("0SDK-EBB-0130-NEVNN",
				"222769");

		theclient.sendSMS(new String[] { mobile }, "感谢您使用长宁公证处手机认证功能，您的验证码为： "
				+ checksmscode, 1);
		try {
			System.out.println("Available SMS: "
					+ Math.floor(theclient.getBalance() / 0.09));
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
		if (smsCode > 100000)
			;
		return smsCode;
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
			msg = "用户不存在！";
			mav.addObject("msg", msg);
			mav.setViewName("loginErrPage");
		} else if (!u.getPassword().equals(Encrypt.e(user.getPassword()))) {
			msg = "请输入正确密码！";
			mav.addObject("msg", msg);
			mav.setViewName("loginErrPage");
		} else {
			HttpSession session = request.getSession(true);
			session.setAttribute("LOGIN_USER", u);
			mav.addObject("user", u);
			mav.setViewName("loginSuccessPage");
		}
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
		User u = userService.findByMobile(user.getMobile());
		u.setGender(user.getGender());
		u.setAddress(user.getAddress());
		u.setEmail(user.getEmail());
		u.setName(user.getName());
		u.setPassword(Encrypt.e(user.getPassword()));
		u.setCredentialType(user.getCredentialType());
		u.setCredentialId(user.getCredentialId());
		userService.save(u);
		mav.addObject("user", u);
		mav.setViewName("modifySuccessPage");
		return mav;
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
		String msg = null;
		HttpSession session = request.getSession();
		String smscodeString = String.valueOf(session.getAttribute("SMSCODE"));
		if (!request.getParameter("forget_user_smscode").equals(smscodeString)) {
			msg = "短信验证码错误！";
			mav.addObject("msg", msg);
			mav.setViewName("forgetErrPage");
		} else {
			u.setPassword(Encrypt.e(user.getPassword()));
			userService.save(u);
			mav.addObject("user", u);
			mav.setViewName("login");
		}
		return mav;
	}
}