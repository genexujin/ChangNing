package com.xiangyun.notary.view;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;


@Component
public class MultipleViewFactory {
    private static Logger log = LoggerFactory.getLogger(MultipleViewFactory.class);
    
    @Autowired 
    private ViewResolver viewResolver;
    
    public View getView(List<ModelAndView> mavList) {
        for (ModelAndView mav : mavList) {
            if (mav.getView()==null) {
                mav.setView(resolve(mav.getViewName()));
            }
        }
        return new MultipleView(mavList);
    }
    
    private View resolve(String viewName) {
//        for (ViewResolver vr : viewResolverList) {
            try {
                View view = viewResolver.resolveViewName(viewName, LocaleContextHolder.getLocale());

                if (view!=null) {
                    return view;
                }
            } catch (Exception e) {
                log.warn("Error during resolve view!", e);
            }
//        }
        return null;
    }

}
