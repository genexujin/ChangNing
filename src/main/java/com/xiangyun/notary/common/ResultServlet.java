package com.xiangyun.notary.common;

import java.io.IOException;      
import java.io.PrintWriter;      
     
import javax.servlet.ServletException;      
import javax.servlet.http.HttpServlet;      
import javax.servlet.http.HttpServletRequest;      
import javax.servlet.http.HttpServletResponse;      
     
public class ResultServlet extends HttpServlet {      
     
    /**     
     * The doGet method of the servlet. <br>     
     *     
     * This method is called when a form has its tag value method equals to get.     
     *      
     * @param request the request send by the client to the server     
     * @param response the response send by the server to the client     
     * @throws ServletException if an error occurred     
     * @throws IOException if an error occurred     
     */     
    public void doGet(HttpServletRequest request, HttpServletResponse response)      
            throws ServletException, IOException {      
     
        doPost(request, response);      
    }      
     
    /**     
     * The doPost method of the servlet. <br>     
     *     
     * This method is called when a form has its tag value method equals to post.     
     *      
     * @param request the request send by the client to the server     
     * @param response the response send by the server to the client     
     * @throws ServletException if an error occurred     
     * @throws IOException if an error occurred     
     */     
    public void doPost(HttpServletRequest request, HttpServletResponse response)      
            throws ServletException, IOException {      
     
        response.setContentType("text/html;charset=utf-8");      
        String validateC = (String) request.getSession().getAttribute("validateCode");      
        String veryCode = request.getParameter("c");
        PrintWriter out = response.getWriter();      
//        System.out.println("verifycode is :" + veryCode);
//        System.out.println("validateC is :" + validateC);
        if(validateC==null||veryCode==null||"".equals(veryCode)){
            out.println("请输入图片中的结果！");      
        }else{      
            if(validateC.equals(veryCode)){      
                out.println(0);      
            }else{      
                out.println(1);      
            }      
        }      
        out.flush();      
        out.close();      
    }      
     
}    