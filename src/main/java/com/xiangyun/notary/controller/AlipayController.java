package com.xiangyun.notary.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipayNotify;
import com.alipay.util.AlipaySubmit;
import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.Payment;
import com.xiangyun.notary.service.OrderService;
import com.xiangyun.notary.service.PaymentService;

@Controller
public class AlipayController {

	private static Logger log = LoggerFactory.getLogger(AlipayController.class);

	@Autowired
	private ServletContext ctx;

	@Autowired
	private OrderService orderService;

	@Autowired
	private PaymentService paymentService;
	
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

	/**
	 * 支付函数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/openPayment.do")
	public void openPayment(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 支付类型
		String payment_type = "1";
		// 必填，不能修改
		// 服务器异步通知页面路径
		String notify_url = "http://hjyoa.hpe.cn:4848/ChangNing/onPaymentNotify.do";
		// 需http://格式的完整路径，不能加?id=123这类自定义参数

		// 页面跳转同步通知页面路径
		String return_url = "http://hjyoa.hpe.cn:4848/ChangNing/onPaymentReturn.do";
		// 需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

		// 卖家支付宝帐户
		String seller_email = Constants.ALIPAY_SELLER_EMAIL;
		// 必填

		// 商户订单号
		String out_trade_no = new String(request
				.getParameter("WIDout_trade_no").getBytes("ISO-8859-1"),
				"UTF-8");
		// 商户网站订单系统中唯一订单号，必填

		// 订单名称
		String subject = new String(request.getParameter("WIDsubject")
				.getBytes("ISO-8859-1"), "UTF-8");
		System.err.println(subject);
		// 必填

		// 付款金额
		String total_fee = new String(request.getParameter("WIDtotal_fee")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 必填

		// 订单描述

		String body = new String(request.getParameter("WIDbody").getBytes(
				"ISO-8859-1"), "UTF-8");
		// 商品展示地址
		String show_url = new String(request.getParameter("WIDshow_url")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html

		// 防钓鱼时间戳
		String anti_phishing_key = "";
		// 若要使用请调用类文件submit中的query_timestamp函数

		// 客户端的IP地址
		String exter_invoke_ip = "";
		// 非局域网的外网IP地址，如：221.0.0.1

		// ////////////////////////////////////////////////////////////////////////////////

		// 把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "create_direct_pay_by_user");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("payment_type", payment_type);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("return_url", return_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("out_trade_no", out_trade_no);
		sParaTemp.put("subject", subject);
		sParaTemp.put("total_fee", total_fee);
		sParaTemp.put("body", body);
		sParaTemp.put("show_url", show_url);
		sParaTemp.put("anti_phishing_key", anti_phishing_key);
		sParaTemp.put("exter_invoke_ip", exter_invoke_ip);

		// 建立请求
		String sHtmlText = AlipaySubmit.buildRequest(sParaTemp, "get",
				"confirm");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>AliPay</title></head>");
		out.println("<body>");
		out.println(sHtmlText);
		out.println("</body></html>");
		out.close();
	}

	/**
	 * 支付后，同步返回函数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/onPaymentReturn.do")
	public ModelAndView onPaymentReturn(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView("paymentReturn");
		// 获取支付宝GET过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			params.put(name, valueStr);
		}

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		// 商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes(
				"ISO-8859-1"), "UTF-8");

		// 交易状态
		String trade_status = new String(request.getParameter("trade_status")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 交易金额
		String total_fee = new String(request.getParameter("total_fee")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		// 计算得出通知验证结果
		boolean verify_result = AlipayNotify.verify(params);
		Long oid = null;
		
		if (verify_result) {// 验证成功
			if (trade_status.equals("TRADE_FINISHED")
					|| trade_status.equals("TRADE_SUCCESS")) {
				oid = updatePaymentStatus(out_trade_no, trade_no);
				mav.addObject("success", true);
			} else {
				mav.addObject("success", false);
			}
		} else {
			mav.addObject("success", false);
		}

		mav.addObject("orderNo", out_trade_no);
		mav.addObject("totalFee", total_fee);
		if(oid!=null)
			mav.addObject("oid",oid.toString());
		log.debug("On Payment Return order id is: " + oid);
		mav.addObject("title", "支付结果");

		return mav;
	}

	@RequestMapping(value = "/testReturn.do")
	public ModelAndView testReturn(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("success", false);
		mav.addObject("totalFee", "0.01");
		mav.addObject("orderNo", "B000120301");
		mav.setViewName("paymentReturn");
		return mav;
	}

	private Long updatePaymentStatus(String out_trade_no, String trade_no) {
		// 判断该笔订单是否在商户网站中已经做过处理
		Long oid = null;
		
		List<Payment> payments = paymentService
				.findPaymentByOrderNo(out_trade_no);
		Payment thePayment = payments.get(0);
		oid = thePayment.getOrder().getId();
		// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		if (!thePayment.getStatus().equals(OrderPaymentStatus.FULL_PAID)) {
			thePayment.setStatus(OrderPaymentStatus.FULL_PAID);
			String notaryId = thePayment.getOrder().getBackendNotaryId();
			//如果已经受理过，则成功付款后改为已受理
			if(notaryId!=null && notaryId.length()>0){
				thePayment.getOrder().setOrderStatus(OrderStatus.ACCEPTED);
			}else{
				thePayment.getOrder().setOrderStatus(OrderStatus.PAID);
			}
			thePayment.setAlipayTxnNo(trade_no);
			thePayment.setPaymentDate(new Date());
			orderService.save(thePayment.getOrder());
			log.debug("订单状态变更完成！");
			
		}// 如果有做过处理，不执行商户的业务程序
		
		return oid;
	}

	/**
	 * 支付后，异步回调函数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/onPaymentNotify.do")
	public void onPaymentNotify(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 获取支付宝POST过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			// valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		// 商户订单号

		String out_trade_no = new String(request.getParameter("out_trade_no")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 支付宝交易号

		String trade_no = new String(request.getParameter("trade_no").getBytes(
				"ISO-8859-1"), "UTF-8");

		// 交易状态
		String trade_status = new String(request.getParameter("trade_status")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		System.out.println("==========接收到支付宝回调！！！===========");
		System.out.println("<p> 商户订单号： " + out_trade_no + "<p/>");
		System.out.println("<p> 支付宝交易号： " + trade_no + "<p/>");
		System.out.println("<p> 交易状态： " + trade_status + "<p/>");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		if (AlipayNotify.verify(params)) {// 验证成功

			if (trade_status.equals("TRADE_FINISHED")
					|| trade_status.equals("TRADE_SUCCESS")) {
				System.out.println("更新业务数据");
				updatePaymentStatus(out_trade_no, trade_no);
			}

			out.println("success"); // 请不要修改或删除

		} else {// 验证失败
			out.println("fail");
		}

	}

	/**
	 * 批量退款函数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/openRefund.do")
	public void openRefund(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	    //TODO: 先改一下Payment状态
	    
		// 服务器异步通知页面路径
		String notify_url = "http://hjyoa.hpe.cn:4848/ChangNing/onRefundNotify.do";

		// 卖家支付宝帐户
		String seller_email = Constants.ALIPAY_SELLER_EMAIL;
		// 必填
		Date now = new Date();

		// 退款当天日期
		String refund_date = sdf.format(now);
		// 必填，格式：年[4位]-月[2位]-日[2位] 小时[2位 24小时制]:分[2位]:秒[2位]，如：2007-10-01
		// 13:13:13

		// 批次号
		String batch_no = paymentService.generateRefundBatchNo();
		// 必填，格式：当天日期[8位]+序列号[3至24位]，如：201008010000001

		// 退款笔数
		String batch_num = new String(request.getParameter("WIDbatch_num")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 必填，参数detail_data的值中，“#”字符出现的数量加1，最大支持1000笔（即“#”字符出现的数量999个）

		System.err.println("detail data: "
				+ request.getParameter("WIDdetail_data"));
		// 退款详细数据
		String detail_data = new String(request.getParameter("WIDdetail_data")
				.getBytes("ISO-8859-1"), "UTF-8");
		System.err.println("detail data: " + detail_data);
		// 必填，具体格式请参见接口技术文档

		// 把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "refund_fastpay_by_platform_pwd");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("notify_url", notify_url);
		sParaTemp.put("seller_email", seller_email);
		sParaTemp.put("refund_date", refund_date);
		sParaTemp.put("batch_no", batch_no);
		sParaTemp.put("batch_num", batch_num);
		sParaTemp.put("detail_data", detail_data);

		// 建立请求
		String sHtmlText = AlipaySubmit
				.buildRequest(sParaTemp, "get", "refund");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head><title>AliPay</title></head>");
		out.println("<body>");
		out.println(sHtmlText);
		out.println("</body></html>");
		out.close();
	}

	/**
	 * 批量退款，异步返回函数
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/onRefundNotify.do")
	public void onRefundNotify(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 获取支付宝POST过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			// valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		// 批次号
		String batch_no = new String(request.getParameter("batch_no").getBytes(
				"ISO-8859-1"), "UTF-8");

		// 批量退款数据中转账成功的笔数

		String success_num = new String(request.getParameter("success_num")
				.getBytes("ISO-8859-1"), "UTF-8");

		// 批量退款数据中的详细信息
		String result_details = new String(request.getParameter(
				"result_details").getBytes("ISO-8859-1"), "UTF-8");

		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		log.debug("==========接收到支付宝 批量退款回调！！！===========");
		log.debug("<p> 批次号： " + batch_no + "<p/>");
		log.debug("<p> 批量退款数据中转账成功的笔数： " + success_num + "<p/>");
		log.debug("<p> 批量退款数据中的详细信息： " + result_details + "<p/>");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		Order order = null;
		
		if (AlipayNotify.verify(params)) {// 验证成功
			// 判断是否在商户网站中已经做过了这次通知返回的处理
			if (result_details != null && result_details.indexOf("#") >= 0) {
				log.debug("正在处理退款记录中的一条");
				String[] results = result_details.split("#");
				for (String refundStr : results) {
					order = updateRefundStatus(refundStr);
				}
			} else {
				log.debug("正在处理唯一一条退款记录");
				order= updateRefundStatus(result_details);
			}
			//order.setOrderStatus(OrderStatus.CANCELLED);
			orderService.save(order);
			out.println("success"); // 请不要修改或删除
			
		} else {// 验证失败
			out.println("fail");
		}
	}

	/**
	 * 
	 * @param refundStr
	 *            Sample: 2013090846702913^0.01^SUCCESS
	 */
	private Order updateRefundStatus(String refundStr) {
		log.debug(refundStr);
		String[] lineParams = refundStr.split("\\^");
		// log.debug(new Integer(lineParams.length).toString());
		String aliTxnNo = lineParams[0];
		log.debug(aliTxnNo);
		String amountStr = lineParams[1];
		log.debug(amountStr);
		String state = lineParams[2];
		log.debug(state);
		
		Order oid = null;

		if (state.equalsIgnoreCase("success")) {
			// 判断该笔订单是否在商户网站中已经做过处理
			List<Payment> payments = paymentService
					.findPaymentByAliOrderNo(aliTxnNo);
			if (!payments.isEmpty()) {
				Payment thePayment = payments.get(0);
				oid = thePayment.getOrder();
				// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
				if (!thePayment.getStatus().equals(OrderPaymentStatus.REFUNDED)) {
					thePayment.setStatus(OrderPaymentStatus.REFUNDED);
					thePayment.setRefundTotal(Double.parseDouble(amountStr));
					orderService.save(thePayment.getOrder());
					log.debug("退款业务数据更新完成");
				}

			}

		}
		return oid;

	}

}
