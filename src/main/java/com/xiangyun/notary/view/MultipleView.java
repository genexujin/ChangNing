package com.xiangyun.notary.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

public class MultipleView implements View {
    
    private final List<ModelAndView> mavList;

    public MultipleView(List<ModelAndView> mavList) {
        this.mavList = mavList;
    }

    @Override
    public String getContentType() {
        return "text/html";
    }

    @Override
    public void render(Map<String, ?> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        StringBuilder result = new StringBuilder();
        for (ModelAndView mav : mavList) {
            MockHttpServletResponse mockResponse = new MockHttpServletResponse();
            mav.getView().render(mav.getModel(), request, mockResponse);
            result.append(mockResponse.getContentAsString());
        }
        response.getOutputStream().write(result.toString().getBytes("UTF-8"));
        response.getOutputStream().close();
        
    }

}
