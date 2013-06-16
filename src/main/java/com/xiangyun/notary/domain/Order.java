package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.xiangyun.notary.common.CertificatePurpose;
import com.xiangyun.notary.common.DestinationCountry;
import com.xiangyun.notary.common.OrderPaymentStatus;
import com.xiangyun.notary.common.OrderStatus;

@Entity
@Table(name = "orders")
@NamedQueries({
    @NamedQuery(name="Order.findAll", query="select o from Order o")
})
public class Order {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    
    @Column(name = "readable_id")
    private String readableId;
    
    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;

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
    
    @Column(name = "need_translation")
    private boolean needTranslation;

    @Enumerated(EnumType.STRING)
    private DestinationCountry destination;
    
    @Column(name = "visit_for_doc")
    private boolean visitForDoc;

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

    public boolean isNeedTranslation() {
        return needTranslation;
    }

    public void setNeedTranslation(boolean needTranslation) {
        this.needTranslation = needTranslation;
    }

    public DestinationCountry getDestination() {
        return destination;
    }

    public void setDestination(DestinationCountry destination) {
        this.destination = destination;
    }

    public boolean isVisitForDoc() {
        return visitForDoc;
    }

    public void setVisitForDoc(boolean visitForDoc) {
        this.visitForDoc = visitForDoc;
    }
    
}
