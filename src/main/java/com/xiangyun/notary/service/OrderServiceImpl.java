package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.Order;

@Service("jpaOrderService")
@Transactional
public class OrderServiceImpl implements OrderService {
    
    private static Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional(readOnly=true)
    public List<Order> findAll() {
        log.info("Now is in findAll()");
        List<Order> orders = em.createNamedQuery("Order.findAll", Order.class).getResultList();
        return orders;
    }

    @Override
    public Order save(Order order) {
        if (order.getId() == null) {
            log.info("Inserting new order...");
            em.persist(order);
        } else {
            log.info("Updating an order...");
            em.merge(order);
        }
        
        log.info("Order saved with id: " + order.getId());
        return order;
    }

    @Override
    public void delete(Order order) {
        Order mergedOrder = em.merge(order);
        em.remove(mergedOrder);
        log.info("Order with id: " + order.getId() + " deleted successfully");
        
    }

}
