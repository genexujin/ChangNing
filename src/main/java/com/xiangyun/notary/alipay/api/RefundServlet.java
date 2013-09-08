package com.xiangyun.notary.alipay.api;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alipay.config.AlipayConfig;
import com.alipay.util.AlipaySubmit;
import com.xiangyun.notary.Constants;

/**
 * Servlet implementation class RefundServlet
 */
public class RefundServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RefundServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 服务器异步通知页面路径
		String notify_url = "http://hjyoa.hpe.cn:4848/ChangNing/refundNotify";
		// 需http://格式的完整路径，不允许加?id=123这类自定义参数

		// 卖家支付宝帐户
		String seller_email = Constants.ALIPAY_SELLER_EMAIL;
		// 必填
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss"); 
		
		// 退款当天日期
		String refund_date = sdf.format(now);
		// 必填，格式：年[4位]-月[2位]-日[2位] 小时[2位 24小时制]:分[2位]:秒[2位]，如：2007-10-01
		// 13:13:13

		// 批次号
		String batch_no = new String(request.getParameter("WIDbatch_no")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 必填，格式：当天日期[8位]+序列号[3至24位]，如：201008010000001

		// 退款笔数
		String batch_num = new String(request.getParameter("WIDbatch_num")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 必填，参数detail_data的值中，“#”字符出现的数量加1，最大支持1000笔（即“#”字符出现的数量999个）

		// 退款详细数据
		String detail_data = new String(request.getParameter("WIDdetail_data")
				.getBytes("ISO-8859-1"), "UTF-8");
		// 必填，具体格式请参见接口技术文档

		// ////////////////////////////////////////////////////////////////////////////////

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

}
