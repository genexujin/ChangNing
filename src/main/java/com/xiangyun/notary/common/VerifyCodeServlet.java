package com.xiangyun.notary.common;

import java.awt.Color;      
import java.awt.Font;      
import java.awt.Graphics2D;      
import java.awt.image.BufferedImage;      
import java.util.Random;      
import javax.imageio.ImageIO;      
import javax.servlet.ServletException;      
import javax.servlet.ServletOutputStream;      
import javax.servlet.http.HttpServlet;      
import javax.servlet.http.HttpServletRequest;      
import javax.servlet.http.HttpServletResponse;      
import javax.servlet.http.HttpSession;      
     
public class VerifyCodeServlet extends HttpServlet {      
     
    // 验证码图片的宽度。      
    private int width = 100;      
     
    // 验证码图片的高度。      
    private int height = 30;      
     
    // 验证码字符个数      
    private int codeCount = 4;      
     
    private int x = 0;      
     
    // 字体高度      
    private int fontHeight;      
     
    private int codeY;      
     
    int[] codeSequence = { 1,2,3,4,5,6,7,8,9 }; 
    
    private int codePlus(int num1,int num2){
    	return num1 + num2;
    }
    private int codeMinus(int num1,int num2){
    	
    	return num1 - num2;
    }
     
    private int codeMultiply(int num1,int num2){
    	return num1*num2;
    }
    /**     
     * 初始化验证图片属性     
     */     
    public void init() throws ServletException {      
        // 从web.xml中获取初始信息      
        // 宽度      
        String strWidth = this.getInitParameter("width");      
        // 高度      
        String strHeight = this.getInitParameter("height");      
        // 字符个数      
        String strCodeCount = this.getInitParameter("codeCount");      
     
        // 将配置的信息转换成数值      
        try {      
            if (strWidth != null && strWidth.length() != 0) {      
                width = Integer.parseInt(strWidth);      
            }      
            if (strHeight != null && strHeight.length() != 0) {      
                height = Integer.parseInt(strHeight);      
            }      
            if (strCodeCount != null && strCodeCount.length() != 0) {      
                codeCount = Integer.parseInt(strCodeCount);      
            }      
        } catch (NumberFormatException e) {      
        }      
     
        x = width / (codeCount + 1);      
        fontHeight = height - 2;      
        codeY = height - 4;      
     
    }      
     
    protected void service(HttpServletRequest req, HttpServletResponse resp)      
            throws ServletException, java.io.IOException {      
     
        // 定义图像buffer      
        BufferedImage buffImg = new BufferedImage(width, height,      
                BufferedImage.TYPE_INT_RGB);      
        Graphics2D g = buffImg.createGraphics();      
     
        // 创建一个随机数生成器类      
        Random random = new Random();      
     
        // 将图像填充为白色      
        g.setColor(Color.WHITE);      
        g.fillRect(0, 0, width, height);      
     
        // 创建字体，字体的大小应该根据图片的高度来定。      
        Font font = new Font("Fixedsys", Font.PLAIN, fontHeight);      
        // 设置字体。      
        g.setFont(font);      
     
        // 画边框。      
        g.setColor(Color.BLACK);      
        g.drawRect(0, 0, width - 1, height - 1);      
     
        int randInt1 = codeSequence[random.nextInt(9)];
        int randInt2 = codeSequence[random.nextInt(9)];
        if(randInt1<randInt2){
        	int temp = randInt2;
        	randInt2 = randInt1;
        	randInt1 = temp;
        }
        if(randInt1==randInt2){
        	randInt1=randInt1+1;
        }
        String randomCode = new String();
        int numOperate = 0;
        StringBuffer randomCodeFinal = new StringBuffer();
        int randCondition = random.nextInt(3);
        if(randCondition==0){
        	randomCode = randInt1+"+"+randInt2+"=";
        	numOperate = codePlus(randInt1, randInt2);
        }else if(randCondition==1){
        	randomCode = randInt1+"-"+randInt2+"=";
        	numOperate = codeMinus(randInt1, randInt2);
        }else {
        	randomCode = randInt1+"x"+randInt2+"=";
        	numOperate = codeMultiply(randInt1, randInt2);
		}
        
        int red = 0, green = 0, blue = 0;      
     
        // 随机产生codeCount数字的验证码。      
        for (int i = 0; i < 4; i++) {      
            String strRand = new String(); 
        	char str = randomCode.toCharArray()[i];
        	strRand = String.valueOf(str);
            // 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。      
            red = random.nextInt(255);      
            green = random.nextInt(255);      
            blue = random.nextInt(255);      
            // 用随机产生的颜色将验证码绘制到图像中。      
            g.setColor(new Color(red, green, blue));      
            g.drawString(strRand, (i + 1) * x, codeY);  
            randomCodeFinal.append(strRand);      
        }      
        // 将四位的验证码保存到Session中。      
        HttpSession session = req.getSession();      
        session.setAttribute("validateCode", String.valueOf(numOperate));      
     
        // 禁止图像缓存。      
        resp.setHeader("Pragma", "no-cache");      
        resp.setHeader("Cache-Control", "no-cache");      
        resp.setDateHeader("Expires", 0);      
     
        resp.setContentType("image/jpeg");      
     
        // 将图像输出到Servlet输出流中。      
        ServletOutputStream sos = resp.getOutputStream();      
        ImageIO.write(buffImg, "jpeg", sos);      
        sos.close();      
    }      
     
}    