package com.xiangyun.notary.domain;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "time_segments")
public class TimeSegment implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
    private Long id;
	
	@Column(name = "start_time")
	private String startTime;
	
	private int duration;
	
	@ManyToOne
	@JoinColumn(name = "workday_id")
	private Workday workDay;
	
	@Column(name = "resv_count")
	private int resvCount;

	public int getResvCount() {
		return resvCount;
	}

	public void setResvCount(int resvCount) {
		this.resvCount = resvCount;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public Workday getWorkDay() {
		return workDay;
	}

	public void setWorkDay(Workday workDay) {
		this.workDay = workDay;
	}

}
