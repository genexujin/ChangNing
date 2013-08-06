package com.xiangyun.notary.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.xiangyun.notary.common.Gender;
import com.xiangyun.notary.common.Language;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.common.RelativeType;
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
    private MultipleViewFactory multipleViewFactory;
    
    @RequestMapping(value = "/certStep1.do")
    public ModelAndView goToStep1() {
    	ModelAndView mav = new ModelAndView("certStep1");
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
    		                      @RequestParam("notory_key")Collection<String> formKeys) {
    	log.debug("Destination: {}", destination);
    	log.debug("Translation language: {}", transLanguage);
    	log.debug("Copies: {}", copies);
    	log.debug("Purpose: {}", purpose);

        List<ModelAndView> mavList = new ArrayList<ModelAndView>();
        
        //Add the top part of the page 
    	ModelAndView top = new ModelAndView("certStep2Top");
    	User u = (User)request.getSession().getAttribute(Constants.LOGIN_USER);
    	top.addObject("currUser", u);
    	mavList.add(top);
    	
    	//Add the middle part according selection
    	List<FormDef> selectedForms = new ArrayList<FormDef>();
    	//TODO: Is it possible the session expires and we should not create a new session here?
    	//The request.getSession() may create a new one, which may not be right.
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
    		@RequestParam("gender")Gender requestorGender,
    		@RequestParam("mobile")String requestorMobile,
    		@RequestParam("email")String requestorEmail,
    		@RequestParam("address")String requestorAddress) {
        
    	HttpSession session = request.getSession(false);
    	if (session == null) {
    		//TODO: redirect to login page
    		//But now for easy development, create a new session
    		session = request.getSession();
    	}
    	
        List<FormDef> selectedForms = (List<FormDef>)session.getAttribute(Constants.SESSION_SELECTED_FORMS);
        
        Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
        order.setRequestorName(requestorName);
        order.setRequestorGender(requestorGender);
        order.setRequestorMobile(requestorMobile);
        order.setRequestorEmail(requestorEmail);
        order.setRequestorAddress(requestorAddress);
        
        //May access /certStep3 directly
        if (selectedForms == null) {
            //TODO: should redirect to step1.
            //For easy development, directly return step3 for now.
            return new ModelAndView("certStep3");
        }
        
        Map<String, FormDocItemDef> allInOneUploadDocs = new HashMap<String, FormDocItemDef>();
        Map<String, FormDocItemDef> aloneUploadDocs = new HashMap<String, FormDocItemDef>();
        Map<String, FormDocItemDef> needCropDocs = new HashMap<String, FormDocItemDef>();
        
        for (FormDef formDef : selectedForms) {
        	Form form = new Form();
        	form.setFormKey(formDef.getFormKey());
        	form.setFormName(formDef.getFormName());
        	
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
        		    putIfAbsent(allInOneUploadDocs, docDef);
        		    
        		}
        	}
        	
        	//Add docItems for QSGX
        	if (formDef.getFormKey().equals(Constants.QSGX_FORM_KEY)) {
        		for (FormItem item : form.getFormItems()) {
        			if (item.getRelativeInfo() != null) {
        				FormDocItemDef idDocDef = new FormDocItemDef();
        				idDocDef.setDocKey(item.getItemKey() + Constants.QSGX_DOC_ID_SUFFIX);
        				idDocDef.setDocName(Constants.QSGX_DOC_ID_TEMPLATE.replace("%", item.getRelativeInfo().getRelativeName()));
        				putIfAbsent(allInOneUploadDocs, idDocDef);
        				
        				FormDocItemDef hkDocDef = new FormDocItemDef();
        				hkDocDef.setDocKey(item.getItemKey() + Constants.QSGX_DOC_HK_SUFFIX);
        				hkDocDef.setDocName(Constants.QSGX_DOC_HK_TEMPLATE.replace("%", item.getRelativeInfo().getRelativeName()));
        				putIfAbsent(allInOneUploadDocs, hkDocDef);
        			}
        		}
        	}
        }
        
        orderService.save(order);
        
        //May move to further steps.
//        request.getSession().removeAttribute(Constants.CURRENT_ORDER);
//        request.getSession().removeAttribute(Constants.SESSION_SELECTED_FORMS);
        
        ModelAndView mav = new ModelAndView("certStep3");
        
        UploadModel m = new UploadModel();
        m.setUid(order.getId());
        m.setAllInOneUpload(allInOneUploadDocs.values());
        m.setAloneUpload(aloneUploadDocs.values());
        m.setNeedCrop(needCropDocs.values());
        
        mav.addObject("um", m);
        
        return mav;
    }
    
    @RequestMapping(value = "/certStep4.do")
    public ModelAndView goToStep4() {
        ModelAndView mav = new ModelAndView("certStep4");
        return mav;
    }
    
    @RequestMapping(value = "/certStep5.do")
    public ModelAndView goToStep5(@RequestParam("sendDoc") boolean sendDoc,
                                  HttpServletRequest request) {
        
        log.debug("Should send doc? {}", sendDoc);
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            //TODO: redirect to login page
            //But now for easy development, create a new session
            session = request.getSession();
        }
        
        Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
        order.setSendDoc(sendDoc);
        if (sendDoc) {
            order.setSendAddress(request.getParameter("sendAddress"));
            try {
                order.setSendDate(format.parse(request.getParameter("sendDate")));
            } catch (ParseException e) {
                log.error("Error occurs during paring the sendDate.", e);
            }
        }
        
        orderService.save(order);
        
        FeeDef feeDef = (FeeDef)ctx.getAttribute(Constants.FEE_DEF);
        //Then calculate the total fee
        double totalFee = 0.0;
        
        DestinationCountry dest = order.getDestination();
        int copies = order.getCertificateCopyCount();
        
        for (Form form : order.getForms()) {
            FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(form.getFormKey());
            
        }
        
        ModelAndView mav = new ModelAndView("certStep4");
        return mav;
    }

    private void putIfAbsent(Map<String, FormDocItemDef> docDefs, FormDocItemDef docDef) {
        if (!docDefs.containsKey(docDef.getDocKey())) {
            docDefs.put(docDef.getDocKey(), docDef);
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
}
