package com.xiangyun.notary.service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.Workday;

@Service("jpaWorkdayService")
@Transactional
public class WorkdayServiceImpl extends AbstractService implements WorkdayService {

	private static Logger log = LoggerFactory.getLogger(WorkdayServiceImpl.class);
	
	 @PersistenceContext
	    private EntityManager em;

	 @Override
	    @Transactional(readOnly=true)
	    public List<Workday> findAll() {
	        log.info("Now is in findAll()");
	        List<Workday> workdays = em.createNamedQuery("Workday.findAll", Workday.class).getResultList();
	        return workdays;
	    }

	    @Override
	    public Workday save(Workday workday) {
	        if (workday.getId() == null) {
	            log.debug("Inserting new record...");
	            em.persist(workday);
	        } else {
	            log.debug("Updating new record...");
	            em.merge(workday);
	        }
	        
	        log.debug("Record saved with id: " + workday.getId());
	        return workday;
	    }
	    
	    

	    @Override
	    public void delete(Workday workday) {
	        Workday mergedWorkday = em.merge(workday);
	        em.remove(mergedWorkday);
	        log.info("Record with id: " + workday.getId() + " deleted successfully");
	        
	    }
	    
		@SuppressWarnings("unchecked")
		@Override
		public Workday findByDate(Date date) {
			
	    	log.info("Now is find by the date...");
	    	String hql = "from Workday where date = :date";
	    	Query query = em.createQuery(hql);
	    	query.setParameter("date", date);
	    	List<Workday> workdays =  query.getResultList();
	    	if(workdays.size() == 0){
	    		return null;
	    	}else{
	    		return workdays.get(0);
	    	}
		}
		
		@SuppressWarnings("unchecked")
		@Override
		public Workday findByDay(int year,int month,int day) {
			
	    	log.info("Now is find by the day...");
	    	log.debug("year: " + year + " month: " + month + " day: " + day);
	    	String hql = "from Workday where year = :year and month=:month and day =:day";
	    	Query query = em.createQuery(hql);
	    	query.setParameter("year", year);
	    	query.setParameter("month", month);
	    	query.setParameter("day", day);
	    	List<Workday> workdays =  query.getResultList();
	    	if(workdays.size() == 0){
	    		return null;
	    	}else{
	    		return workdays.get(0);
	    	}
		}

		@SuppressWarnings("unchecked")
		@Override
		public List<Workday> findByYear(int year,int month,int pageNO) {
			String hql = "from Workday where year = :year and month = :month";
			Query query = em.createQuery(hql);
			query.setParameter("year", year);
			query.setParameter("month", month);
			query.setFirstResult((pageNO-1)*15);
			query.setMaxResults(15);
			List<Workday> workdays = query.getResultList();
			return workdays;
		}

		@Override
		public Workday saveByDate(Workday workday) {
			if(findByDate(workday.getDate())==null){
				em.persist(workday);
			}else{
				em.merge(workday);
			}
			return null;
		}
		@SuppressWarnings("unchecked")
		@Override
		public List<Workday> retrieveDayList() {		
			
	    	log.info("Now is retrieveDayList...");
	    	String hql = "from Workday where date > :date and date <:endDate";
	    	Date now =  new Date();
	    	//7天之内的日期
	    	Calendar endDate = Calendar.getInstance();
	    	endDate.setTime(now);
	    	endDate.add(Calendar.DAY_OF_MONTH, 7);	    	
	    
	    	
	    	Query query = em.createQuery(hql);
	    	query.setParameter("date",now);
	    	query.setParameter("endDate",endDate.getTime());
	    	List<Workday> workdays =  query.getResultList();
	    	return workdays;	    	
	    
		}
		

		@SuppressWarnings("unchecked")
		@Override
		public List<Workday> findYear(int year) {
			List<Workday> workdays=null;
			String hql="from Workday w  where w.year=?1";
			Query query=em.createQuery(hql);
			query.setParameter(1, year);
			workdays=query.getResultList();
			return workdays;
		}
		
}
