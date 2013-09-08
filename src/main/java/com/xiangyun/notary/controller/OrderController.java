package com.xiangyun.notary.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
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
import com.xiangyun.notary.common.Language;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.common.RelativeType;
import com.xiangyun.notary.domain.FeeItem;
import com.xiangyun.notary.domain.Form;
import com.xiangyun.notary.domain.FormItem;
import com.xiangyun.notary.domain.Order;
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

@Controller
public class OrderController {
    private static Logger log = LoggerFactory.getLogger(OrderController.class);
    
    private SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy");
    
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
    //Automatic type conversion
    public View goToStep2(@RequestParam("dest")DestinationCountry destination, 
	                      @RequestParam("trans")Language transLanguage,
	                      @RequestParam("verify")boolean needVerify,
	                      @RequestParam("copies")int copies,
	                      @RequestParam("purpose")CertificatePurpose purpose, 
	                      HttpServletRequest request,
	                      @RequestParam("n_key")Collection<String> formKeys,
	                      @RequestParam("n_key_yw")Collection<String> ywKeys) {
        //TODO: If logged in, and then access step2 directly, then it will goes wrong.
        
    	log.debug("Destination: {}", destination);
    	log.debug("Translation language: {}", transLanguage);
    	log.debug("Copies: {}", copies);
    	log.debug("Purpose: {}", purpose);

        List<ModelAndView> mavList = new ArrayList<ModelAndView>();
        
        //Add the top part of the page 
    	ModelAndView top = new ModelAndView("certStep2Top");
    	User u = (User)request.getSession().getAttribute(Constants.LOGIN_USER);
    	top.addObject("currUser", u);
    	top.addObject("title", "输入信息");
    	mavList.add(top);
    	
    	//Add the middle part according selection
    	List<FormDef> selectedForms = new ArrayList<FormDef>();
    	
    	Map<String, FormDef> formDefs = (Map<String, FormDef>)ctx.getAttribute(Constants.FORM_DEFS);
    	for (String key : formKeys) {
            FormDef formDef = formDefs.get(key);
            if (formDef != null) {   
                log.info("Form selected: " + formDef.getFormName());
                selectedForms.add(formDef);
                
                if (formDef.isContainsItem()) {
                    ModelAndView formMav = new ModelAndView("forms/" + formDef.getFormKey());
                    mavList.add(formMav);
                }
            }
        }
    	
    	request.getSession().setAttribute(Constants.SESSION_SELECTED_FORMS, selectedForms);
    	
    	request.getSession().setAttribute(Constants.SESSION_SELECTED_YWXF, ywKeys);

        //Create the order to save information for next step
        Order order = new Order();
        order.setCertificateCopyCount(copies);
        order.setCertificatePurpose(purpose);
        order.setDestination(destination);
        order.setTranslationLanguage(transLanguage);
        order.setNeedVerify(needVerify);
        order.setOrderDate(new Date());
        order.setOrderStatus(OrderStatus.SUBMITTED);
        order.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
        order.setUser(u);
        
        request.getSession().setAttribute(Constants.CURRENT_ORDER, order);
    	    
    	//Add the bottom part of the page
        ModelAndView bottom = new ModelAndView("certStep2Bottom");
        mavList.add(bottom);
        return multipleViewFactory.getView(mavList);
    }
    
    @RequestMapping(value = "/certStep3")
    public ModelAndView goToStep3(HttpServletRequest request,
    		@RequestParam("username")String requestorName,
    		@RequestParam("mobile")String requestorMobile) {
        
    	HttpSession session = request.getSession(false);
        List<FormDef> selectedForms = (List<FormDef>)session.getAttribute(Constants.SESSION_SELECTED_FORMS);
        Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
        if (selectedForms == null || order == null) {
            ModelAndView mav = new ModelAndView("certStep1");
            mav.addObject("title", "选择申办业务");
            return mav;
        }
        
        order.setRequestorName(requestorName);
        order.setRequestorMobile(requestorMobile);        
        if (!StringUtils.isEmpty(request.getParameter("pinyin"))) 
            order.setRequestorNamePinyin(request.getParameter("pinyin"));
        if (!StringUtils.isEmpty(request.getParameter("email"))) 
            order.setRequestorEmail(request.getParameter("email"));
        String birthDate = request.getParameter("birthDate");
        try {
            if (!StringUtils.isEmpty(birthDate)) 
                order.setRequestorBirthDate(format.parse(birthDate));
        } catch (ParseException e) {
            log.error("Fail to parse the request parameter birthDate.", e);
        }
        
        Map<String, List<FormDocItemDef>> allInOneUploadDocs = new HashMap<String, List<FormDocItemDef>>();
        Map<String, FormDocItemDef> aloneUploadDocs = new HashMap<String, FormDocItemDef>();
        Map<String, FormDocItemDef> needCropDocs = new HashMap<String, FormDocItemDef>();
        
        //First put the 通用  docs in the map.
        Map<String, FormDef> formDefs = (Map<String, FormDef>)ctx.getAttribute(Constants.FORM_DEFS);
        FormDef ty = formDefs.get("TY");
        for (FormDocItemDef docDef : ty.getDocs()) {
            putIfAbsent(allInOneUploadDocs, ty, docDef);
        }
        
        for (FormDef formDef : selectedForms) {
        	Form form = new Form();
        	form.setFormKey(formDef.getFormKey());
        	form.setFormName(formDef.getFormName());
        	
        	//Create FormItems for a form
        	Map<String, String> formKeyValueMap = new HashMap<String, String>();
        	for ( FormFieldItemDef itemDef : formDef.getFields()) {
    	        FormItem item = new FormItem();
                item.setItemKey(itemDef.getFieldKey());
                item.setItemName(itemDef.getFieldName());
                if (itemDef.isComposite()) {
                	//QSGX item
                    RelativeInfo info = createRelativeInfo(itemDef.getFieldKey(), request);
                    if (info == null) {
                        break;
                    }
                    item.setRelativeInfo(info);
                } else {
                    item.setItemValue(request.getParameter(itemDef.getFieldKey()));
                    //Put it to a map for doc dependency. Currently no doc depends on a composite value.
                    //So just put it in the "else"
                    formKeyValueMap.put(itemDef.getFieldKey(), request.getParameter(itemDef.getFieldKey()));
                }
                form.addFormItem(item);
        	}
        	
        	//Create FeeItems for a form
        	FeeDef feeDef = (FeeDef)ctx.getAttribute(Constants.FEE_DEF);
        	form.addFeeItem(createGeneralFeeItem(order, formDef, feeDef));
        	
        	Collection<String> ywKeys = (Collection<String>)session.getAttribute(Constants.SESSION_SELECTED_YWXF);
        	if (ywKeys.contains(formDef.getFormKey() + Constants.YWXF_KEY_SUFFIX)) {
        	    form.addFeeItem(createYWXFFeeItem(order, formDef, feeDef));
        	}
        	
        	order.addForm(form);
        	
        	//Collect the doc items for upload
        	for ( FormDocItemDef docDef : formDef.getDocs()) {
        	    boolean shouldPut = true;
        	    if (docDef.isDependent() && formKeyValueMap.get(docDef.getDependOn()) != null 
        	            && formKeyValueMap.get(docDef.getDependOn()).equals("false")) {
                    shouldPut = false;
                }
        	    
        	    if (shouldPut && docDef.isNeedCrop()) {
        	        putIfAbsent(needCropDocs, docDef);
        	        
        	    } else if (shouldPut && docDef.isUploadAlone()) {
        	        putIfAbsent(aloneUploadDocs, docDef);
        			
        		} else if (shouldPut){
        		    putIfAbsent(allInOneUploadDocs, formDef, docDef);
        		    
        		}
        	}
        	
        	//Add docItems for QSGX
        	if (formDef.getFormKey().equals(Constants.QSGX_FORM_KEY)) {
        		for (FormItem item : form.getFormItems()) {
        			if (item.getRelativeInfo() != null) {
        				FormDocItemDef idDocDef = new FormDocItemDef();
        				idDocDef.setDocKey(item.getItemKey() + Constants.QSGX_DOC_ID_SUFFIX);
        				idDocDef.setDocName(Constants.QSGX_DOC_ID_TEMPLATE.replace("%", item.getRelativeInfo().getRelativeName()));
        				putIfAbsent(allInOneUploadDocs, formDef, idDocDef);
        				
        				FormDocItemDef hkDocDef = new FormDocItemDef();
        				hkDocDef.setDocKey(item.getItemKey() + Constants.QSGX_DOC_HK_SUFFIX);
        				hkDocDef.setDocName(Constants.QSGX_DOC_HK_TEMPLATE.replace("%", item.getRelativeInfo().getRelativeName()));
        				putIfAbsent(allInOneUploadDocs, formDef, hkDocDef);
        			}
        		}
        	}
        }
        
        order.calculateTotalFee();
        orderService.save(order);
        
        //May move to further steps.
//        request.getSession().removeAttribute(Constants.CURRENT_ORDER);
//        request.getSession().removeAttribute(Constants.SESSION_SELECTED_FORMS);
        
        ModelAndView mav = new ModelAndView("certStep3");
        mav.addObject("title", "上传资料");
        
        UploadModel m = new UploadModel();
        m.setUid(order.getId());
        m.setAllInOneUpload(allInOneUploadDocs);
        m.setAloneUpload(aloneUploadDocs.values());
        m.setNeedCrop(needCropDocs.values());
        
        mav.addObject("um", m);
        
        return mav;
    }

    @RequestMapping(value = "/certStep4.do")
    public ModelAndView goToStep4(@RequestParam("upload_note") String uploadNote,
            					  HttpServletRequest request) {
    	
    	Order order = (Order)request.getSession(false).getAttribute(Constants.CURRENT_ORDER);
        if (order == null) {
            ModelAndView mav = new ModelAndView("certStep1");
            mav.addObject("title", "选择申办业务");
            return mav;
        }
    	
    	order.setUploadNote(uploadNote);
    	
    	orderService.save(order);
    	
        ModelAndView mav = new ModelAndView("certStep4");
        mav.addObject("title", "上门送证");
        return mav;
    }
    
    @RequestMapping(value = "/certStep5.do")
    public ModelAndView goToStep5(@RequestParam("sendDoc") boolean sendDoc,
                                  HttpServletRequest request) {
        
        log.debug("Should send doc? {}", sendDoc);
        
        HttpSession session = request.getSession(false);
        Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
        if (order == null) {
            ModelAndView mav = new ModelAndView("certStep1");
            mav.addObject("title", "选择申办业务");
            return mav;
        }
        
        order.setSendDoc(sendDoc);
        if (sendDoc) {
            order.setSendAddress(request.getParameter("sendAddress"));
            try {
                order.setSendDate(format.parse(request.getParameter("sendDate")));
            } catch (ParseException e) {
                log.error("Error occurs during paring the sendDate.", e);
            }
        }
        
        order.calculateTotalFee();
        
        orderService.save(order);
        
        ModelAndView mav = new ModelAndView("certStep5");
        mav.addObject("title", "支付");
        mav.addObject("order", order);
        return mav;
    }
    
    @RequestMapping(value = "/payment.do")
    public String goToPayment(HttpServletRequest request) {
    	Order order = (Order)request.getSession(false).getAttribute(Constants.CURRENT_ORDER);
    	StringBuilder sb = new StringBuilder("redirect:/pay?WIDout_trade_no=");
    	sb.append(order.getReadableId());
    	sb.append("&WIDsubject=TestString");
    	sb.append("&WIDtotal_fee=0.01");
    	sb.append("&WIDbody=aaaa");
    	sb.append("&WIDshow_url=bbbb");
    	
    	return sb.toString();
    }
    
    @RequestMapping(value = "/orderQuery.do")
    public ModelAndView orderQuery(HttpServletRequest request) {
    	User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
    	
    	//Cannot use user.getOrders() directly.
    	//Otherwise org.hibernate.LazyInitializationException will throw,
    	//because the Hibernate session has closed.
    	
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
    	
    	String readableId = request.getParameter("rId");
    	if (StringUtils.isEmpty(readableId)) readableId = null;
    	
    	OrderStatus status = null;
    	String statusStr = request.getParameter("status");
    	if (!StringUtils.isEmpty(statusStr)) status = OrderStatus.valueOf(statusStr);
    	
    	Long userId = null;
    	if (!user.isAdmin() && !user.isStaff()) {
    	    userId = user.getId();
    	}
    	
        Long orderCount = orderService.getOrderCount(readableId, status, userId);
        Long pageCount = (orderCount - 1) / Constants.QUERY_PAGE_SIZE + 1;
        List<Order> orders = orderService.findOrders(readableId, status, userId, pageNum);
    	
    	ModelAndView mav = new ModelAndView("backend/orderQuery");
    	mav.addObject("title", "订单查询");
    	mav.addObject("pageCount", pageCount);
    	mav.addObject("currPage", pageNum);
    	//Need to compute in Java. The we can leverage the feature that integer/integer is still a integer
    	//In JSTL, integer/integer can be float/double, which is not good for this computation.
    	mav.addObject("loopBegin", ((pageNum - 1) / 5) * 5 + 1);
    	mav.addObject("loopEnd", (((pageNum - 1) / 5) * 5 + 5 < pageCount) ? ((pageNum - 1) / 5) * 5 + 5 : pageCount);
    	mav.addObject("left", (((pageNum - 1) / 5) * 5 - 4));
    	mav.addObject("right", (((pageNum - 1) / 5) * 5 + 6));
    	mav.addObject("orders", orders);
    	return mav;
    }
    
    @RequestMapping(value = "/orderDetail.do")
    public ModelAndView orderDetail(HttpServletRequest request) {
        String oId = request.getParameter("oId");
        if (StringUtils.isEmpty(oId)) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Long orderId = null;
        try {
            orderId = Long.valueOf(oId);
        } catch (NumberFormatException e) {
            log.warn("oId is not a valid number", e);
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
        Long userId = null;
        if (!user.isAdmin() && !user.isStaff()) {
            userId = user.getId();
        }
        
        Order order = orderService.findOrderById(orderId, userId);
        if (order == null) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Map<String, FormDef> formDefs = (Map<String, FormDef>)ctx.getAttribute(Constants.FORM_DEFS);
        Map<String, List<FormDocItemDef>> allInOneUploadDocs = new HashMap<String, List<FormDocItemDef>>();
        //First put the 通用  docs in the map.
        FormDef ty = formDefs.get("TY");
        for (FormDocItemDef docDef : ty.getDocs()) {
            putIfAbsent(allInOneUploadDocs, ty, docDef);
        }
        
        Set<Form> forms = order.getForms();
        for (Form form : forms) {
            //Put form key/value pairs in a map for doc dependency.
            Map<String, String> formKeyValueMap = new HashMap<String, String>();
            for (FormItem formItem : form.getFormItems()) {
                formKeyValueMap.put(formItem.getItemKey(), formItem.getItemValue());
            }
            
            FormDef formDef = formDefs.get(form.getFormKey());
            //Collect the doc items for display
            for ( FormDocItemDef docDef : formDef.getDocs()) {
                boolean shouldPut = true;
                if (docDef.isDependent() && formKeyValueMap.get(docDef.getDependOn()) != null 
                        && formKeyValueMap.get(docDef.getDependOn()).equals("false")) {
                    shouldPut = false;
                }
                
                if (shouldPut && !docDef.isNeedCrop() && !docDef.isUploadAlone()){
                    putIfAbsent(allInOneUploadDocs, formDef, docDef);
                }
            }
        }
        
        ModelAndView mav = new ModelAndView("backend/orderDetail");
        mav.addObject("title", "订单详情");
        mav.addObject("order", order);
        mav.addObject("allInOneDocs", allInOneUploadDocs.values());
        
        return mav;
    }
    
    @RequestMapping(value = "/orderAccept.do")
    public ModelAndView orderAccept(HttpServletRequest request) {
        String oId = request.getParameter("oId");
        if (StringUtils.isEmpty(oId)) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Long orderId = null;
        try {
            orderId = Long.valueOf(oId);
        } catch (NumberFormatException e) {
            log.warn("oId is not a valid number", e);
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
        Long userId = null;
        if (!user.isAdmin() && !user.isStaff()) {
            userId = user.getId();
        }
        
        Order order = orderService.findOrderById(orderId, userId);
        if (order == null) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        ModelAndView mav = new ModelAndView("backend/orderAccept");
        mav.addObject("title", "订单受理");
        mav.addObject("order", order);
        
        return mav;
        
    }
    
    @RequestMapping(value = "/doAccept.do")
    public ModelAndView doAccept(HttpServletRequest request, 
            @RequestParam("oId") Long oId, 
            @RequestParam("notaryId") String notaryId) {
        if (StringUtils.isEmpty(oId)) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Long orderId = null;
        try {
            orderId = Long.valueOf(oId);
        } catch (NumberFormatException e) {
            log.warn("oId is not a valid number", e);
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
        Long userId = null;
        if (!user.isAdmin() && !user.isStaff()) {
            userId = user.getId();
        }
        
        Order order = orderService.findOrderById(orderId, userId);
        if (order == null) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        order.setBackendNotaryId(notaryId);
        order.setOrderStatus(OrderStatus.ACCEPTED);
        orderService.save(order);
        
        ModelAndView mav = new ModelAndView("backend/orderAccept");
        mav.addObject("title", "订单受理");
        mav.addObject("order", order);
        
        return mav;
    }
    
    @RequestMapping(value = "/orderCancel.do")
    public ModelAndView orderCancel(HttpServletRequest request) {
        String oId = request.getParameter("oId");
        if (StringUtils.isEmpty(oId)) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Long orderId = null;
        try {
            orderId = Long.valueOf(oId);
        } catch (NumberFormatException e) {
            log.warn("oId is not a valid number", e);
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
        Long userId = null;
        if (!user.isAdmin() && !user.isStaff()) {
            userId = user.getId();
        }
        
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
    public ModelAndView doCancel(HttpServletRequest request, 
            @RequestParam("oId") Long oId, 
            @RequestParam("cancel_note") String cancelNote) {
        if (StringUtils.isEmpty(oId)) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        Long orderId = null;
        try {
            orderId = Long.valueOf(oId);
        } catch (NumberFormatException e) {
            log.warn("oId is not a valid number", e);
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        User user = (User) request.getSession(false).getAttribute(Constants.LOGIN_USER);
        Long userId = null;
        if (!user.isAdmin() && !user.isStaff()) {
            userId = user.getId();
        }
        
        Order order = orderService.findOrderById(orderId, userId);
        if (order == null) {
            return new ModelAndView("redirect:orderQuery.do");
        }
        
        order.setCancelNote(cancelNote);
        order.setOrderStatus(OrderStatus.CANCEL_REQUESTED);
        orderService.save(order);
        
        ModelAndView mav = new ModelAndView("backend/orderAccept");
        mav.addObject("title", "订单受理");
        mav.addObject("order", order);
        
        return mav;
    }

    private void putIfAbsent(Map<String, FormDocItemDef> docDefs, FormDocItemDef docDef) {
        if (!docDefs.containsKey(docDef.getDocKey())) {
            docDefs.put(docDef.getDocKey(), docDef);
        }
        
    }
    
    private void putIfAbsent(Map<String, List<FormDocItemDef>> docDefs, FormDef formDef, FormDocItemDef docDef) {
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
            
            if (contained) break;
        }
        
        if (!contained) {
            formDocs.add(docDef);
        }
        
    }

    private RelativeInfo createRelativeInfo(String fieldKey, HttpServletRequest request) {
        String typeStr = request.getParameter(fieldKey);        
        if (StringUtils.isEmpty(typeStr)) {
            //Empty means no value is submitted. That will happen when this field is not display on web page.
            //So return null to allow skip the rest.
            return null;
        } else if ("NULL".equals(typeStr)) {
            throw new IllegalArgumentException("The QSGX form must select a relativeType other than NULL");
        }
        RelativeType type = RelativeType.valueOf(typeStr);
        String name = request.getParameter(fieldKey + Constants.QSGX_NAME_SUFFIX);
        
        log.debug("relativeType is: " + type + " relativeName is: " + name);
        
        RelativeInfo result = new RelativeInfo();
        result.setRelativeType(type);
        result.setRelativeName(name);
        return result;
        
    }
    
    private FeeItem createGeneralFeeItem(Order order, FormDef formDef, FeeDef feeDef) {
        FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(formDef.getFormKey());
        FeeItem fee = new FeeItem();
        fee.setFeeKey(formDef.getFormKey());
        fee.setFeeName(formDef.getFormName());
        fee.setCopyFee(order.getCertificateCopyCount() * feeDef.getCopyFee());
        fee.setInvestigationFee(feeFormDef.getInvestigateFee());
        fee.setWordTranslationFee(getWordTranslationFee(feeFormDef, order.getTranslationLanguage()));
        fee.setFileTranslationFee(getFileTranslationFee(feeFormDef, order.getTranslationLanguage()));
        fee.setNotaryFee(feeFormDef.getNotaryFee());
        return fee;
    }
    
    private FeeItem createYWXFFeeItem(Order order, FormDef formDef, FeeDef feeDef) {
        FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(Constants.YWXF_DEF_KEY);
        FeeItem fee = new FeeItem();
        fee.setFeeKey(formDef.getFormKey() + Constants.YWXF_KEY_SUFFIX);
        fee.setFeeName(formDef.getFormName() + Constants.YWXF_NAME_SUFFIX);
        fee.setCopyFee(order.getCertificateCopyCount() * feeDef.getCopyFee());
        fee.setInvestigationFee(feeFormDef.getInvestigateFee());
        fee.setWordTranslationFee(getWordTranslationFee(feeFormDef, order.getTranslationLanguage()));
        fee.setFileTranslationFee(getFileTranslationFee(feeFormDef, order.getTranslationLanguage()));
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
}
