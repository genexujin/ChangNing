package com.xiangyun.notary.util;

import java.util.Calendar;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.xiangyun.notary.common.WorkdayType;
import com.xiangyun.notary.domain.Workday;

public class WorkdayPopulator {
	
	public static void main(String[] args) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("cn");
        EntityManager em = emf.createEntityManager();
        
        try {
        	em.getTransaction().begin();
        	
        	Calendar date = Calendar.getInstance();
        	//Create workday for a year
        	for (int i = 0; i < 365; i++) {
        		Workday day = new Workday();
            	day.setDate(date.getTime());
            	day.setYear(date.get(Calendar.YEAR));
            	day.setMonth(date.get(Calendar.MONTH) + 1);
            	day.setDay(date.get(Calendar.DAY_OF_MONTH));
            	
            	
        		if ( date.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY 
        			&& date.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
        			
                	day.setType(WorkdayType.WORKDAY);                	
        		} else {
        			day.setType(WorkdayType.NON_WORKDAY);
        		}
        		
        		em.persist(day);
        		date.add(Calendar.DATE, 1);
        	}
        	
        	em.getTransaction().commit();
        	
        } catch (Exception e) {
        	em.getTransaction().rollback();
        	e.printStackTrace();
        } finally {
        	emf.close();
        }
	}

}
