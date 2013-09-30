package com.xiangyun.notary.controller;

import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xiangyun.notary.domain.Form;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.service.OrderService;
import com.xiangyun.notary.service.UserService;
import com.xiangyun.notary.view.MultipleViewFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;

@Controller
public class ExportController {

	private static Logger log = LoggerFactory.getLogger(OrderController.class);

	private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	private SimpleDateFormat format1 = new SimpleDateFormat("yyyy 年 MM 月 dd 日");

	private Configuration configuration = null;

	@Autowired
	private ServletContext ctx;

	@Autowired
	private OrderService orderService;

	@Autowired
	private UserService userService;

	@Autowired
	private MultipleViewFactory multipleViewFactory;

	ExportController() {
		configuration = new Configuration();
		configuration.setDefaultEncoding("utf-8");
		configuration.setClassForTemplateLoading(this.getClass(),
				"/");
		
	}

	@RequestMapping(value = "/generateForm.do")
	public void generateForm(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// 获得参数id
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return;
		}
		// 查询该order
		Order order = orderService.findById(orderId);
		if (order == null) {
			return;
		}
		
		Template t = configuration.getTemplate("template.ftl");
		Map dataMap=new HashMap();
		dataMap.put("customer_name", order.getRequestorName()==null?" ":order.getRequestorName());	    
		dataMap.put("customer_sex", order.getRequestorGender()==null?" ":order.getRequestorGender());
		if(order.getRequestorBirthDate()!=null){
			dataMap.put("customer_birth_date", format.format(order.getRequestorBirthDate()));
		}else{
			dataMap.put("customer_birth_date", " ");
		}
		
		dataMap.put("export_date", format1.format(new Date()));
		
		dataMap.put("customer_address", order.getRequestorAddress()==null?" ":order.getRequestorAddress());
		dataMap.put("customer_id_type", order.getUser().getCredentialType()==null?" ":order.getUser().getCredentialType().getText());
		dataMap.put("customer_id", order.getUser().getCredentialId()==null?" ":order.getUser().getCredentialId());
		Set<Form> forms = order.getForms();
		StringBuffer contents = new StringBuffer();
		for(Form f: forms){
			contents.append(f.getFormName());
			contents.append(",");
		}
		contents.deleteCharAt(contents.length()-1);
		dataMap.put("order_content",contents.toString());
		dataMap.put("order_country", order.getDestination().getText());
		dataMap.put("order_lang", order.getTranslationLanguage().getText());
		dataMap.put("order_copy_num", order.getCertificateCopyCount());
		dataMap.put("order_need_cert", order.isNeedVerify()?"是":"否");
		dataMap.put("order_reason", order.getCertificatePurpose().getText());		
		dataMap.put("order_accepter_name", order.getAccepter()==null?"": order.getAccepter().getName());
		

		response.setContentType("application/msword");
		response.addHeader("Content-Disposition", "attachment; filename="  
                + URLEncoder.encode("申请书-"+order.getReadableId()+".doc", "UTF-8"));
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		 t.process(dataMap, out);
		 out.close();

	}

	/**
	 * helper method
	 * 
	 * @param request
	 * @return
	 */
	private Long validateOrderIdParameter(HttpServletRequest request) {
		String oId = request.getParameter("oId");
		if (StringUtils.isEmpty(oId)) {
			return null;
		}

		Long orderId = null;
		try {
			orderId = Long.valueOf(oId);
		} catch (NumberFormatException e) {
			log.warn("oId is not a valid number", e);
			return null;
		}

		return orderId;
	}



}
