package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
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

import com.xiangyun.notary.common.OrderPaymentStatus;

@Entity
@Table(name = "payment")
@NamedQueries({
		@NamedQuery(name = "Payment.findAll", query = "select o from Payment o"),
		@NamedQuery(name = "Payment.findByOutTradeNo", query = "select o from Payment o where o.orderTxnNo = :outTradeNo") ,
		@NamedQuery(name = "Payment.findByAliTradeNo", query = "select o from Payment o where o.alipayTxnNo = :aliTradeNo")})
public class Payment implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;

	@ManyToOne
	@JoinColumn(name = "order_id")
	private Order order;

	@Column(name = "payment_date")
	private Date paymentDate;

	@Column(name = "payment_total")
	private double paymentTotal;

	@Column(name = "refund_date")
	private Date refundDate;

	@Column(name = "refund_total")
	private double refundTotal;

	@Column(name = "status")
	@Enumerated(EnumType.STRING)
	private OrderPaymentStatus status;

	@Column(name = "title")
	private String title;

	@Column(name = "refund_reason")
	private String refundReason;

	@Column(name = "order_txn_no")
	private String orderTxnNo;

	@Column(name = "alipay_txn_no")
	private String alipayTxnNo;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public double getPaymentTotal() {
		return paymentTotal;
	}

	public void setPaymentTotal(double paymentTotal) {
		this.paymentTotal = paymentTotal;
	}

	public Date getRefundDate() {
		return refundDate;
	}

	public void setRefundDate(Date refundDate) {
		this.refundDate = refundDate;
	}

	public double getRefundTotal() {
		return refundTotal;
	}

	public void setRefundTotal(double refundTotal) {
		this.refundTotal = refundTotal;
	}

	public OrderPaymentStatus getStatus() {
		return status;
	}

	public void setStatus(OrderPaymentStatus status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getOrderTxnNo() {
		return orderTxnNo;
	}

	public void setOrderTxnNo(String orderTxnNo) {
		this.orderTxnNo = orderTxnNo;
	}

	public String getAlipayTxnNo() {
		return alipayTxnNo;
	}

	public void setAlipayTxnNo(String alipayTxnNo) {
		this.alipayTxnNo = alipayTxnNo;
	}

}
