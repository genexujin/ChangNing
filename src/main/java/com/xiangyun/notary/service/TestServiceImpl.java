package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.xiangyun.notary.domain.Test;

@Service("jpaTestService")
public class TestServiceImpl implements TestService {
    
    private static Logger log = LoggerFactory.getLogger(TestServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;

    @Override
    public List<Test> findAll() {
        log.info("Now is in findAll()");
        List<Test> tests = em.createNamedQuery("Test.findAll", Test.class).getResultList();
        return tests;
    }

}
