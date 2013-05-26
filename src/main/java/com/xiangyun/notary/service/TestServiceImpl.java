package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.Test;

@Service("jpaTestService")
@Transactional
public class TestServiceImpl implements TestService {
    
    private static Logger log = LoggerFactory.getLogger(TestServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional(readOnly=true)
    public List<Test> findAll() {
        log.info("Now is in findAll()");
        List<Test> tests = em.createNamedQuery("Test.findAll", Test.class).getResultList();
        return tests;
    }

    @Override
    public Test save(Test test) {
        if (test.getId() == null) {
            log.info("Inserting new record...");
            em.persist(test);
        } else {
            log.info("Updating new record...");
            em.merge(test);
        }
        
        log.info("Record saved with id: " + test.getId());
        return test;
    }

    @Override
    public void delete(Test test) {
        Test mergedTest = em.merge(test);
        em.remove(mergedTest);
        log.info("Record with id: " + test.getId() + " deleted successfully");
        
    }

}
