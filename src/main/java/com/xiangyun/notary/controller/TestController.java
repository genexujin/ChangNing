package com.xiangyun.notary.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.domain.Test;
import com.xiangyun.notary.service.TestService;

@Controller
public class TestController {
    private static Logger log = LoggerFactory.getLogger(TestController.class);
    
    @Autowired
    private TestService service;

    @RequestMapping(value = "/test.do")
    public ModelAndView testPage() {
        log.debug("Now it is in {}", "/test.do");
        log.info("Now it is in {}", "/test.do");
        log.warn("Now it is in {}", "/test.do");
        ModelAndView mav = new ModelAndView("/WEB-INF/views/test.jsp");
        mav.addObject("theKey", "abcde");
        
        List<Test> tests = service.findAll();
        mav.addObject("testSize", tests.size());
        
        return mav;
    }

}
