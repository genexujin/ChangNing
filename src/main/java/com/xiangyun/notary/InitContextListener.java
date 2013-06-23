package com.xiangyun.notary;

import java.io.IOException;
import java.io.InputStream;
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
            
            for (FormDef form : formDefs.values()) {
                log.info("Form Key: " + form.getFormKey());
                log.info("Form Name: " + form.getFormName());
                log.info("Form Fields: ");
                for (FormFieldItemDef field : form.getFields()) {
                    log.info("    Field Key: " + field.getFieldKey());
                    log.info("    Field Name: " + field.getFieldName());
                }
                log.info("Form Docs: ");
                for (FormDocItemDef doc : form.getDocs()) {
                    log.info("    Doc Key: " + doc.getDocKey());
                    log.info("    Doc Name: " + doc.getDocName());
                    log.info("    Upload Alone? " + doc.isUploadAlone());
                }
            }
            
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
