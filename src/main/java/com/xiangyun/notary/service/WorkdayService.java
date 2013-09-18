package com.xiangyun.notary.service;

import java.util.Date;
import java.util.List;

import com.xiangyun.notary.domain.Workday;

public interface WorkdayService {
	 public List<Workday> findAll();
	    
	    public Workday save(Workday workday);
	    
	    public Workday saveByDate(Workday workday);
	    
	    public void delete(Workday workday);
	    
	    public Workday findByDate(Date date);
	    
	    public List<Workday> findByYear(int year,int month,int pageNO);

	    public List<Workday> findYear(int year);

		List<Workday> retrieveDayList();

		Workday findByDay(int year, int month, int day);
}
