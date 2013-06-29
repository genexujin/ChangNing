package com.xiangyun.notary.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import com.xiangyun.notary.view.MultipleViewFactory;

@Controller
public class FormsController {
    private static Logger log = LoggerFactory.getLogger(FormsController.class);
    
    @Autowired 
    private MultipleViewFactory multipleViewFactory;
    
    @RequestMapping(value = "/forms")
    public View getForm() {
        ModelAndView jh = new ModelAndView("forms/JH");
        ModelAndView xl = new ModelAndView("forms/XL");
        List<ModelAndView> mavList = new ArrayList<ModelAndView>();
        mavList.add(jh);
        mavList.add(xl);
        return multipleViewFactory.getView(mavList);
    }

}
