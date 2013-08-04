package com.xiangyun.notary.form;

import java.util.HashMap;
import java.util.Map;

public class FeeDef {
    private double investigateFee;
    private double copyFee;
    private Map<String, FeeFormDef> feeFormDefs= new HashMap<String, FeeFormDef>();
    
    public double getInvestigateFee() {
        return investigateFee;
    }
    public void setInvestigateFee(double investigateFee) {
        this.investigateFee = investigateFee;
    }
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
