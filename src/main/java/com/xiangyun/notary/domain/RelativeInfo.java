package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.xiangyun.notary.common.RelativeType;

@Entity
@Table(name = "relative_infos")
@NamedQueries({
    @NamedQuery(name="RelativeInfo.findAll", query="select o from RelativeInfo o")
})
public class RelativeInfo {
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "relative_type")
    private RelativeType relativeType;
    
    @Column(name = "relative_name")
    private String relativeName;
    
    @OneToOne
    @JoinColumn(name="form_item_id")
    private FormItem formItem;
    
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public RelativeType getRelativeType() {
        return relativeType;
    }
    public void setRelativeType(RelativeType relativeType) {
        this.relativeType = relativeType;
    }
    public String getRelativeName() {
        return relativeName;
    }
    public void setRelativeName(String relativeName) {
        this.relativeName = relativeName;
    }
    public FormItem getFormItem() {
        return formItem;
    }
    public void setFormItem(FormItem formItem) {
        this.formItem = formItem;
    }

}
