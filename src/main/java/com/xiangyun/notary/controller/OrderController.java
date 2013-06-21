package com.xiangyun.notary.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
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
    		                      @RequestParam("purpose")CertificatePurpose purpose) {
    	log.info("Destination: " + destination);
    	log.info("Need translation? " + needTranslation);
    	log.info("Copies: " + copies);
    	log.info("Purpose: " + purpose);
    	ModelAndView mav = new ModelAndView("/WEB-INF/views/certStep2.jsp");
    	return mav;
    }
}
