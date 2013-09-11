package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.xiangyun.notary.common.WorkdayType;

@Entity
@Table(name = "workdays")
public class Workday implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
	
    private Date date;
    
    private int year;
    
    private int month;
    
    private int day;
    
    @OneToMany(cascade = { CascadeType.REFRESH, CascadeType.PERSIST, CascadeType.MERGE }, mappedBy = "workDay")
    private Set<TimeSegment> timeSegments = new HashSet<TimeSegment>();
    
    @Enumerated(EnumType.STRING)
    private WorkdayType type;
    
    private String description;
    private String batch;

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public WorkdayType getType() {
		return type;
	}

	public void setType(WorkdayType type) {
		this.type = type;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<TimeSegment> getTimeSegments() {
		return timeSegments;
	}

	public void setTimeSegments(Set<TimeSegment> timeSegments) {
		this.timeSegments = timeSegments;
	}
	
	

}
