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
@Table(name = "sequence")
@NamedQueries({
		@NamedQuery(name = "Sequence.findAll", query = "select o from Sequence o"),
		@NamedQuery(name = "Sequence.findByCategoryAndSeg1", query = "select o from Sequence o where o.category = :category and o.segment1=:segment1") })
public class Sequence  implements Serializable {

	private static final long serialVersionUID = 1L;
	public static final String REFUND_BATCHNO = "REFUND_BATCHNO";
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;
	
	@Column(name = "category")
	private String category;
	
	@Column(name = "segment1")
	private String segment1;
	
	@Column(name = "segment2")
	private Long segment2;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSegment1() {
		return segment1;
	}

	public void setSegment1(String segment1) {
		this.segment1 = segment1;
	}

	public Long getSegment2() {
		return segment2;
	}

	public void setSegment2(Long segment2) {
		this.segment2 = segment2;
	}
	
	

}
