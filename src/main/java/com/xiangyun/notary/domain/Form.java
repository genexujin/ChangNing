package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "forms")
@NamedQueries({
    @NamedQuery(name="Form.findAll", query="select o from Form o")
})
public class Form implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Column(name = "form_key")
    private String formKey;
    
    @Column(name = "form_name")
    private String formName;

	@ManyToOne
    @JoinColumn(name="order_id")
    private Order order;
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "form")
    private Set<FormItem> formItems = new HashSet<FormItem>();
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "form")
    private Set<FeeItem> feeItems = new TreeSet<FeeItem>(new FeeItemNameComparator());

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFormKey() {
        return formKey;
    }

    public void setFormKey(String formKey) {
        this.formKey = formKey;
    }
    
    public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
    
    public Set<FormItem> getFormItems() {
        return formItems;
    }

    public void setFormItems(Set<FormItem> formItems) {
        this.formItems = formItems;
    }
    
    public void addFormItem(FormItem formItem) {
        formItem.setForm(this);
        formItems.add(formItem);
    }
    
    public Set<FeeItem> getFeeItems() {
        return feeItems;
    }

    public void setFeeItems(Set<FeeItem> feeItems) {
        this.feeItems = feeItems;
    }
    
    public void addFeeItem(FeeItem feeItem) {
        feeItem.setForm(this);
        feeItems.add(feeItem);
    }
    
    public double calculateFormFee() {
        double result = 0.0;
        for (FeeItem item : feeItems) {
            result += item.calculateFee();
        }
        return result;
    }
    
    private static class FeeItemNameComparator implements Comparator<FeeItem> {

        @Override
        public int compare(FeeItem item1, FeeItem item2) {
            return item1.getFeeName().compareTo(item2.getFeeName());
        }
        
    }

}
