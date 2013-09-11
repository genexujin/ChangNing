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
import javax.persistence.Table;

import com.xiangyun.notary.common.ReservationStatus;

@Entity
@Table(name = "reservations")
public class Reservation implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;

	@Column(name = "readable_id", insertable = false)
	private String readableId;

	@Column(name = "requestor_name")
	private String requestorName;

	@Column(name = "requestor_mobile")
	private String requestorMobile;

	@Column(name = "reserve_key")
	private String reservationKey;

	@Column(name = "reserve_date")
	private Date reservationDate;

	@Column(name = "reserve_time_segment")
	private String reservationTimeSegment;

	@Enumerated(EnumType.STRING)
	@Column(name = "reserve_status")
	private ReservationStatus reservationStatus;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRequestorName() {
		return requestorName;
	}

	public void setRequestorName(String requestorName) {
		this.requestorName = requestorName;
	}

	public String getRequestorMobile() {
		return requestorMobile;
	}

	public void setRequestorMobile(String requestorMobile) {
		this.requestorMobile = requestorMobile;
	}

	public String getReservationKey() {
		return reservationKey;
	}

	public void setReservationKey(String reservationKey) {
		this.reservationKey = reservationKey;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getReservationDate() {
		return reservationDate;
	}

	public void setReservationDate(Date reservationDate) {
		this.reservationDate = reservationDate;
	}

	public String getReservationTimeSegment() {
		return reservationTimeSegment;
	}

	public void setReservationTimeSegment(String reservationTimeSegment) {
		this.reservationTimeSegment = reservationTimeSegment;
	}

	public String getReadableId() {
		return readableId;
	}

	public void setReadableId(String readableId) {
		this.readableId = readableId;
	}

	public ReservationStatus getReservationStatus() {
		return reservationStatus;
	}

	public void setReservationStatus(ReservationStatus reservationStatus) {
		this.reservationStatus = reservationStatus;
	}

}
