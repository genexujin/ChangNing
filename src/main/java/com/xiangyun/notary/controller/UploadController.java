package com.xiangyun.notary.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.DocItem;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.form.FormDocItemDef;
import com.xiangyun.notary.service.OrderService;

@Controller
public class UploadController {
	private static Logger log = LoggerFactory.getLogger(UploadController.class);
	
	@Autowired
	CommonsMultipartResolver multiResolver;
	
	@Autowired
	private ServletContext ctx;
	
	@Value("${docSaveDir}")
	private String docSaveDir;
	
    @Autowired
    private OrderService orderService;
	
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public @ResponseBody String upload(MultipartHttpServletRequest request, HttpServletResponse response, Long uid, String docKey, boolean needCrop) {
        log.debug("Order Id is: {}", uid);
        log.debug("Doc Key is: {}", docKey);

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
			
	        if (needCrop) { //Upload for crop
	        	String cropDir = getCropDir(order.getId().toString());
	            
	            Iterator<String> fileNames = request.getFileNames();
	            
	            //Only one file
	            if (fileNames.hasNext()) {
	                MultipartFile mpf = request.getFile(fileNames.next());
	                log.info("File uploaded: " + mpf.getOriginalFilename());
	                	                
	                saveUploadedFile(cropDir, mpf);
	                
	                return "getImage/" + uid + "/" + mpf.getOriginalFilename() + ".do";
	                
	            }
	        } else { //No need to crop, so upload it and save the order
		        String saveDir = getSaveDir(order.getId().toString(), docKey);
				
//	            List<DocItem> docs = new ArrayList<DocItem>();
			        
	            Iterator<String> fileNames = request.getFileNames();

	            while (fileNames.hasNext()) {
	                MultipartFile mpf = request.getFile(fileNames.next());
	                log.info("File uploaded: " + mpf.getOriginalFilename());
	                
	                String docPath = saveUploadedFile(saveDir, mpf);

	                DocItem docItem = createDocItem(docKey, getDocNameFromKey(docKey), mpf.getSize(), mpf.getContentType(), docPath);

//	                docs.add(docItem);
	                order.addDoc(docItem);
	                orderService.save(order);
	            }
	            //返回任何字符串都认为是上传成功了！如果没任何返回则是404 NOT FOUND，如果服务端抛出异常了则是500 
	            //之后要配置一下抛出异常后显示什么页面
	            return "";
	        }
			
		} 
		return "";
	}
	
	@RequestMapping(value="/getImage/{uid}/{imageName}", produces={MediaType.IMAGE_GIF_VALUE,MediaType.IMAGE_JPEG_VALUE,MediaType.IMAGE_PNG_VALUE })
	public @ResponseBody byte[] getImage(@PathVariable String uid, @PathVariable String imageName, HttpServletResponse response) throws IOException {
		log.info("To getImage for: " + imageName);
		
		File imageFile = new File(getCropDir(uid) + imageName);
	    byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(imageFile);

	    response.setHeader("Content-Disposition", "attachment; filename=\"" + imageFile.getName() + "\"");
	    response.setContentLength(bytes.length);
	    response.setContentType("image/jpeg");

	    return bytes;

	}
	
	@RequestMapping(value="/cropImage", method=RequestMethod.POST)
	public @ResponseBody String cropImage(int x, int y, int x2, int y2, int w, int h, Long uid, String imageName, String dockey) throws IOException {
		BufferedImage bi = ImageIO.read(new File(getCropDir(uid.toString()) + imageName));
		
		BufferedImage result = bi.getSubimage(x, y, w, h);
		
		String docPath = getSaveDir(uid.toString(), dockey) + imageName;
		ImageIO.write(result, "jpg", new File(docPath));
		
		Order order = orderService.findById(uid);
		order.addDoc(createDocItem(dockey, getDocNameFromKey(dockey), null, "", docPath));
        orderService.save(order);
		
		return "success";
	}

    private String getSaveDir(String orderId, String docKey) {
        StringBuilder sb = new StringBuilder();
        sb.append(docSaveDir).append(orderId).append("/");
        if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            sb.append(docKey).append("/");
        }
        
        String saveDir = sb.toString();
        
        File dir = new File(saveDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return saveDir;
    }
    
    private String getCropDir(String orderId) {
        StringBuilder sb = new StringBuilder();
        sb.append(docSaveDir).append(orderId).append("/").append("forCrop").append("/");
        
        String saveDir = sb.toString();
        
        File dir = new File(saveDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return saveDir;
    }

    private String saveUploadedFile(String destDir, MultipartFile mpf) {
        String docPath = destDir + mpf.getOriginalFilename();
        
        try {
            mpf.transferTo(new File(docPath));
        } catch (IllegalStateException e) {
            log.error("Error throw during transfer uploaded file.", e);
        } catch (IOException e) {
            log.error("Error throw during transfer uploaded file.", e);
        }
        
        return docPath;
    }
    
    private DocItem createDocItem(String docKey, String docName, Long fileSize, String fileContentType, String docPath) {
        DocItem docItem = new DocItem();
        if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            docItem.setDocKey(docKey);
            docItem.setDocName(docName);
            
        }
        docItem.setDocPath(docPath);                
        docItem.setDocSize(fileSize);
        docItem.setContentType(fileContentType);
        return docItem;
    }
    
    private String getDocNameFromKey(String docKey) {
        if (Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            return null;
        }
        
        Map<String, FormDocItemDef> docItemDefs = (Map<String, FormDocItemDef>)ctx.getAttribute(Constants.DOC_ITEM_MAP);
        FormDocItemDef docItemDef = docItemDefs.get(docKey);
        return docItemDef.getDocName();
    }
}

