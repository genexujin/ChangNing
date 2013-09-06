package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.Workday;

@Service("jpaReserveService")
@Transactional
public class ReservationServiceImpl extends AbstractService implements ReservationService {
    
    private static Logger log = LoggerFactory.getLogger(ReservationServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;
    
    @Override
    public Reservation save(Reservation resv) {
        if (resv.getId() == null) {
            log.debug("Inserting new reservation...");
            em.persist(resv);
            //Need to format readableId and set
            resv.setReadableId(generateReadableId(resv.getId(), "Y"));
            em.merge(resv);
        } else {
            log.debug("Updating an reservation...");
            em.merge(resv);
        }
        
        log.debug("Reservation saved with id: " + resv.getId());
        return resv;
    }

    @Override
    public void delete(Reservation resv) {
        Reservation mergedReservation = em.merge(resv);
        em.remove(mergedReservation);
        log.debug("Reservation with id: " + resv.getId() + " deleted successfully");
        
    }

	@Override
	public Reservation findByReadableId(String readableId) {
		String hql = "from Reservation where readableId =:readableId";
		Query query = em.createQuery(hql);
		query.setParameter("readableId", readableId);
		Reservation reservation = (Reservation) query.getSingleResult();
		return reservation;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Reservation> findByRIdOrRStatus(String readableId,
			ReservationStatus reservationStatus,int pageNO) {
		String hql;
		Query query;
		if(readableId.trim()!=""){
			hql="from Reservation where readableId =:readableId ";
			query= em.createQuery(hql);
			query.setParameter("readableId", readableId);
			
		}else if(reservationStatus!=null){
			hql="from Reservation where reservationStatus =:reservationStatus order by readableId desc";
			query= em.createQuery(hql);
			query.setParameter("reservationStatus", reservationStatus);
		}else{
			hql="from Reservation order by readableId desc";
			query= em.createQuery(hql);
			
		}
		query.setFirstResult((pageNO-1)*5);
		query.setMaxResults(5);
		List<Reservation> reservations = query.getResultList();
		
		return reservations;
	}

}
