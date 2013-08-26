package com.xiangyun.notary.service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.xiangyun.notary.Constants;

public abstract class AbstractService {
    
    @PersistenceContext
    private EntityManager em;
    
    protected Long getCount(String entityName) {
        return em.createQuery(getCountQueryString(entityName), Long.class).getSingleResult();
    }
    
    protected String getCountQueryString(String entityName) {
        return String.format(Constants.COUNT_QUERY_STRING, entityName, entityName);
    }

}
