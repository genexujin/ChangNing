package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "form_items")
@NamedQueries({
    @NamedQuery(name="FormItem.findAll", query="select o from FormItem o")
})
public class FormItem implements Serializable {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Column(name = "item_key")
    private String itemKey;
    
    @Column(name = "item_name")
    private String itemName;
    
	@Column(name = "item_value")
    private String itemValue;
    
    @ManyToOne
    @JoinColumn(name="form_id")
    private Form form;
    
    @OneToOne(cascade = CascadeType.ALL, mappedBy="formItem")
    private RelativeInfo relativeInfo;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getItemKey() {
        return itemKey;
    }

    public void setItemKey(String itemKey) {
        this.itemKey = itemKey;
    }
    
    public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }

    public Form getForm() {
        return form;
    }

    public void setForm(Form form) {
        this.form = form;
    }
    
    public RelativeInfo getRelativeInfo() {
        return relativeInfo;
    }

    public void setRelativeInfo(RelativeInfo relativeInfo) {
        relativeInfo.setFormItem(this);
        this.relativeInfo = relativeInfo;
    }

}
