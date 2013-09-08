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
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.Gender;
import com.xiangyun.notary.common.Language;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;

@Entity
@Table(name = "orders")
@NamedQueries({
    @NamedQuery(name="Order.findAll", query="select o from Order o"),
    @NamedQuery(name="Order.findById", query="select o from Order o where o.id = :oid"),
    @NamedQuery(name="Order.findOrdersByUserId", query="select o from Order o where o.user.id = :uid"),
    @NamedQuery(name="Order.getCountByUserId", query="select count(o) from Order o where o.user.id = :uid"),
    @NamedQuery(name="Order.getCount", query="select count(o) from Order o")
})
public class Order implements Serializable {
    private static final long serialVersionUID = 1L;
    
      
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Column(name = "readable_id", insertable=false)
    private String readableId;
    
    @Column(name = "backend_notary_id", insertable=false)
    private String backendNotaryId;
    
    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "order")
    private Set<Form> forms = new HashSet<Form>();
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "order", fetch = FetchType.EAGER)
    private Set<DocItem> docs = new HashSet<DocItem>();
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "order")
    private Set<Payment> payments = new HashSet<Payment>();

    @Column(name = "order_date")
    private Date orderDate;
    
    @Column(name = "payment_total")
    private double paymentTotal;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_status")
    private OrderPaymentStatus paymentStatus;
    
    @Column(name = "payment_paid")
    private double paymentPaid;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "order_status")
    private OrderStatus orderStatus;
    
    @Column(name = "cert_purpose")
    @Enumerated(EnumType.STRING)
    private CertificatePurpose certificatePurpose;
    
    @Column(name = "cert_copy_count")
    private int certificateCopyCount;
    
    @Column(name = "trans_lang")
    @Enumerated(EnumType.STRING)
    private Language translationLanguage;
    
	@Column(name = "need_verify")
    private boolean needVerify;

    @Enumerated(EnumType.STRING)
    private DestinationCountry destination;
    
    @Column(name = "send_doc")
    private boolean sendDoc;
    
    @Column(name = "send_address")
    private String sendAddress;

    @Column(name = "send_date")
    private Date sendDate;
    
    @Column(name = "requestor_name")
    private String requestorName;
    
    @Column(name = "requestor_name_pinyin")
    private String requestorNamePinyin;

	@Column(name = "requestor_gender")
    @Enumerated(EnumType.STRING)
    private Gender requestorGender;
    
    @Column(name = "requestor_mobile")
    private String requestorMobile;
    
    @Column(name = "reqeustor_email")
    private String requestorEmail;
    
    @Column(name = "requestor_address")
    private String requestorAddress;
    
    @Column(name = "requestor_birth_date")
    private Date requestorBirthDate;
    
    @Column(name = "upload_note")
    private String uploadNote;
    
    @Column(name = "cancel_note")
    private String cancelNote;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getReadableId() {
        return readableId;
    }

    public void setReadableId(String readableId) {
        this.readableId = readableId;
    }

    public String getBackendNotaryId() {
        return backendNotaryId;
    }

    public void setBackendNotaryId(String backendNotaryId) {
        this.backendNotaryId = backendNotaryId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getPaymentTotal() {
        return paymentTotal;
    }

    public void setPaymentTotal(double paymentTotal) {
        this.paymentTotal = paymentTotal;
    }

    public OrderPaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(OrderPaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public double getPaymentPaid() {
        return paymentPaid;
    }

    public void setPaymentPaid(double paymentPaid) {
        this.paymentPaid = paymentPaid;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public CertificatePurpose getCertificatePurpose() {
        return certificatePurpose;
    }

    public void setCertificatePurpose(CertificatePurpose certificatePurpose) {
        this.certificatePurpose = certificatePurpose;
    }

    public int getCertificateCopyCount() {
        return certificateCopyCount;
    }

    public void setCertificateCopyCount(int certificateCopyCount) {
        this.certificateCopyCount = certificateCopyCount;
    }

    public Language getTranslationLanguage() {
		return translationLanguage;
	}

	public void setTranslationLanguage(Language translationLanguage) {
		this.translationLanguage = translationLanguage;
	}

	public boolean isNeedVerify() {
		return needVerify;
	}

	public void setNeedVerify(boolean needVerify) {
		this.needVerify = needVerify;
	}

    public DestinationCountry getDestination() {
        return destination;
    }

    public void setDestination(DestinationCountry destination) {
        this.destination = destination;
    }

    public boolean isSendDoc() {
        return sendDoc;
    }

    public void setSendDoc(boolean sendDoc) {
        this.sendDoc = sendDoc;
    }
    
    public String getSendAddress() {
        return sendAddress;
    }

    public void setSendAddress(String sendAddress) {
        this.sendAddress = sendAddress;
    }

    public Date getSendDate() {
        return sendDate;
    }

    public void setSendDate(Date sendDate) {
        this.sendDate = sendDate;
    }

    public Set<Form> getForms() {
        return forms;
    }

    public void setForms(Set<Form> forms) {
        this.forms = forms;
    }
    
    public void addForm(Form form) {
        form.setOrder(this);
        forms.add(form);
    }
    
    public void addPayment(Payment payment) {
        payment.setOrder(this);
        payments.add(payment);
    }
    
    public Set<DocItem> getDocs() {
        return docs;
    }

    public Set<Payment> getPayments() {
		return payments;
	}

	public void setPayments(Set<Payment> payments) {
		this.payments = payments;
	}

	public void setDocs(Set<DocItem> docs) {
        this.docs = docs;
    }
    
    public void addDoc(DocItem doc) {
        doc.setOrder(this);
        docs.add(doc);
    }
    
    public String getRequestorName() {
		return requestorName;
	}

	public void setRequestorName(String requestorName) {
		this.requestorName = requestorName;
	}

	public String getRequestorNamePinyin() {
        return requestorNamePinyin;
    }

    public void setRequestorNamePinyin(String requestorNamePinyin) {
        this.requestorNamePinyin = requestorNamePinyin;
    }

    public Date getRequestorBirthDate() {
        return requestorBirthDate;
    }

    public void setRequestorBirthDate(Date requestorBirthDate) {
        this.requestorBirthDate = requestorBirthDate;
    }

    public Gender getRequestorGender() {
		return requestorGender;
	}

	public void setRequestorGender(Gender requestorGender) {
		this.requestorGender = requestorGender;
	}

	public String getRequestorMobile() {
		return requestorMobile;
	}

	public void setRequestorMobile(String requestorMobile) {
		this.requestorMobile = requestorMobile;
	}

	public String getRequestorEmail() {
		return requestorEmail;
	}

	public void setRequestorEmail(String requestorEmail) {
		this.requestorEmail = requestorEmail;
	}

	public String getRequestorAddress() {
		return requestorAddress;
	}

	public void setRequestorAddress(String requestorAddress) {
		this.requestorAddress = requestorAddress;
	}
	
	public String getUploadNote() {
		return uploadNote;
	}

	public void setUploadNote(String uploadNote) {
		this.uploadNote = uploadNote;
	}

	public String getCancelNote() {
        return cancelNote;
    }

    public void setCancelNote(String cancelNote) {
        this.cancelNote = cancelNote;
    }

    public double calculateTotalFee() {
	    double result = 0.0;
	    for (Form form : forms) {
	        result += form.calculateFormFee();
	    }
	    if (sendDoc) {
	        result += Constants.SEND_DOC_FEE;
	    }
	    paymentTotal = result;
	    return result;
	}

	public Set<DocItem> getAllInOneDocs() {
	    Set<DocItem> allInOneDocs = new HashSet<DocItem>();
	    
	    for (DocItem doc : docs) {
	        if (doc.getDocKey() == null) 
	            allInOneDocs.add(doc);
	    }
	    
	    return allInOneDocs;
	}
	
	public Set<DocItem> getAloneDocs() {
	    Set<DocItem> aloneDocs = new HashSet<DocItem>();
	    
	    for (DocItem doc : docs) {
	        if (doc.getDocKey() != null) 
	            aloneDocs.add(doc);
	    }
	    
	    return aloneDocs;
	}
	
	// 根据选择的办证事项，拼出付款抬头
	public String getPaymentTitle(){
		
		StringBuffer result = new StringBuffer("公证费：");
		
		for (Form form: forms){
			result.append(form.getFormName());
			result.append(";");
		}
	
		return result.toString();
	}
}
