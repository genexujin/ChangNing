package com.xiangyun.notary.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.Reservation;

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

}
