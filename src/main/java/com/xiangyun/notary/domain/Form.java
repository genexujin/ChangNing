package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

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

}
