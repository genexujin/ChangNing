package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "test")
@NamedQueries({
    @NamedQuery(name="Test.findAll",
                query="select c from Test c")
})
public class Test implements Serializable {
    private Long id;
    private String description;
    
    public Test() {
    }

    public Test(String description) {
        this.description = description;
    }
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "test_id")
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    @Column(name = "test_description")
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

}
