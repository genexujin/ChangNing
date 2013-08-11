package com.xiangyun.notary.form;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class FeeDef implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private double copyFee;
    private Map<String, FeeFormDef> feeFormDefs= new HashMap<String, FeeFormDef>();
    
    public double getCopyFee() {
        return copyFee;
    }
    public void setCopyFee(double copyFee) {
        this.copyFee = copyFee;
    }
    public Map<String, FeeFormDef> getFeeFormDefs() {
        return feeFormDefs;
    }
    public void setFeeFormDefs(Map<String, FeeFormDef> feeFormDefs) {
        this.feeFormDefs = feeFormDefs;
    }

}
