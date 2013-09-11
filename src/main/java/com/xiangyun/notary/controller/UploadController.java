package com.xiangyun.notary.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
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
	                	                
	                String fileName = saveUploadedFileForCrop(cropDir, mpf, docKey);
	                
	                return "getImage/" + uid + "/" + fileName + ".do";
	                
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
	public @ResponseBody byte[] getImageForCrop(@PathVariable String uid, @PathVariable String imageName, HttpServletResponse response) throws IOException {
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
		log.debug("Now is cropping the image... ");
		log.debug("Original file width is: " + bi.getWidth() + "px");
		
		//On page the original image may be resized, because we use a Bootstrap span7 to contain it, which has a width of 540px.
		//So if the image size is larger than 540px, it will be resized on client side.
		//Here we need to consider it to get the correct sub image.
		if (bi.getWidth() > 540) {
		    double ratio = bi.getWidth() / 540.0;
		    log.debug("The ratio is: " + ratio);
		    x *= ratio;
		    y *= ratio;
		    w *= ratio;
		    h *= ratio;
		}
		
		BufferedImage sub = bi.getSubimage(x, y, w, h);
		
		BufferedImage result = Scalr.resize(sub, 120, 180);
		
		String docPath = getSaveDir(uid.toString(), dockey) + imageName;
		ImageIO.write(result, "jpg", new File(docPath));
		
		Order order = orderService.findById(uid);
		//Need to add or update!
		boolean isUpdate = false;
		for (DocItem item : order.getDocs()) {
		    if (dockey.equals(item.getDocKey())) {
		        //The DocItem is already there, so need to update it.
		        //Looks like only docPath can change
		        item.setDocPath(docPath);
		        isUpdate = true;
		        break;
		    }
		}
		if (!isUpdate) 
		    order.addDoc(createDocItem(dockey, getDocNameFromKey(dockey), null, "", docPath));
		
        orderService.save(order);
		
        //return the docPath
		return "getCroppedImage/" + uid + "/" + dockey + "/" + imageName + ".do";
	}
	
	@RequestMapping(value="/getCroppedImage/{uid}/{dockey}/{imageName}", produces={MediaType.IMAGE_GIF_VALUE,MediaType.IMAGE_JPEG_VALUE,MediaType.IMAGE_PNG_VALUE })
    public @ResponseBody byte[] getCroppedImage(@PathVariable String uid, @PathVariable String dockey, @PathVariable String imageName, HttpServletResponse response) throws IOException {
        log.info("To getCroppedImage for order: " + uid + ", dockey: " + dockey + ", imageName: " + imageName);
        
        File imageFile = new File(getSaveDir(uid.toString(), dockey) + imageName);
        byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(imageFile);

        response.setHeader("Content-Disposition", "attachment; filename=\"" + imageFile.getName() + "\"");
        response.setContentLength(bytes.length);
        response.setContentType("image/jpeg");

        return bytes;

    }
	
	@RequestMapping(value = "/getFile/{uid}/{fileName}", method = RequestMethod.GET)
	public void getFile(@PathVariable("uid") String orderId, @PathVariable("fileName") String fileName, HttpServletResponse response) {
	    
	    try {
	        String docKey = fileName.lastIndexOf(".") >= 0 ? fileName.substring(0, fileName.lastIndexOf(".")) : fileName;
            String saveDir = getSaveDir(orderId, docKey);
            
            if (Constants.ALL_IN_ONE_KEY.equals(docKey)) {
                String zipFileName = orderId + ".zip";
                String zipFullPath = saveDir + zipFileName;
                FileOutputStream fos = new FileOutputStream(zipFullPath);
                ZipOutputStream zos = new ZipOutputStream(fos);
                
                File dir = new File(saveDir);
                Map<String, String> files = new HashMap<String, String>();
                addDir(dir, zos, files);
                zos.close();
                
                response.setContentType("application/zip");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");
                // get your file as InputStream
                FileInputStream is = new FileInputStream(zipFullPath);;
                // copy it to response's OutputStream
                IOUtils.copy(is, response.getOutputStream());
                response.flushBuffer();
//                } else {
//                    //TODO: No file uploaded. So need to find a way to let client know there is no files.
//                }
            } else {
                //Upload alone or need crop doc
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                // get your file as InputStream
                FileInputStream is = new FileInputStream(saveDir + File.separator + fileName);;
                // copy it to response's OutputStream
                IOUtils.copy(is, response.getOutputStream());
                response.flushBuffer();
            }

        } catch (FileNotFoundException e) {
            log.error("Error occurs during zipping files for order. Order id: " + orderId, e);
        } catch (IOException e) {
            log.error("Error occurs during zipping files or downloading. Order id: " + orderId, e);
        }
	}
	
    private void addDir(File dirObj, ZipOutputStream out, Map<String, String> processedFiles) throws IOException {
        File[] files = dirObj.listFiles();

        for (int i = 0; i < files.length; i++) {
            if (files[i].isDirectory() && !files[i].getName().equals(Constants.FOR_CROP_DIR)) {
                addDir(files[i], out, processedFiles);
                continue;
            } 
            
            if (files[i].isFile() && !files[i].getName().endsWith(".zip")) {
            	if (processedFiles.containsKey(files[i].getName()) == false) {
            		FileInputStream in = new FileInputStream(files[i].getAbsolutePath());
                    out.putNextEntry(new ZipEntry(files[i].getName()));
                    IOUtils.copy(in, out);
                    out.closeEntry();
                    in.close();
                    
                    processedFiles.put(files[i].getName(), files[i].getName());
            	}
                
            }
        }
    }

    private String getSaveDir(String orderId, String docKey) {
        StringBuilder sb = new StringBuilder();
        sb.append(docSaveDir).append(orderId).append(File.separator);
        if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            sb.append(docKey).append(File.separator);
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
        sb.append(docSaveDir).append(orderId).append(File.separator).append("forCrop").append(File.separator);
        
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
    
    private String saveUploadedFileForCrop(String destDir, MultipartFile mpf, String docKey) {
        String fileName = mpf.getOriginalFilename();
        String suffix = "";
        if (fileName.lastIndexOf('.') != -1) {
            suffix = fileName.substring(fileName.lastIndexOf('.'));
        }
        
        String docPath = destDir + docKey + suffix;
        
        try {
            mpf.transferTo(new File(docPath));
        } catch (IllegalStateException e) {
            log.error("Error throw during transfer uploaded file.", e);
        } catch (IOException e) {
            log.error("Error throw during transfer uploaded file.", e);
        }
        
        return docKey + suffix;
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
    
    private void updateDocItem(DocItem item, String docKey, String docName, Long fileSize, String fileContentType, String docPath) {
        if (!Constants.ALL_IN_ONE_KEY.equals(docKey)) {
            item.setDocKey(docKey);
            item.setDocName(docName);
        } else {
            item.setDocKey(null);
            item.setDocName(null);
        }
        item.setDocPath(docPath);                
        item.setDocSize(fileSize);
        item.setContentType(fileContentType);
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

