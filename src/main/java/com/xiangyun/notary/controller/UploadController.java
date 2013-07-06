package com.xiangyun.notary.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.DocItem;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.service.OrderService;

@Controller
public class UploadController {
	private static Logger log = LoggerFactory.getLogger(UploadController.class);
	
	@Autowired
	CommonsMultipartResolver multiResolver;
	
	@Value("${docSaveDir}")
	private String docSaveDir;
	
    @Autowired
    private OrderService orderService;
	
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public @ResponseBody String upload(MultipartHttpServletRequest request, HttpServletResponse response, Long uid, String docKey, String docName) {
        log.info("Order Id is: " + uid);
        log.info("Doc Key is: " + docKey);
        log.info("Doc Name is: " + docName);
	    
	    Order order = orderService.findById(uid);
		
	    //It is not possible to get the same session in FF! In Chrome and IE are all ok!
	    //What a weird thing.
	    //So need to use Uploadify's "formData"
//		HttpSession session = request.getSession(false);
//		if (session == null) {
//		}		
//		Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
	    
		if (order != null) {
			log.info("Upload for order: " + order.getId());
		     
	        String saveDir = getSaveDir(order, docKey);
			
            List<DocItem> docs = new ArrayList<DocItem>();
		        
            Iterator<String> fileNames = request.getFileNames();

            while (fileNames.hasNext()) {
                MultipartFile mpf = request.getFile(fileNames.next());
                log.info("File uploaded: " + mpf.getOriginalFilename());
                
                String docPath = saveDir + mpf.getOriginalFilename();

                DocItem docItem = new DocItem();
                if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
                    docItem.setDocKey(docKey);
                    try {
                        docItem.setDocName(new String(docName.getBytes(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        log.error("Error occur during upload", e);
                    }
                }
                docItem.setDocPath(docPath);                
                docItem.setDocSize(mpf.getSize());
                docItem.setContentType(mpf.getContentType());

                try {
                    mpf.transferTo(new File(docPath));
                } catch (IllegalStateException e) {
                    log.error("Error throw during transfer uploaded file.", e);
                } catch (IOException e) {
                    log.error("Error throw during transfer uploaded file.", e);
                }

                docs.add(docItem);
                order.addDoc(docItem);
                orderService.save(order);
            }
            //返回任何字符串都认为是上传成功了！
            return "";
			
		} else {
		    return "";
		}
	}

    private String getSaveDir(Order order, String docKey) {
        StringBuilder sb = new StringBuilder();
        sb.append(docSaveDir).append(order.getId()).append("/");
        if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            sb.append(docKey).append("/");
        }
        
        String saveDir = sb.toString();
        
        File dir = new File(saveDir);
        if (!dir.exists()) {
            dir.mkdir();
        }
        return saveDir;
    }
}

