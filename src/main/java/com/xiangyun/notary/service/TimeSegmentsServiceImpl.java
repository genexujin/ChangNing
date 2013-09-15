package com.xiangyun.notary.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.TimeSegment;


@Service("jpaTimeSegmentService")
@Transactional
public class TimeSegmentsServiceImpl extends AbstractService implements TimeSegmentsService {

    private static Logger log = LoggerFactory.getLogger(TimeSegmentsServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;
	
	@Override
	public TimeSegment find(int workdayId, String startTime) {
		String hql = "from TimeSegment where workdayId =:workdayId and startTime =:startTime";
		Query query = em.createQuery(hql);
		query.setParameter("workdayId", workdayId);
		query.setParameter("startTime", startTime);
		TimeSegment timeSegment = (TimeSegment) query.getSingleResult();
		return timeSegment;
	}

	@Override
	public void save(TimeSegment timeSegment) {
		if (timeSegment.getId() == null) {
            log.info("Inserting new record...");
            em.persist(timeSegment);
        } else {
            log.info("Updating new record...");
            em.merge(timeSegment);
        }
        
        log.info("Record saved with id: " + timeSegment.getId());
	}

}
