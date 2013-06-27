package com.xiangyun.notary.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Form;
import com.xiangyun.notary.domain.FormItem;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.form.FormDef;
import com.xiangyun.notary.form.FormFieldItemDef;
import com.xiangyun.notary.service.OrderService;

@Controller
public class OrderController {
    private static Logger log = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;
    
    @RequestMapping(value = "/certStep1.do")
    public ModelAndView goToStep1() {
    	ModelAndView mav = new ModelAndView("/WEB-INF/views/certStep1.jsp");
    	return mav;
    }
    
    @RequestMapping(value = "/certStep2.do")
    //Automatic type conversion
    public ModelAndView goToStep2(@RequestParam("dest")DestinationCountry destination, 
    		                      @RequestParam("trans")boolean needTranslation,
    		                      @RequestParam("copies")int copies,
    		                      @RequestParam("purpose")CertificatePurpose purpose, 
    		                      HttpServletRequest request,
    		                      @RequestParam("notory_key")Collection<String> formKeys) {
    	log.info("Destination: " + destination);
    	log.info("Need translation? " + needTranslation);
    	log.info("Copies: " + copies);
    	log.info("Purpose: " + purpose);
    	
    	List<FormDef> selectedForms = new ArrayList<FormDef>();
    	Map<String, FormDef> formDefs = (Map<String, FormDef>)request.getSession().getServletContext().getAttribute(Constants.FORM_DEFS);
    	for (String key : formKeys) {
    	    FormDef formDef = formDefs.get(key);
    	    if (formDef != null) {   
    	        log.info("Form selected: " + formDef.getFormName());
    	        selectedForms.add(formDef);
    	    }
    	}
    	
    	request.getSession().setAttribute(Constants.SESSION_SELECTED_FORMS, selectedForms);
    	
    	Order order = new Order();
    	order.setCertificateCopyCount(copies);
    	order.setCertificatePurpose(purpose);
    	order.setDestination(destination);
    	order.setNeedTranslation(needTranslation);
    	order.setOrderDate(new Date());
    	order.setOrderStatus(OrderStatus.SUBMITTED);
    	order.setPaymentStatus(OrderPaymentStatus.NOT_PAID);
    	
    	request.getSession().setAttribute(Constants.CURRENT_ORDER, order);
    	
    	ModelAndView mav = new ModelAndView("/WEB-INF/views/certStep2.jsp");
    	
    	return mav;
    }
    
    @RequestMapping(value = "/certStep3.do")
    public ModelAndView goToStep3(HttpServletRequest request) {
        List<FormDef> selectedForms = (List<FormDef>)request.getSession().getAttribute(Constants.SESSION_SELECTED_FORMS);
        
        Order order = (Order)request.getSession().getAttribute(Constants.CURRENT_ORDER);
        
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
        }
        
        orderService.save(order);
        
        request.getSession().removeAttribute(Constants.CURRENT_ORDER);
        request.getSession().removeAttribute(Constants.SESSION_SELECTED_FORMS);
        
        ModelAndView mav = new ModelAndView("/WEB-INF/views/certStep3.jsp");
        
        return mav;
    }
}
