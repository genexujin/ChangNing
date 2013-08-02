package com.xiangyun.notary;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xiangyun.notary.form.FormDef;
import com.xiangyun.notary.form.FormDocItemDef;
import com.xiangyun.notary.form.FormFieldItemDef;

/**
 * Application Lifecycle Listener implementation class InitContextListener
 * 
 */
public class InitContextListener implements ServletContextListener {
    private static final Logger log = LoggerFactory.getLogger(InitContextListener.class);

    private static ObjectMapper mapper = new ObjectMapper();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        log.info("Initializing context... ");
        // Initialize the FormDef and put it into ServletContext
        try {
            InputStream is = Thread.currentThread().getContextClassLoader().getResourceAsStream("form_definition.json");
            Map<String, FormDef> formDefs = mapper.readValue(is, new TypeReference<Map<String, FormDef>>() {});
            
            sce.getServletContext().setAttribute(Constants.FORM_DEFS, formDefs);
            
            //Also initialize a map for FormDocItemDef
            Map<String, FormDocItemDef> docItemDefs = new HashMap<String, FormDocItemDef>();
            
            for (FormDef form : formDefs.values()) {
                log.debug("Form Key: {}", form.getFormKey());
                log.debug("Form Name: {}", form.getFormName());
                log.debug("Form Fields: ");
                for (FormFieldItemDef field : form.getFields()) {
                    log.debug("    Field Key: {}", field.getFieldKey());
                    log.debug("    Field Name: {}", field.getFieldName());
                }
                log.debug("Form Docs: ");
                for (FormDocItemDef doc : form.getDocs()) {
                    log.debug("    Doc Key: {}", doc.getDocKey());
                    log.debug("    Doc Name: {}", doc.getDocName());
                    log.debug("    Upload Alone? {}", doc.isUploadAlone());
                    log.debug("    Need Crop? {}", doc.isNeedCrop());
                    log.debug("    Is Dependent? {}", doc.isDependent());
                    log.debug("    Depend on: {}", doc.getDependOn());
                    
                    if (!docItemDefs.containsKey(doc.getDocKey())) {
                        docItemDefs.put(doc.getDocKey(), doc);
                    }
                }
            }
            
            sce.getServletContext().setAttribute(Constants.DOC_ITEM_MAP, docItemDefs);
            
        } catch (JsonParseException e) {
            log.error("Json document error.", e);
        } catch (JsonMappingException e) {
            log.error("Json document error.", e);
        } catch (IOException e) {
            log.error("Could not open form_definition.json.", e);
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // No need to do anything

    }

}
