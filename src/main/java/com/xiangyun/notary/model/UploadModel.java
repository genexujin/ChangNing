package com.xiangyun.notary.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import com.xiangyun.notary.form.FormDocItemDef;

public class UploadModel implements Serializable {
	private static final long serialVersionUID = 1L;
	
    private Long uid;
    private String orderReadableId;
    private Map<String, List<FormDocItemDef>> allInOneUpload;
    private Collection<FormDocItemDef> aloneUpload;
    private Collection<FormDocItemDef> needCrop;

    public Long getUid() {
        return uid;
    }
    
    public void setUid(Long uid) {
        this.uid = uid;
    }
    
    public String getOrderReadableId() {
		return orderReadableId;
	}

	public void setOrderReadableId(String orderReadableId) {
		this.orderReadableId = orderReadableId;
	}

	public Map<String, List<FormDocItemDef>> getAllInOneUpload() {
        return allInOneUpload;
    }
    
    public void setAllInOneUpload(Map<String, List<FormDocItemDef>> allInOneUpload) {
        this.allInOneUpload = allInOneUpload;
    }
    
    public Collection<FormDocItemDef> getAloneUpload() {
        return aloneUpload;
    }
    
    public void setAloneUpload(Collection<FormDocItemDef> aloneUpload) {
        this.aloneUpload = aloneUpload;
    }
    
    public Collection<FormDocItemDef> getNeedCrop() {
        return needCrop;
    }

    public void setNeedCrop(Collection<FormDocItemDef> needCrop) {
        this.needCrop = needCrop;
    }
    
    public boolean isAllInOneUploadEmpty() {
        return allInOneUpload.isEmpty();
    }
    
    public boolean isAloneUploadEmpty() {
        return aloneUpload.isEmpty();
    }
    
    public boolean isNeedCropEmpty() {
        return needCrop.isEmpty();
    }
    
    public Collection<List<FormDocItemDef>> getAllInOneValues() {
        return allInOneUpload.values();
    }

}
