package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CredentialType;
import com.xiangyun.notary.common.Gender;

@Entity
@Table(name = "users")
@NamedQueries({ @NamedQuery(name = "User.findAll", query = "select u from User u") })
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    private String mobile;

    private String name;
    
    @Enumerated(EnumType.STRING)
    private Gender gender;

	private String email;

    @Column(name = "cred_type")
    @Enumerated(EnumType.STRING)
    private CredentialType credentialType;

    @Column(name = "cred_id")
    private String credentialId;

    private String password;

    @Column(name = "birth_date")
    private Date birthDate;

    private String address;

    @Lob
    @Column(name = "cred_copy")
    private byte[] credentialCopy;

    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "user")
    private Set<Order> orders = new HashSet<Order>();
    
    @ManyToMany(cascade = CascadeType.REFRESH)
    @JoinTable(name = "user_roles", 
               inverseJoinColumns = @JoinColumn(name = "role_id"), 
               joinColumns = @JoinColumn(name = "user_id"))
    private Set<Role> roles = new HashSet<Role>();

	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public CredentialType getCredentialType() {
        return credentialType;
    }

    public void setCredentialType(CredentialType credentialType) {
        this.credentialType = credentialType;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public byte[] getCredentialCopy() {
        return credentialCopy;
    }

    public void setCredentialCopy(byte[] credentialCopy) {
        this.credentialCopy = credentialCopy;
    }

    public String getCredentialId() {
        return credentialId;
    }

    public void setCredentialId(String credentialId) {
        this.credentialId = credentialId;
    }

    public Set<Order> getOrders() {
        return orders;
    }

    public void setOrders(Set<Order> orders) {
        this.orders = orders;
    }

    public void addOrder(Order order) {
        order.setUser(this);
        orders.add(order);
    }

    public Set<Role> getRoles() {
		return roles;
	}

	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}
	
	public void addRole(Role role) {
		roles.add(role);
	}
	
	public boolean isAdmin() {
		for (Role role : roles) {
			if (role.getRoleName().equals(Constants.ROLE_ADMIN))
				return true;
		}
		return false;
	}
	
	public boolean isStaff() {
		for (Role role : roles) {
			if (role.getRoleName().equals(Constants.ROLE_STAFF))
				return true;
		}
		return false;
	}
	
	public boolean isNormalUser() {
		for (Role role : roles) {
			if (role.getRoleName().equals(Constants.ROLE_NORMAL_USER))
				return true;
		}
		return false;
	}
}
