package com.xiangyun.notary.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.form.DocMeta;

@Controller
public class UploadController {
	private static Logger log = LoggerFactory.getLogger(UploadController.class);
	
	@Autowired
	CommonsMultipartResolver multiResolver;
	
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public @ResponseBody List<DocMeta> upload(MultipartHttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession(false);
		if (session == null) {
			//TODO: return an error message to say need to re login
		}
	
		File docSaveDiretory = multiResolver.getFileItemFactory().getRepository();
		//And then we can copy it to the place we want! Not a good solution. 
		//How to avoid the file copy? setRepository() seems not work, because the file has been written to disk now.
		
		Order order = (Order)session.getAttribute(Constants.CURRENT_ORDER);
		if (order != null) {
			log.info("Upload for order: " + order.getId());
			
		} else {
			//TODO: return an error message to say need to re login
		}
		
		
		List<DocMeta> docs = new ArrayList<DocMeta>();
		
		Iterator<String> fileNames = request.getFileNames();
		
		String saveDir = "c:/tmp/";
		
		while (fileNames.hasNext()) {
			MultipartFile mpf = request.getFile(fileNames.next());
			log.info("File uploaded: " + mpf.getOriginalFilename());
			
			DocMeta meta = new DocMeta();
			meta.setDocName(mpf.getOriginalFilename());
			meta.setDocSize(mpf.getSize());
			meta.setDocType(mpf.getContentType());
			
			try {
				mpf.transferTo( new File(saveDir + mpf.getOriginalFilename()) );
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			docs.add(meta);
		}
		return docs;
	}

}
