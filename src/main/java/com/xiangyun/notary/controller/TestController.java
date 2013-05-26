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
        
        //Search for all
        List<Test> tests = service.findAll();
        mav.addObject("testSize", tests.size());
        mav.addObject("tests", tests);
        
        //Now update them
        List<Test> tests2 = service.findAll();
        for (Test t : tests2) {
            t.setDescription(t.getDescription() + "_updated");
            service.save(t);
        }
        mav.addObject("tests2", tests2);
        
        //Now delete one
        //This will thrown an exception if no @Transactional is added to the service: 
        //java.lang.IllegalArgumentException: Removing a detached instance com.xiangyun.notary.domain.Test#1
        Test toBeDeleted = tests2.get(0); 
        service.delete(toBeDeleted);
        mav.addObject("tests3", service.findAll());
        
        //Now insert one
        Test t = new Test("New inserted");
        service.save(t);
        mav.addObject("tests4", service.findAll());
        
        return mav;
    }

}
