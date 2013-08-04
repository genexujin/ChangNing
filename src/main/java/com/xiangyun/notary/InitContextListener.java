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
import com.xiangyun.notary.form.FeeDef;
import com.xiangyun.notary.form.FeeFormDef;
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
        // Initialize the FeeFormDef and put it into ServletContext
        InputStream is = null;
        InputStream is2 = null;
        try {
            is = Thread.currentThread().getContextClassLoader().getResourceAsStream("form_definition.json");
            Map<String, FormDef> formDefs = mapper.readValue(is, new TypeReference<Map<String, FormDef>>() {});
            
            is2 = Thread.currentThread().getContextClassLoader().getResourceAsStream("fee_definition.json");
            FeeDef feeDef = mapper.readValue(is2, FeeDef.class);
            
            sce.getServletContext().setAttribute(Constants.FORM_DEFS, formDefs);
            sce.getServletContext().setAttribute(Constants.FEE_DEF, feeDef);
            
            //Also initialize a map for FormDocItemDef
            Map<String, FormDocItemDef> docItemDefs = new HashMap<String, FormDocItemDef>();
            
            log.debug("**********Form Def info**********");
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
            
            log.debug("**********Fee Def info**********");
            log.debug("Investigation Fee: {}", feeDef.getInvestigateFee());
            log.debug("Copy Fee: {}", feeDef.getCopyFee());
            for (String formKey : feeDef.getFeeFormDefs().keySet()) {
                log.debug("Form Key: {}", formKey);
                FeeFormDef feeFormDef = feeDef.getFeeFormDefs().get(formKey);
                log.debug("    Notary Fee: {}", feeFormDef.getNotaryFee());
                log.debug("    Word Fee Group 1: {}", feeFormDef.getWordFeeGroup1());
                log.debug("    File Fee Group 1: {}", feeFormDef.getFileFeeGroup1());
                log.debug("    Word Fee Group 2: {}", feeFormDef.getWordFeeGroup2());
                log.debug("    File Fee Group 2: {}", feeFormDef.getFileFeeGroup2());
                log.debug("    Word Fee Group 3: {}", feeFormDef.getWordFeeGroup3());
                log.debug("    File Fee Group 3: {}", feeFormDef.getFileFeeGroup3());
                log.debug("    Word Fee Group 4: {}", feeFormDef.getWordFeeGroup4());
                log.debug("    File Fee Group 4: {}", feeFormDef.getFileFeeGroup4());
                log.debug("    Word Fee Group 5: {}", feeFormDef.getWordFeeGroup5());
                log.debug("    File Fee Group 5: {}", feeFormDef.getFileFeeGroup5());
            }
            
        } catch (JsonParseException e) {
            log.error("Json document error.", e);
        } catch (JsonMappingException e) {
            log.error("Json document error.", e);
        } catch (IOException e) {
            log.error("Could not open form_definition.json.", e);
        } finally {
            try {
                if (is != null) {
                    is.close();
                }
                if (is2 != null) {
                    is2.close();
                }
            } catch (IOException e) {
                log.error("Error occurs during closing the InputStreams.", e);
            }
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // No need to do anything

    }

}
