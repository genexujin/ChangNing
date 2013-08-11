package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "fee_items")
@NamedQueries({
    @NamedQuery(name="FeeItem.findAll", query="select o from FeeItem o")
})
public class FeeItem implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Column(name = "fee_key")
    private String feeKey;
    
    @Column(name = "fee_name")
    private String feeName;
    
    @Column(name = "notary_fee")
    private double notaryFee;
    
    @Column(name = "copy_fee")
    private double copyFee;
    
    @Column(name = "word_trans_fee")
    private double wordTranslationFee;
    
    @Column(name = "file_trans_fee")
    private double fileTranslationFee;
    
    @Column(name = "investigate_fee")
    private double investigationFee;
    
    @ManyToOne
    @JoinColumn(name="form_id")
    private Form form;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFeeKey() {
        return feeKey;
    }

    public void setFeeKey(String feeKey) {
        this.feeKey = feeKey;
    }

    public String getFeeName() {
        return feeName;
    }

    public void setFeeName(String feeName) {
        this.feeName = feeName;
    }

    public double getNotaryFee() {
        return notaryFee;
    }

    public void setNotaryFee(double notaryFee) {
        this.notaryFee = notaryFee;
    }

    public double getCopyFee() {
        return copyFee;
    }

    public void setCopyFee(double copyFee) {
        this.copyFee = copyFee;
    }

    public double getWordTranslationFee() {
        return wordTranslationFee;
    }

    public void setWordTranslationFee(double wordTranslationFee) {
        this.wordTranslationFee = wordTranslationFee;
    }

    public double getFileTranslationFee() {
        return fileTranslationFee;
    }

    public void setFileTranslationFee(double fileTranslationFee) {
        this.fileTranslationFee = fileTranslationFee;
    }

    public double getInvestigationFee() {
        return investigationFee;
    }

    public void setInvestigationFee(double investigationFee) {
        this.investigationFee = investigationFee;
    }

    public Form getForm() {
        return form;
    }

    public void setForm(Form form) {
        this.form = form;
    }
    
    public double calculateFee() {
        double result = 0.0;
        result += notaryFee;
        result += copyFee;
        result += investigationFee;
        result += wordTranslationFee;
        //Don't deal with "见文件报价" for now
        if (fileTranslationFee > 0) {
            result += fileTranslationFee;
        }
        return result;
    }
}
