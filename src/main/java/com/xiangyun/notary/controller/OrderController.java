package com.xiangyun.notary.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Form;
import com.xiangyun.notary.domain.FormItem;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.form.FormDef;
import com.xiangyun.notary.form.FormDocItemDef;
import com.xiangyun.notary.form.FormFieldItemDef;
import com.xiangyun.notary.service.OrderService;
import com.xiangyun.notary.view.MultipleViewFactory;

@Controller
public class OrderController {
    private static Logger log = LoggerFactory.getLogger(OrderController.class);

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
    		                      @RequestParam("trans")boolean needTranslation,
    		                      @RequestParam("copies")int copies,
    		                      @RequestParam("purpose")CertificatePurpose purpose, 
    		                      HttpServletRequest request,
    		                      @RequestParam("notory_key")Collection<String> formKeys) {
    	log.info("Destination: " + destination);
    	log.info("Need translation? " + needTranslation);
    	log.info("Copies: " + copies);
    	log.info("Purpose: " + purpose);

        List<ModelAndView> mavList = new ArrayList<ModelAndView>();
        
        //Add the top part of the page 
    	ModelAndView top = new ModelAndView("certStep2Top");
    	mavList.add(top);
    	
    	//Add the middle part according selection
    	List<FormDef> selectedForms = new ArrayList<FormDef>();
    	//Is it possible the session expires and we should not create a new session here?
    	//The request.getSession() may create a new one, which may not be right.
    	Map<String, FormDef> formDefs = (Map<String, FormDef>)request.getSession().getServletContext().getAttribute(Constants.FORM_DEFS);
    	for (String key : formKeys) {
            FormDef formDef = formDefs.get(key);
            if (formDef != null) {   
                log.info("Form selected: " + formDef.getFormName());
                selectedForms.add(formDef);
                
                ModelAndView formMav = new ModelAndView("forms/" + formDef.getFormKey());
                mavList.add(formMav);
            }
        }
    	
    	request.getSession().setAttribute(Constants.SESSION_SELECTED_FORMS, selectedForms);    	

        //Create the order to save information for next step
        Order order = new Order();
        order.setCertificateCopyCount(copies);
        order.setCertificatePurpose(purpose);
        order.setDestination(destination);
        order.setNeedTranslation(needTranslation);
        order.setOrderDate(new Date());
        order.setOrderStatus(OrderStatus.SUBMITTED);
        order.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
        
        request.getSession().setAttribute(Constants.CURRENT_ORDER, order);
    	    
    	//Add the bottom part of the page
        ModelAndView bottom = new ModelAndView("certStep2Bottom");
        mavList.add(bottom);
        return multipleViewFactory.getView(mavList);
    }
    
    @RequestMapping(value = "/certStep3")
    public ModelAndView goToStep3(HttpServletRequest request) {
    	HttpSession session = request.getSession(false);
    	if (session == null) {
    		//TODO: redirect to login page
    		//But now for easy development, create a new session
    		session = request.getSession();
    	}
    	
        List<FormDef> selectedForms = (List<FormDef>)session.getAttribute(Constants.SESSION_SELECTED_FORMS);
        
        Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
        
        //May access /certStep3 directly
        if (selectedForms == null) {
            //TODO: should redirect to step1.
            //For easy development, directly return step3 for now.
            return new ModelAndView("certStep3");
        }
        
        Map<String, FormDocItemDef> allInOneUploadDocs = new HashMap<String, FormDocItemDef>();
        Map<String, FormDocItemDef> aloneUploadDocs = new HashMap<String, FormDocItemDef>();
        
        for (FormDef formDef : selectedForms) {
        	Form form = new Form();
        	form.setFormKey(formDef.getFormKey());
        	form.setFormName(formDef.getFormName());
        	
        	for ( FormFieldItemDef itemDef : formDef.getFields()) {
        		FormItem item = new FormItem();
        		item.setItemKey(itemDef.getFieldKey());
        		item.setItemName(itemDef.getFieldName());
        		item.setItemValue(request.getParameter(itemDef.getFieldKey()));
        		form.addFormItem(item);
        	}
        	
        	order.addForm(form);
        	
        	//Collect the doc items for upload
        	for ( FormDocItemDef docDef : formDef.getDocs()) {
        		if (docDef.isUploadAlone()) {
        			if (!aloneUploadDocs.containsKey(docDef.getDocKey())) {
        				aloneUploadDocs.put(docDef.getDocKey(), docDef);
        			}
        			
        		} else {
        			if (!allInOneUploadDocs.containsKey(docDef.getDocKey())) {
        				allInOneUploadDocs.put(docDef.getDocKey(), docDef);
        			}
        		}
        	}
        }
        
        orderService.save(order);
        
        //May move to further steps.
//        request.getSession().removeAttribute(Constants.CURRENT_ORDER);
//        request.getSession().removeAttribute(Constants.SESSION_SELECTED_FORMS);
        
        ModelAndView mav = new ModelAndView("certStep3");
        
        mav.addObject("allInOneUpload", allInOneUploadDocs.values());
        mav.addObject("aloneUpload", aloneUploadDocs.values());
        
        return mav;
    }
}
