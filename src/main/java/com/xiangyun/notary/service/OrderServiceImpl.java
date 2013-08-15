package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

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
        log.debug("Now is in findAll()");
        List<Order> orders = em.createNamedQuery("Order.findAll", Order.class).getResultList();
        return orders;
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<Order> findOrdersByUserId(Long userId) {
        log.debug("Now is in findOrdersByUserId()");
        TypedQuery<Order> query = em.createNamedQuery("Order.findOrdersByUserId", Order.class);
        query.setParameter("uid", userId);
        List<Order> orders = query.getResultList();
        return orders;
    }

    @Override
    public Order save(Order order) {
        if (order.getId() == null) {
            log.debug("Inserting new order...");
            em.persist(order);
            //Need to format readableId and set
            order.setReadableId(generateReadableId(order.getId()));
            em.merge(order);
        } else {
            log.debug("Updating an order...");
            em.merge(order);
        }
        
        log.debug("Order saved with id: " + order.getId());
        return order;
    }

	@Override
    public void delete(Order order) {
        Order mergedOrder = em.merge(order);
        em.remove(mergedOrder);
        log.debug("Order with id: " + order.getId() + " deleted successfully");
        
    }

    //This should not set readOnly=true, because in UploadController, the order is findById and then it will be added to some docs.
    //However, the docs is lazy loaded. So when add new docs and save the order, there will be Hibernate exception:
    //org.hibernate.LazyInitializationException : failed to lazily initialize a collection, no session or session was closed
    @Override
    @Transactional(readOnly=true)
    public Order findById(Long id) {
        List<Order> orders = em.createNamedQuery("Order.findById", Order.class).setParameter("oid", id).getResultList();
        if (orders != null && !orders.isEmpty()) {
            return orders.get(0);
        }
        return null;
    }

    private String generateReadableId(Long id) {
		return "A" + String.format("%1$08d", id);
	}

}
