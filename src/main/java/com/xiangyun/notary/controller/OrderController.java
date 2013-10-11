package com.xiangyun.notary.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.InteractionType;
import com.xiangyun.notary.common.Language;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.common.RelativeType;
import com.xiangyun.notary.common.SendDocDateType;
import com.xiangyun.notary.domain.DocExtraItem;
import com.xiangyun.notary.domain.FeeItem;
import com.xiangyun.notary.domain.Form;
import com.xiangyun.notary.domain.FormItem;
import com.xiangyun.notary.domain.Interaction;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.OrderHistory;
import com.xiangyun.notary.domain.Payment;
import com.xiangyun.notary.domain.RelativeInfo;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.form.FeeDef;
import com.xiangyun.notary.form.FeeFormDef;
import com.xiangyun.notary.form.FormDef;
import com.xiangyun.notary.form.FormDocItemDef;
import com.xiangyun.notary.form.FormFieldItemDef;
import com.xiangyun.notary.model.UploadModel;
import com.xiangyun.notary.service.OrderService;
import com.xiangyun.notary.service.UserService;
import com.xiangyun.notary.view.MultipleViewFactory;
import com.xiangyun.sms.SMSManager;

@Controller
public class OrderController {
	private static Logger log = LoggerFactory.getLogger(OrderController.class);

	private DateFormat format = new SimpleDateFormat("MM/dd/yyyy");

	@Autowired
	private ServletContext ctx;

	@Autowired
	private OrderService orderService;

	@Autowired
	private UserService userService;

	@Autowired
	private MultipleViewFactory multipleViewFactory;

	@RequestMapping(value = "/certStep1.do")
	public ModelAndView goToStep1() {
		ModelAndView mav = new ModelAndView("certStep1");
		mav.addObject("title", "选择申办业务");
		return mav;
	}

	@RequestMapping(value = "/certStep2.do")
	// Automatic type conversion
	public View goToStep2(@RequestParam("dest") DestinationCountry destination,
			@RequestParam("trans") Language transLanguage,
			@RequestParam("verify") boolean needVerify,
			@RequestParam("copies") int copies,
			@RequestParam("purpose") CertificatePurpose purpose,
			HttpServletRequest request,
			@RequestParam("n_key") Collection<String> formKeys,
			@RequestParam("n_key_yw") Collection<String> ywKeys) {
		// TODO: If logged in, and then access step2 directly, then it will goes
		// wrong.

		log.debug("Destination: {}", destination);
		log.debug("Translation language: {}", transLanguage);
		log.debug("Copies: {}", copies);
		log.debug("Purpose: {}", purpose);

		List<ModelAndView> mavList = new ArrayList<ModelAndView>();

		// Add the top part of the page
		ModelAndView top = new ModelAndView("certStep2Top");
		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);
		top.addObject("currUser", u);
		top.addObject("title", "输入信息");
		mavList.add(top);

		// Add the middle part according selection
		List<FormDef> selectedForms = new ArrayList<FormDef>();

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);
		for (String key : formKeys) {
			FormDef formDef = formDefs.get(key);
			if (formDef != null) {
				log.info("Form selected: " + formDef.getFormName());
				selectedForms.add(formDef);

				if (formDef.isContainsItem()) {
					ModelAndView formMav = new ModelAndView("forms/"
							+ formDef.getFormKey());
					mavList.add(formMav);
				}
			}
		}

		request.getSession().setAttribute(Constants.SESSION_SELECTED_FORMS,
				selectedForms);

		request.getSession().setAttribute(Constants.SESSION_SELECTED_YWXF,
				ywKeys);

		// Create the order to save information for next step
		Order order = new Order();
		//公证书总数减一为所需要的副本数
		order.setCertificateCopyCount(copies-1);
		order.setCertificatePurpose(purpose);
		if (CertificatePurpose.OTHER.equals(purpose)) {
			String customPurpose = request.getParameter("custom_purpose");
			if (!StringUtils.isEmpty(customPurpose))
				order.setCertCustomPurpose(customPurpose);
		}
		order.setDestination(destination);
		order.setTranslationLanguage(transLanguage);
		order.setNeedVerify(needVerify);
		order.setOrderDate(new Date());
		order.setOrderStatus(OrderStatus.SUBMITTED);
		order.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
		order.setUser(u);

		request.getSession().setAttribute(Constants.CURRENT_ORDER, order);

		// Add the bottom part of the page
		ModelAndView bottom = new ModelAndView("certStep2Bottom");
		mavList.add(bottom);
		return multipleViewFactory.getView(mavList);
	}

	@RequestMapping(value = "/certStep3")
	public ModelAndView goToStep3(HttpServletRequest request,
			@RequestParam("username") String requestorName,
			@RequestParam("mobile") String requestorMobile) {

		HttpSession session = request.getSession(false);
		List<FormDef> selectedForms = (List<FormDef>) session
				.getAttribute(Constants.SESSION_SELECTED_FORMS);
		Order order = (Order) session.getAttribute(Constants.CURRENT_ORDER);
		if (selectedForms == null || order == null) {
			ModelAndView mav = new ModelAndView("certStep1");
			mav.addObject("title", "选择申办业务");
			return mav;
		}

		// Need to query order's data to avoid duplication orders
		Order orderInDB = orderService.findById(order.getId());
		if (orderInDB != null) { // The order is already there.
			order = orderInDB;
		}

		order.setRequestorName(requestorName);
		order.setRequestorMobile(requestorMobile);
		if (!StringUtils.isEmpty(request.getParameter("pinyin")))
			order.setRequestorNamePinyin(request.getParameter("pinyin"));
		if (!StringUtils.isEmpty(request.getParameter("email")))
			order.setRequestorEmail(request.getParameter("email"));

		int birthYear = Integer.parseInt(request.getParameter("bd_year"));
		int birthMonth = Integer.parseInt(request.getParameter("bd_month"));
		int birthDate = Integer.parseInt(request.getParameter("bd_date"));
		Calendar date = Calendar.getInstance();
		date.set(birthYear, birthMonth - 1, birthDate); // month is 0-based
		order.setRequestorBirthDate(date.getTime());

		Map<String, List<FormDocItemDef>> allInOneUploadDocs = new HashMap<String, List<FormDocItemDef>>();
		Map<String, FormDocItemDef> aloneUploadDocs = new HashMap<String, FormDocItemDef>();
		Map<String, FormDocItemDef> needCropDocs = new HashMap<String, FormDocItemDef>();

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);

		boolean needSpecialNote = false;
		boolean needTY = true;
		for (FormDef formDef : selectedForms) {
			String formKey = formDef.getFormKey();
			// A special requirement about add a note for 出生公证 and 出生证复印件公证
			if (formKey.equals("CS")) {
				if ("true".equals(request.getParameter("CS_SFJZ"))
						|| "true".equals(request.getParameter("CS_SMJZ")))

					needSpecialNote = true;
			} else if (formKey.equals("CSZFYJ")) {
				if ("true".equals(request.getParameter("CSZFYJ_SFJZ"))
						|| "true".equals(request.getParameter("CSZFYJ_SMJZ")))

					needSpecialNote = true;
			}

			// HKBFYJ所需户口本，有个特殊的表述“户口本所有有字页”，并且他自己也需要“身份证”，所以完全取代了TY
			// CS和CSZFYJ则户口本在需要单独上传的有了，而身份证也是有自己的特殊表述“本人身份证正反面”，所以完全取代了TY
			if (formKey.equals("HKBFYJ") || formKey.equals("CS")
					|| formKey.equals("CSZFYJ")) {
				needTY = false;
			}

			Form form = getFormByKeyFromOrder(order, formKey);
			if (form == null) { // A new form!
				form = new Form();
				form.setFormKey(formKey);
				form.setFormName(formDef.getFormName());
			}

			// Create FormItems for a form
			Map<String, String> formKeyValueMap = new HashMap<String, String>();
			for (FormFieldItemDef itemDef : formDef.getFields()) {
				FormItem item = getFormItemByKeyFromForm(form,
						itemDef.getFieldKey());
				if (item == null) {
					item = new FormItem();
					item.setItemKey(itemDef.getFieldKey());
					item.setItemName(itemDef.getFieldName());
				}
				if (itemDef.isComposite()) {
					// QSGX item
					RelativeInfo info = createRelativeInfo(
							itemDef.getFieldKey(), request);
					if (info == null) {
						break;
					}
					item.setRelativeInfo(info);
				} else {
					item.setItemValue(request.getParameter(itemDef
							.getFieldKey()));// 获取对应值
					// Put it to a map for doc dependency. Currently no doc
					// depends on a composite value.
					// So just put it in the "else"
					formKeyValueMap.put(itemDef.getFieldKey(),
							request.getParameter(itemDef.getFieldKey()));
				}
				form.addFormItem(item);
			}

			// Create FeeItems for a form
			FeeDef feeDef = (FeeDef) ctx.getAttribute(Constants.FEE_DEF);
			form.addFeeItem(createGeneralFeeItem(order, form, formDef, feeDef));

			Collection<String> ywKeys = (Collection<String>) session
					.getAttribute(Constants.SESSION_SELECTED_YWXF);
			if (ywKeys.contains(formDef.getFormKey()
					+ Constants.YWXF_KEY_SUFFIX)) {
				form.addFeeItem(createYWXFFeeItem(order, formDef, feeDef));
			}

			order.addForm(form);

			// Collect the doc items for upload
			for (FormDocItemDef docDef : formDef.getDocs()) {
				boolean shouldPut = true;

				if (docDef.isDependent()
						&& formKeyValueMap.get(docDef.getDependOn()) != null
						&& formKeyValueMap.get(docDef.getDependOn()).equals(
								"false")) {// 是false的话.
					shouldPut = false;
				}

				if (shouldPut && docDef.isNeedCrop()) {// 需要的东西
					putIfAbsent(needCropDocs, docDef);

				} else if (shouldPut && docDef.isUploadAlone()) {// 上传
					putIfAbsent(aloneUploadDocs, docDef);

				} else if (shouldPut) {
					putIfAbsent(allInOneUploadDocs, formDef, docDef);

				}
			}

			// Add docItems for QSGX
			if (formDef.getFormKey().equals(Constants.QSGX_FORM_KEY)) {
				for (FormItem item : form.getFormItems()) {
					if (item.getRelativeInfo() != null) {
						FormDocItemDef idDocDef = new FormDocItemDef();
						idDocDef.setDocKey(item.getItemKey()
								+ Constants.QSGX_DOC_ID_SUFFIX);
						idDocDef.setDocName(Constants.QSGX_DOC_ID_TEMPLATE
								.replace("%", item.getRelativeInfo()
										.getRelativeName()));
						putIfAbsent(allInOneUploadDocs, formDef, idDocDef);

						FormDocItemDef hkDocDef = new FormDocItemDef();
						hkDocDef.setDocKey(item.getItemKey()
								+ Constants.QSGX_DOC_HK_SUFFIX);
						hkDocDef.setDocName(Constants.QSGX_DOC_HK_TEMPLATE
								.replace("%", item.getRelativeInfo()
										.getRelativeName()));
						putIfAbsent(allInOneUploadDocs, formDef, hkDocDef);
					}
				}
			}
		}
		if (needTY) {
			FormDef ty = formDefs.get("TY");
			for (FormDocItemDef docDef : ty.getDocs()) {
				//
				// String strKey=docDef.getDocKey();
				// if(HKBdoc&&strKey.equals("HKB")){
				// docDef.setDocName(docDef.getDocName().substring(0,
				// docDef.getDocName().lastIndexOf('及')));
				// }else{
				// docDef.setDocName(docDef.getDocName());
				// }
				putIfAbsent(allInOneUploadDocs, ty, docDef);
			}
		}
		order.calculateTotalFee();

		// 保存历史记录
		if (order.getHistories() == null || order.getHistories().isEmpty()) {

			OrderHistory operation = new OrderHistory();
			operation.setOperation(Constants.ORDER_OPERATION_NEW);
			operation.setOperationDate(new Date());
			User user = (User) session.getAttribute(Constants.LOGIN_USER);
			operation.setUser(user);
			order.addHistory(operation);
		}
		orderService.save(order);

		ModelAndView mav = new ModelAndView("certStep3");
		mav.addObject("title", "上传资料");

		UploadModel m = new UploadModel();
		m.setUid(order.getId());
		m.setAllInOneUpload(allInOneUploadDocs);
		m.setAloneUpload(aloneUploadDocs.values());
		m.setNeedCrop(needCropDocs.values());

		mav.addObject("um", m);

		if (needSpecialNote)
			mav.addObject("Special_note", "如本人和父母不在同一本户口本，请分别上传");

		return mav;
	}

	/**
	 * 
	 * @param uploadNote
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/certStep4.do")
	public ModelAndView goToStep4(
			@RequestParam("upload_note") String uploadNote,
			HttpServletRequest request) {

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);

		Order order = (Order) request.getSession(false).getAttribute(
				Constants.CURRENT_ORDER);
		if (order == null) {
			ModelAndView mav = new ModelAndView("certStep1");
			mav.addObject("title", "选择申办业务");
			return mav;
		}

		order.setUploadNote(uploadNote);

		orderService.save(order);

		// 大部分公证不能上门送证。如果所选forms全部能上门送证，那么才去到step4，否则跳过。
		boolean skipStep4 = false;
		for (Form form : order.getForms()) {
			FormDef theDef = formDefs.get(form.getFormKey());
			if (theDef != null && theDef.isCanSendDoc() == false) {
				skipStep4 = true;
			}
		}

		if (skipStep4) {
			order.calculateTotalFee();
			order.setSkipSendDoc(true);
			orderService.save(order);

			ModelAndView mav = new ModelAndView(
					"redirect:certStep45.do?sendDoc=false");
			// mav.addObject("title", "支付");
			// mav.addObject("order", order);
			return mav;

		} else {
			ModelAndView mav = new ModelAndView("certStep4");
			mav.addObject("title", "上门送证");
			return mav;
		}

	}

	/**
	 * 受理通知单
	 * 
	 * @param sendDoc
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/certStep45.do")
	public ModelAndView goToStep45(@RequestParam("sendDoc") boolean sendDoc,
			HttpServletRequest request) {

		log.debug("Should send doc? {}", sendDoc);

		HttpSession session = request.getSession(false);
		Order order = (Order) session.getAttribute(Constants.CURRENT_ORDER);
		if (order == null) {
			ModelAndView mav = new ModelAndView("certStep1");
			mav.addObject("title", "选择申办业务");
			return mav;
		}

		order.setSendDoc(sendDoc);
		if (sendDoc) {
			order.setSendAddress(request.getParameter("sendAddress"));
			order.setSendDate(SendDocDateType.valueOf((request
					.getParameter("workday"))));
		}

		order.calculateTotalFee();

		orderService.save(order);

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);
		log.debug("Start to generate doc list.....");
		Map<String, List<FormDocItemDef>> allDocs = generateDocList(order,
				formDefs);

		ModelAndView mav = new ModelAndView("certStep45");
		mav.addObject("title", "受理通知单");
		mav.addObject("allDocs", allDocs.values());
		mav.addObject("order", order);
		return mav;

	}

	/**
	 * 
	 * @param sendDoc
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/certStep5.do")
	public ModelAndView goToStep5(HttpServletRequest request) {

		// log.debug("Should send doc? {}", sendDoc);

		HttpSession session = request.getSession(false);
		Order order = (Order) session.getAttribute(Constants.CURRENT_ORDER);
		if (order == null) {
			ModelAndView mav = new ModelAndView("certStep1");
			mav.addObject("title", "选择申办业务");
			return mav;
		}

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"我处已收取您提交的公证申请，订单号为：" + order.getReadableId()
						+ " ，您付款并递交材料齐全后，"
						+ "我处会于五个工作日出具公证书。 声明书和身份证复印件公证必需要本人持上传的所有材料原件来领取，"
						+ "其他公证可以凭短信和上传的所有材料原件代领。如果提交申请后七日内未补充材料或者未付款，"
						+ "此公证申请将被撤销。", 1);

		// order.setSendDoc(sendDoc);
		// if (sendDoc) {
		// order.setSendAddress(request.getParameter("sendAddress"));
		// order.setSendDate(SendDocDateType.valueOf((request
		// .getParameter("workday"))));
		// }
		//
		// order.calculateTotalFee();
		//
		// orderService.save(order);

		ModelAndView mav = new ModelAndView("certStep5");
		mav.addObject("title", "支付");
		mav.addObject("order", order);
		return mav;
	}

	/**
	 * 支付方法，该方法打开支付宝页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/payment.do")
	public String goToPayment(HttpServletRequest request) {

		Long orderId = validateOrderIdParameter(request);
		Order order = null;

		if (orderId != null) {// 如果有传oid参数进来、则读取该oid的order。
			Long userId = getUserIdFromSession(request.getSession(false));
			order = orderService.findOrderById(orderId, userId);
			if (order == null) {
				return "redirect:/orderQuery.do";
			}
		} else {
			order = (Order) request.getSession(false).getAttribute(
					Constants.CURRENT_ORDER);
		}

		int seq = order.getPayments().size() + 1;
		String tradeNo = order.getReadableId() + "-" + seq;
		String title = order.getPaymentTitle() + " 订单号："
				+ order.getReadableId();

		Set<Payment> pays = order.getPayments();
		Payment payment = null;

		// 检查是否有付款中的payment，如果没有则新建，如果有则先付付款中的
		if (pays.isEmpty()) {

			// 先创建Payment
			payment = new Payment();

			// payment.setPaymentDate(new Date());
			payment.setPaymentTotal(order.getPaymentTotal());
			// payment.setPaymentTotal(0.01);
			payment.setTitle(title);
			payment.setPaymentReason("公证费用");

			payment.setStatus(OrderPaymentStatus.NOT_PAID);
			payment.setOrderTxnNo(tradeNo);
			order.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
			order.addPayment(payment);
		} else {
			for (Payment pay : pays) {
				if (pay.getStatus().equals(OrderPaymentStatus.NOT_PAID))
					payment = pay;
			}
		}

		String str = null;
		try {
			str = java.net.URLEncoder.encode(payment.getTitle() + "  "
					+ payment.getPaymentReason(), "UTF-8");
			tradeNo = java.net.URLEncoder.encode(tradeNo, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			log.error("Unspported UTF-8 encoding", e);
		}

		StringBuilder sb = new StringBuilder(
				"redirect:/openPayment.do?WIDout_trade_no=");
		sb.append(tradeNo);
		sb.append("&WIDsubject=" + str);
		sb.append("&WIDtotal_fee=" + payment.getPaymentTotal());
		try {
			sb.append("&WIDbody=").append(URLEncoder.encode("公证收费", "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error("UTF-8 is not supported.", e);
		}
		// WIDshow_url can be the order detail page for the order
		sb.append("&WIDshow_url=bbbb");

		order.setOrderStatus(OrderStatus.PAYING);
		logHistory(Constants.ORDER_OPERATION_PAY, order, getUser(request));
		orderService.save(order);

		// Remove current order from session, to avoid any error
		request.getSession(false).removeAttribute(Constants.CURRENT_ORDER);

		return sb.toString();
	}

	private User getUser(HttpServletRequest request) {
		return (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
	}

	private void logHistory(String operationType, Order order, User user) {
		OrderHistory operation = new OrderHistory();
		operation.setOperation(operationType);
		operation.setOperationDate(new Date());
		operation.setUser(user);
		order.addHistory(operation);
	}

	@RequestMapping(value = "/orderQuery.do")
	public ModelAndView orderQuery(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute(Constants.LOGIN_USER);

		int pageNum;
		String pageNumStr = request.getParameter("pn");
		if (StringUtils.isEmpty(pageNumStr)) {
			pageNum = 1;
		} else {
			try {
				pageNum = Integer.parseInt(pageNumStr);
			} catch (NumberFormatException e) {
				pageNum = 1;
			}
		}
		session.setAttribute(Constants.ORDER_QUERY_PAGE_NUM, pageNum + ""); // Looks
																			// like
																			// no
																			// need
																			// to
																			// save
																			// page
																			// num

		String readableId = request.getParameter("rId");
		if (readableId != null) {
			session.setAttribute(Constants.ORDER_QUERY_READABLE_ID, readableId);
		} else
			readableId = (String) session
					.getAttribute(Constants.ORDER_QUERY_READABLE_ID);

		String requestorName = request.getParameter("reqName");
		if (requestorName != null) {
			session.setAttribute(Constants.ORDER_QUERY_REQ_NAME, requestorName);
		} else {
			requestorName = (String) session
					.getAttribute(Constants.ORDER_QUERY_REQ_NAME);
		}

		Date startDate = null;
		String startDateStr = request.getParameter("startDate");
        log.debug("query startDate Str is : "+startDateStr);
        
		if (startDateStr != null) {
			try {
				if(!StringUtils.isEmpty(startDateStr))
					startDate = format.parse(startDateStr);
				session.setAttribute(Constants.ORDER_QUERY_START_DATE,
						startDate);
			} catch (ParseException e) {
				log.error("The startDate input cannot be parsed.", e);
			}
		} else {
				startDate = (Date) session
						.getAttribute(Constants.ORDER_QUERY_START_DATE);
	
		}

		Date endDate = null;
		String endDateStr = request.getParameter("endDate");

		if (endDateStr != null) {
			try {
				if(!StringUtils.isEmpty(endDateStr))
					endDate = format.parse(endDateStr);
				session.setAttribute(Constants.ORDER_QUERY_END_DATE, endDate);
			} catch (ParseException e) {
				log.error("The endDate input cannot be parsed.", e);
			}
		} else {
			endDate = (Date) session
						.getAttribute(Constants.ORDER_QUERY_END_DATE);				 
		}

		OrderStatus status = null;
		String statusStr = request.getParameter("status");
		if (statusStr!=null){
			status = OrderStatus.valueOf(statusStr);
			session.setAttribute(Constants.ORDER_QUERY_STATUS, status);
		}else{
			status = (OrderStatus)session.getAttribute(Constants.ORDER_QUERY_STATUS);
		}
		

		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}

		Long orderCount = orderService.getOrderCount(readableId, requestorName,
				startDate, endDate, status, userId);
		Long pageCount = (orderCount - 1) / Constants.QUERY_PAGE_SIZE + 1;
		List<Order> orders = orderService.findOrders(readableId, requestorName,
				startDate, endDate, status, userId, pageNum);

		ModelAndView mav = new ModelAndView("backend/orderQuery");
		mav.addObject("title", "订单查询");
		mav.addObject("pageCount", pageCount);
		mav.addObject("currPage", pageNum);
		// Need to compute in Java. The we can leverage the feature that
		// integer/integer is still a integer
		// In JSTL, integer/integer can be float/double, which is not good for
		// this computation.
		mav.addObject("loopBegin", ((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE + 1);
		mav.addObject(
				"loopEnd",
				(((pageNum - 1) / Constants.PAGING_BAR_SIZE)
						* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE < pageCount) ? ((pageNum - 1) / Constants.PAGING_BAR_SIZE)
						* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE
						: pageCount);
		mav.addObject("left", (((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE - Constants.PAGING_BAR_SIZE - 1));
		mav.addObject("right", (((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE + 1));
		mav.addObject("orders", orders);
		return mav;
	}

	@RequestMapping(value = "/orderDetail.do")
	public ModelAndView orderDetail(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);
		Map<String, List<FormDocItemDef>> allDocs = generateDocList(order,
				formDefs);

		List<Interaction> interactions = orderService
				.findIncompletedInteractionsForOrder(orderId, userId);

		ModelAndView mav = new ModelAndView("backend/orderDetail");

		for (Payment p : order.getPayments()) {
			if (p.getStatus().equals(OrderPaymentStatus.FULL_PAID)) {
				mav.addObject("hasPaid", true);
				break;
			}
		}

		mav.addObject("title", "订单详情");
		mav.addObject("order", order);

		mav.addObject("allDocs", allDocs.values());
		mav.addObject("interactions", interactions);

		return mav;
	}

	private Map<String, List<FormDocItemDef>> generateDocList(Order order,
			Map<String, FormDef> formDefs) {
		Map<String, List<FormDocItemDef>> allDocs = new HashMap<String, List<FormDocItemDef>>();

		boolean needTY = true;

		Set<Form> forms = order.getForms();
		for (Form form : forms) {
			// Put form key/value pairs in a map for doc dependency.
			Map<String, String> formKeyValueMap = new HashMap<String, String>();
			for (FormItem formItem : form.getFormItems()) {
				formKeyValueMap.put(formItem.getItemKey(),
						formItem.getItemValue());
			}

			String formKey = form.getFormKey();
			FormDef formDef = formDefs.get(formKey);
			// HKBFYJ所需户口本，有个特殊的表述“户口本所有有字页”，并且他自己也需要“身份证”，所以完全取代了TY
			// CS和CSZFYJ则户口本在需要单独上传的有了，而身份证也是有自己的特殊表述“本人身份证正反面”，所以完全取代了TY
			if (formKey.equals("HKBFYJ") || formKey.equals("CS")
					|| formKey.equals("CSZFYJ")) {
				needTY = false;
			}

			// Collect the doc items for display
			for (FormDocItemDef docDef : formDef.getDocs()) {
				boolean shouldPut = true;
				if (docDef.isDependent()
						&& formKeyValueMap.get(docDef.getDependOn()) != null
						&& formKeyValueMap.get(docDef.getDependOn()).equals(
								"false")) {
					shouldPut = false;
				}

				// if (shouldPut && !docDef.isNeedCrop() &&
				// !docDef.isUploadAlone()){
				// Put all the files in. Download all together
				if (shouldPut) {
					putIfAbsent(allDocs, formDef, docDef);
				}
			}
		}

		if (needTY) {
			FormDef ty = formDefs.get("TY");
			for (FormDocItemDef docDef : ty.getDocs()) {
				putIfAbsent(allDocs, ty, docDef);
			}
		}
		log.debug("generate doc list, list size is : " + allDocs.size());
		return allDocs;
	}

	@RequestMapping(value = "/orderAccept.do")
	public ModelAndView orderAccept(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		// 如果已经是后面的状态了，则不允许接受了
		// if (order.getOrderStatus().ordinal() >=
		// OrderStatus.ACCEPTED.ordinal()) {
		// return new ModelAndView("redirect:orderDetail.do?oId=" + orderId);
		// }

		ModelAndView mav = new ModelAndView("backend/orderAccept");
		mav.addObject("title", "订单受理");
		mav.addObject("order", order);

		return mav;

	}

	@RequestMapping(value = "/doAccept.do")
	public ModelAndView doAccept(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		String notaryId = request.getParameter("notaryId");
		order.setBackendNotaryId(notaryId);
		order.setOrderStatus(OrderStatus.ACCEPTED);
		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);
		order.setAccepter(u);
		logHistory(Constants.ORDER_OPERATION_ACCEPT, order, u);
		orderService.save(order);

		ModelAndView mav = new ModelAndView("backend/orderAccept");
		mav.addObject("successMsg", "订单受理信息已成功保存！请单击“返回”按钮返回订单详情页面！");
		mav.addObject("title", "订单受理");
		mav.addObject("order", order);

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId()
						+ " 已确认受理，我们的公证人员会尽快处理并与您联系，请耐心等待, 谢谢！受理编号为："
						+ notaryId, 1);

		return mav;
	}

	@RequestMapping(value = "/orderCancel.do")
	public ModelAndView orderCancel(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		ModelAndView mav = new ModelAndView("backend/orderCancel");
		mav.addObject("title", "订单撤销");
		mav.addObject("order", order);

		return mav;

	}

	@RequestMapping(value = "/doCancel.do")
	public ModelAndView doCancel(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		String cancelNote = request.getParameter("cancel_note");
		order.setCancelNote(cancelNote);
		order.setOrderStatus(OrderStatus.CANCEL_REQUESTED);
		logHistory(Constants.ORDER_OPERATION_REQUEST_CANCEL, order,
				getUser(request));
		orderService.save(order);

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId()
						+ " 已提交撤销，我们的公证人员会尽快处理并与您联系，请耐心等待，谢谢！", 1);

		ModelAndView mav = new ModelAndView("backend/orderCancel");
		mav.addObject("title", "订单受理");
		mav.addObject("successMsg", "订单撤销请求已发送！请单击“返回”按钮返回订单详情页面！");
		mav.addObject("order", order);

		return mav;
	}

	@RequestMapping(value = "/confirmCancel.do")
	public ModelAndView confirmCancel(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		order.setOrderStatus(OrderStatus.CANCELLED);
		logHistory(Constants.ORDER_OPERATION_CANCEL, order, getUser(request));
		orderService.save(order);

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId()
						+ " 已撤销，如有疑问请询问在线客服或电话联系我们，谢谢！", 1);

		ModelAndView mav = new ModelAndView("redirect:orderDetail.do?oId="
				+ order.getId());
		return mav;
	}

	/**
	 * 保存补充的材料
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/confirmAddDoc.do")
	public ModelAndView confirmAddDoc(HttpServletRequest request) {

		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		if (order.getBackendNotaryId() != null
				&& order.getBackendNotaryId().length() > 0)
			order.setOrderStatus(OrderStatus.ACCEPTED);
		else if (order.hasPaidPayment())
			order.setOrderStatus(OrderStatus.PAID);

		Set<Interaction> actions = order.getInteractions();
		for (Interaction act : actions) {
			act.setOrder(null);
			actions.remove(act);
		}

		logHistory(Constants.ORDER_OPERATION_ADDDOC, order, getUser(request));

		orderService.save(order);

		return new ModelAndView("redirect:orderDetail.do?oId=" + orderId);

	}

	/**
	 * 显示补充材料页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/addDocs.do")
	public ModelAndView addDocs(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		// Collect docs for the order
		Map<String, List<FormDocItemDef>> allInOneUploadDocs = new HashMap<String, List<FormDocItemDef>>();
		Map<String, FormDocItemDef> aloneUploadDocs = new HashMap<String, FormDocItemDef>();
		Map<String, FormDocItemDef> needCropDocs = new HashMap<String, FormDocItemDef>();

		Map<String, FormDef> formDefs = (Map<String, FormDef>) ctx
				.getAttribute(Constants.FORM_DEFS);

		boolean needSpecialNote = false;
		boolean needTY = true;

		Set<Form> forms = order.getForms();
		for (Form form : forms) {
			FormDef formDef = formDefs.get(form.getFormKey());

			String formKey = formDef.getFormKey();
			// A special requirement about add a note for 出生公证 and 出生证复印件公证
			if (formKey.equals("CS")) {
				if ("true".equals(getItemValueFromForm(form, "CS_SFJZ"))
						|| "true".equals(getItemValueFromForm(form, "CS_SMJZ")))

					needSpecialNote = true;
			} else if (formKey.equals("CSZFYJ")) {
				if ("true".equals(getItemValueFromForm(form, "CSZFYJ_SFJZ"))
						|| "true".equals(getItemValueFromForm(form,
								"CSZFYJ_SMJZ")))

					needSpecialNote = true;
			}

			// HKBFYJ所需户口本，有个特殊的表述“户口本所有有字页”，并且他自己也需要“身份证”，所以完全取代了TY
			// CS和CSZFYJ则户口本在需要单独上传的有了，而身份证也是有自己的特殊表述“本人身份证正反面”，所以完全取代了TY
			if (formKey.equals("HKBFYJ") || formKey.equals("CS")
					|| formKey.equals("CSZFYJ")) {
				needTY = false;
			}

			for (FormDocItemDef docDef : formDef.getDocs()) {
				boolean shouldPut = true;
				// Check if we should add the doc if the doc is dependent.
				if (docDef.isDependent()) {
					shouldPut = checkDependentDocItem(form, docDef);
				}

				if (shouldPut && docDef.isNeedCrop()) {
					putIfAbsent(needCropDocs, docDef);

				} else if (shouldPut && docDef.isUploadAlone()) {
					putIfAbsent(aloneUploadDocs, docDef);

				} else if (shouldPut) {
					putIfAbsent(allInOneUploadDocs, formDef, docDef);

				}
			}

			// Add docItems for QSGX
			if (formDef.getFormKey().equals(Constants.QSGX_FORM_KEY)) {
				for (FormItem item : form.getFormItems()) {
					if (item.getRelativeInfo() != null) {
						FormDocItemDef idDocDef = new FormDocItemDef();
						idDocDef.setDocKey(item.getItemKey()
								+ Constants.QSGX_DOC_ID_SUFFIX);
						idDocDef.setDocName(Constants.QSGX_DOC_ID_TEMPLATE
								.replace("%", item.getRelativeInfo()
										.getRelativeName()));
						putIfAbsent(allInOneUploadDocs, formDef, idDocDef);

						FormDocItemDef hkDocDef = new FormDocItemDef();
						hkDocDef.setDocKey(item.getItemKey()
								+ Constants.QSGX_DOC_HK_SUFFIX);
						hkDocDef.setDocName(Constants.QSGX_DOC_HK_TEMPLATE
								.replace("%", item.getRelativeInfo()
										.getRelativeName()));
						putIfAbsent(allInOneUploadDocs, formDef, hkDocDef);
					}
				}
			}
		}

		if (needTY) {
			FormDef ty = formDefs.get("TY");
			for (FormDocItemDef docDef : ty.getDocs()) {
				putIfAbsent(allInOneUploadDocs, ty, docDef);
			}
		}

		ModelAndView mav = new ModelAndView("backend/addDocs");
		mav.addObject("title", "补充资料");

		UploadModel m = new UploadModel();
		m.setUid(order.getId());
		m.setOrderReadableId(order.getReadableId());
		m.setAllInOneUpload(allInOneUploadDocs);
		m.setAloneUpload(aloneUploadDocs.values());
		m.setNeedCrop(needCropDocs.values());

		mav.addObject("um", m);
		mav.addObject("order", order);

		if (needSpecialNote)
			mav.addObject("Special_note", "如本人和父母不在同一本户口本，请分别上传");

		return mav;
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/requestExtraDocs.do")
	public ModelAndView requestExtraDocs(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		ModelAndView mav = new ModelAndView("backend/requestExtraDocs");
		mav.addObject("title", "要求客户补充材料");
		mav.addObject("order", order);

		return mav;

	}

	@RequestMapping(value = "/doRequestExtraDocs.do")
	public ModelAndView doRequestExtraDocs(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		String extraDocs = request.getParameter("extra_docs");
		if (StringUtils.isEmpty(extraDocs) == false) {
			DocExtraItem extraItem = new DocExtraItem();
			extraItem.setExtraDocNames(extraDocs);
			order.addExtraDoc(extraItem);

			Interaction i = new Interaction();
			i.setInteractionDate(new Date());
			i.setInteractionType(InteractionType.ADD_DOCS);
			i.setUser(user);
			i.setInteractionContent("额外要求补充材料：" + extraDocs);
			order.addInteraction(i);

		}

		order.setOrderStatus(OrderStatus.EXTRADOC_REQUESTED);
		logHistory(Constants.ORDER_OPERATION_EXTRADOC, order, user);
		orderService.save(order);

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId() + " 额外要求补充材料! 需要补充的材料为："
						+ extraDocs, 1);

		ModelAndView mav = new ModelAndView("redirect:orderDetail.do?oId="
				+ orderId);

		return mav;
	}

	@RequestMapping(value = "/requestExtraPayment.do")
	public ModelAndView requestExtraPayment(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		ModelAndView mav = new ModelAndView("backend/requestExtraPayment");
		mav.addObject("title", "要求客户附加费用");
		mav.addObject("order", order);

		return mav;

	}

	@RequestMapping(value = "/doRequestExtraPayment.do")
	public ModelAndView doRequestExtraPayment(HttpServletRequest request,
			@RequestParam("extra_pay") double extraPayment,
			@RequestParam("extra_pay_note") String extraPaymentNote) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Payment pay = new Payment();
		pay.setPaymentTotal(extraPayment);
		// pay.setPaymentTotal(0.01);
		pay.setStatus(OrderPaymentStatus.NOT_PAID);
		pay.setPaymentReason(extraPaymentNote);
		pay.setTitle("附加费用 订单号：" + order.getReadableId());
		int seq = order.getPayments().size() + 1;
		String tradeNo = order.getReadableId() + "-" + seq;
		pay.setOrderTxnNo(tradeNo);

		order.addPayment(pay);
		// Save the order so that the payment can have an id
		orderService.save(pay);

		Interaction i = new Interaction();
		i.setInteractionDate(new Date());
		i.setInteractionType(InteractionType.ADD_PAYMENT);
		i.setUser(user);
		i.setInteractionContent("要求附加费用。费用：" + extraPayment + "，原因："
				+ extraPaymentNote);
		i.setExtraData(pay.getId().toString());
		order.addInteraction(i);
		order.setOrderStatus(OrderStatus.ADD_CHARGE);
		logHistory(Constants.ORDER_OPERATION_ADDCHARGE, order, user);
		orderService.save(order);

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId() + " 需要附加额外费用! 金额："
						+ extraPayment + "元, 附加费用原因：" + extraPaymentNote, 1);

		ModelAndView mav = new ModelAndView("redirect:orderDetail.do?oId="
				+ orderId);

		return mav;
	}

	/**
	 * 
	 * @param request
	 * @param paymentId
	 * @return
	 */
	@RequestMapping(value = "/extraPayment.do")
	public ModelAndView extraPayment(HttpServletRequest request,
			@RequestParam("pId") Long paymentId) {

		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Payment payment = orderService.findPaymentByOrderIdAndPaymentId(
				orderId, userId, paymentId);
		if (payment == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		String tradeNo = payment.getOrderTxnNo();
		String title = payment.getTitle();
		payment.setPaymentDate(new Date());

		payment.getOrder().setOrderStatus(OrderStatus.PAYING);
		logHistory(Constants.ORDER_OPERATION_PAY, payment.getOrder(),
				getUser(request));

		Set<Interaction> actions = payment.getOrder().getInteractions();
		for (Interaction act : actions) {
			act.setOrder(null);
			actions.remove(act);
		}

		orderService.save(payment);

		String str = null;
		try {
			str = java.net.URLEncoder.encode(title, "UTF-8");
			tradeNo = java.net.URLEncoder.encode(tradeNo, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		StringBuilder sb = new StringBuilder(
				"redirect:/openPayment.do?WIDout_trade_no=");
		sb.append(tradeNo);
		sb.append("&WIDsubject=" + str);
		sb.append("&WIDtotal_fee=" + payment.getPaymentTotal());
		try {
			sb.append("&WIDbody=").append(URLEncoder.encode("公证收费", "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error("UTF-8 is not supported.", e);
		}
		// WIDshow_url can be the order detail page for the order
		sb.append("&WIDshow_url=bbbb");

		return new ModelAndView(sb.toString());
	}

	@RequestMapping(value = "/orderRefund.do")
	public ModelAndView orderRefund(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		Long userId = getUserIdFromSession(request.getSession(false));

		Order order = orderService.findOrderById(orderId, userId);
		if (order == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}

		ModelAndView mav = new ModelAndView("backend/orderRefund");
		mav.addObject("title", "退款");
		mav.addObject("order", order);

		return mav;
	}

	@RequestMapping(value = "/doRefund.do")
	public ModelAndView doRefund(HttpServletRequest request) {
		Long orderId = validateOrderIdParameter(request);
		if (orderId == null) {
			return new ModelAndView("redirect:orderQuery.do");
		}
		String refundReason = request.getParameter("refund_reason");
		String[] paymentIds = request.getParameterValues("payment_id");
		List<Long> pIds = convertPaymentIds(paymentIds);
		log.debug("Selected payment ids: " + pIds);
		List<Payment> payments = orderService
				.findPaymentsByOrderIdAndPaymentIds(orderId, pIds);
		if (payments == null || payments.isEmpty()) {
			return new ModelAndView("redirect:orderQuery.do");
		}
		Payment firstPayment = payments.get(0);
		Order order = firstPayment.getOrder();

		StringBuilder refundDetailData = new StringBuilder();
		for (Payment payment : payments) {
			payment.setRefundDate(new Date());
			payment.setRefundReason(refundReason);
			payment.setStatus(OrderPaymentStatus.PENDING_REFUND);
			refundDetailData.append(payment.getAlipayTxnNo()).append("^")
					.append(payment.getPaymentTotal()).append("^")
					.append(refundReason);
			// Always append a "#" and remove it after the loop
			refundDetailData.append("#");
			orderService.save(payment);
		}
		if (refundDetailData.charAt(refundDetailData.length() - 1) == '#') {
			refundDetailData.deleteCharAt(refundDetailData.length() - 1);
		}

		log.debug("The refund detail data is: " + refundDetailData.toString());

		StringBuilder sb = new StringBuilder("redirect:/openRefund.do");
		sb.append("?WIDbatch_num=").append(payments.size());
		try {
			sb.append("&WIDdetail_data=").append(
					URLEncoder.encode(refundDetailData.toString(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			log.error("UTF-8 is not supported.", e);
		}

		log.debug("The refund url is: " + sb.toString());

		SMSManager.sendSMS(new String[] { order.getRequestorMobile() },
				"您的办证订单：" + order.getReadableId()
						+ " 已进入退款流程，我们的服务人员会尽快完成退款，请注意查收您的相关账户。", 1);

		return new ModelAndView(sb.toString());
	}

	private List<Long> convertPaymentIds(String[] paymentIds) {
		List<Long> pIds = new ArrayList<Long>();
		for (String paymentId : paymentIds) {
			pIds.add(Long.parseLong(paymentId));
		}
		return pIds;
	}

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

	private Long getUserIdFromSession(HttpSession session) {
		User user = (User) session.getAttribute(Constants.LOGIN_USER);
		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}
		return userId;
	}

	private boolean checkDependentDocItem(Form form, FormDocItemDef docDef) {
		String dependOnFormItem = docDef.getDependOn();
		for (FormItem item : form.getFormItems()) {
			if (item.getItemKey().equals(dependOnFormItem)
					&& item.getItemValue().equals("false"))
				return false;
		}
		return true;
	}

	private void putIfAbsent(Map<String, FormDocItemDef> docDefs,
			FormDocItemDef docDef) {
		if (!docDefs.containsKey(docDef.getDocKey())) {
			docDefs.put(docDef.getDocKey(), docDef);
		}

	}

	private void putIfAbsent(Map<String, List<FormDocItemDef>> docDefs,
			FormDef formDef, FormDocItemDef docDef) {
		List<FormDocItemDef> formDocs = null;
		if (!docDefs.containsKey(formDef.getFormKey())) {
			formDocs = new ArrayList<FormDocItemDef>();
			docDefs.put(formDef.getFormKey(), formDocs);
		} else
			formDocs = docDefs.get(formDef.getFormKey());

		boolean contained = false;
		for (List<FormDocItemDef> docList : docDefs.values()) {
			for (FormDocItemDef doc : docList) {
				if (doc.getDocKey().equals(docDef.getDocKey())) {
					contained = true;
					break;
				}
			}

			if (contained)
				break;
		}

		if (!contained) {
			formDocs.add(docDef);
		}

	}

	private RelativeInfo createRelativeInfo(String fieldKey,
			HttpServletRequest request) {
		String typeStr = request.getParameter(fieldKey);
		if (StringUtils.isEmpty(typeStr)) {
			// Empty means no value is submitted. That will happen when this
			// field is not display on web page.
			// So return null to allow skip the rest.
			return null;
		} else if ("NULL".equals(typeStr)) {
			throw new IllegalArgumentException(
					"The QSGX form must select a relativeType other than NULL");
		}
		RelativeType type = RelativeType.valueOf(typeStr);
		String name = request.getParameter(fieldKey
				+ Constants.QSGX_NAME_SUFFIX);
		String pinyin = request.getParameter(fieldKey
				+ Constants.QSGX_PINYIN_SUFFIX);

		log.debug("relativeType is: " + type + " relativeName is: " + name
				+ " relativePinyin is: " + pinyin);

		RelativeInfo result = new RelativeInfo();
		result.setRelativeType(type);
		result.setRelativeName(name);
		result.setRelativePinyin(pinyin);
		return result;

	}

	private FeeItem createGeneralFeeItem(Order order, Form form,
			FormDef formDef, FeeDef feeDef) {
		FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(
				formDef.getFormKey());
		FeeItem fee = new FeeItem();
		fee.setFeeKey(formDef.getFormKey());
		fee.setFeeName(formDef.getFormName());
		fee.setCopyFee(order.getCertificateCopyCount() * feeDef.getCopyFee());
		fee.setInvestigationFee(feeFormDef.getInvestigateFee());
		fee.setWordTranslationFee(getWordTranslationFee(feeFormDef,
				order.getTranslationLanguage()));

		// Some form's fee are depend on a value in form
		double fileTranslationFee = getFileTranslationFee(feeFormDef,
				order.getTranslationLanguage());
		if (feeFormDef.getFileFeeDependentFormItem() != null) {
			for (FormItem item : form.getFormItems()) {
				if (item.getItemKey().equals(
						feeFormDef.getFileFeeDependentFormItem())) {
					fileTranslationFee *= Integer.parseInt(item.getItemValue());
				}
			}
		}
		fee.setFileTranslationFee(fileTranslationFee);
		fee.setNotaryFee(feeFormDef.getNotaryFee());
		return fee;
	}

	private FeeItem createYWXFFeeItem(Order order, FormDef formDef,
			FeeDef feeDef) {
		FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(
				Constants.YWXF_DEF_KEY);
		FeeItem fee = new FeeItem();
		fee.setFeeKey(formDef.getFormKey() + Constants.YWXF_KEY_SUFFIX);
		fee.setFeeName(formDef.getFormName() + Constants.YWXF_NAME_SUFFIX);
		fee.setCopyFee(order.getCertificateCopyCount() * feeDef.getCopyFee());
		fee.setInvestigationFee(feeFormDef.getInvestigateFee());
		fee.setWordTranslationFee(getWordTranslationFee(feeFormDef,
				order.getTranslationLanguage()));
		fee.setFileTranslationFee(getFileTranslationFee(feeFormDef,
				order.getTranslationLanguage()));
		fee.setNotaryFee(feeFormDef.getNotaryFee());
		return fee;
	}

	private double getWordTranslationFee(FeeFormDef def, Language lang) {
		switch (lang) {
		case English:
		case Japanese:
		case German:
		case French:
		case Russian:
			return def.getWordFeeGroup1();
		case Spanish:
		case Portuguese:
		case Italian:
			return def.getWordFeeGroup2();
		case Korean:
			return def.getWordFeeGroup3();
		case Dutch:
		case Ukrainian:
		case Czech:
		case Hungarian:
		case Vietnamese:
		case Thai:
			return def.getWordFeeGroup4();
		case Greek:
			return def.getWordFeeGroup5();
		default:
			return 0;
		}
	}

	private double getFileTranslationFee(FeeFormDef def, Language lang) {
		switch (lang) {
		case English:
		case Japanese:
		case German:
		case French:
		case Russian:
			return def.getFileFeeGroup1();
		case Spanish:
		case Portuguese:
		case Italian:
			return def.getFileFeeGroup2();
		case Korean:
			return def.getFileFeeGroup3();
		case Dutch:
		case Arabic:
		case Ukrainian:
		case Czech:
		case Hungarian:
		case Vietnamese:
		case Thai:
			return def.getFileFeeGroup4();
		case Greek:
			return def.getFileFeeGroup5();
		default:
			return 0;
		}
	}

	private String getItemValueFromForm(Form form, String itemKey) {
		Set<FormItem> items = form.getFormItems();
		for (FormItem item : items) {
			if (item.getItemKey().equals(itemKey)) {
				return item.getItemValue();
			}
		}

		return null;
	}

	private Form getFormByKeyFromOrder(Order order, String formKey) {
		Set<Form> forms = order.getForms();
		for (Form form : forms) {
			if (formKey.equals(form.getFormKey()))
				return form;
		}

		return null;
	}

	private FormItem getFormItemByKeyFromForm(Form form, String itemKey) {
		Set<FormItem> items = form.getFormItems();
		for (FormItem item : items) {
			if (itemKey.equals(item.getItemKey()))
				return item;
		}

		return null;
	}

	// private RelativeInfo getRelativeInfo(FormItem item, RelativeType type,
	// String name) {
	// RelativeInfo info = item.getRelativeInfo();
	// if (type.eq)
	// }
}