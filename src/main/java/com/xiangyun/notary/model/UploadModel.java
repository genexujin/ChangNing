package com.xiangyun.notary.model;

import java.util.Collection;

import com.xiangyun.notary.form.FormDocItemDef;

public class UploadModel {
    private Long uid;
    private Collection<FormDocItemDef> allInOneUpload;
    private Collection<FormDocItemDef> aloneUpload;
    private Collection<FormDocItemDef> needCrop;

    public Long getUid() {
        return uid;
    }
    
    public void setUid(Long uid) {
        this.uid = uid;
    }
    
    public Collection<FormDocItemDef> getAllInOneUpload() {
        return allInOneUpload;
    }
    
    public void setAllInOneUpload(Collection<FormDocItemDef> allInOneUpload) {
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

}
