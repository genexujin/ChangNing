package com.xiangyun.notary.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.ParameterExpression;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Interaction;
import com.xiangyun.notary.domain.Order;
import com.xiangyun.notary.domain.Payment;
import com.xiangyun.notary.domain.User;

@Service("jpaOrderService")
@Transactional
public class OrderServiceImpl extends AbstractService implements OrderService {
    
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
    @Transactional(readOnly=true)
    public List<Order> findOrdersByPage(int pageNum) {
        log.debug("Now is in findOrdersByPage()");
        TypedQuery<Order> query = em.createNamedQuery("Order.findAll", Order.class);
        query.setFirstResult((pageNum - 1) * Constants.QUERY_PAGE_SIZE);
        query.setMaxResults(Constants.QUERY_PAGE_SIZE);
        List<Order> orders = query.getResultList();
        return orders;
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<Order> findOrdersByUserIdAndPage(Long userId, int pageNum) {
        log.debug("Now is in findOrdersByUserIdAndPage()");
        TypedQuery<Order> query = em.createNamedQuery("Order.findOrdersByUserId", Order.class);
        query.setParameter("uid", userId);
        query.setFirstResult((pageNum - 1) * Constants.QUERY_PAGE_SIZE);
        query.setMaxResults(Constants.QUERY_PAGE_SIZE);
        List<Order> orders = query.getResultList();
        return orders;
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<Order> findOrders(String readableId, OrderStatus status, Long userId, int pageNum) {
    	log.debug("Now is in findOrders(). Parameters are:");
    	log.debug("    readableId: {}, status: {}, userId: {}, pageNum: {}", new Object[] {readableId, status, userId, pageNum});
    	
    	CriteriaBuilder cb = em.getCriteriaBuilder();
    	CriteriaQuery<Order> cq = cb.createQuery(Order.class);
    	Root<Order> o = cq.from(Order.class);
    	cq.select(o);
    	
    	List<Predicate> criteria = new ArrayList<Predicate>();
    	if (readableId != null) {
    		ParameterExpression<String> p = cb.parameter(String.class, "rId");
    		criteria.add(cb.equal(o.get("readableId"), p));
    	}
    	
    	if (status != null && status != OrderStatus.NULL) {
    		ParameterExpression<OrderStatus> p = cb.parameter(OrderStatus.class, "status");
    		criteria.add(cb.equal(o.get("orderStatus"), p));
    	}
    	
    	if (userId != null) {
    		Join<Order, User> u = o.join("user", JoinType.INNER);
    		ParameterExpression<Long> p = cb.parameter(Long.class, "uId");
    		criteria.add(cb.equal(u.get("id"), p));
    	}
    	
		if (criteria.size() == 1) {
			cq.where(criteria.get(0));
		} else {
			cq.where(cb.and(criteria.toArray(new Predicate[0])));
		}
		
		TypedQuery<Order> q = em.createQuery(cq);
		if (readableId != null) q.setParameter("rId", readableId);
		if (status != null && status != OrderStatus.NULL) q.setParameter("status", status);
		if (userId != null) q.setParameter("uId", userId);
		
		q.setFirstResult((pageNum - 1) * Constants.QUERY_PAGE_SIZE);
        q.setMaxResults(Constants.QUERY_PAGE_SIZE);
        
    	return q.getResultList();
    }
    
    @Override
    @Transactional(readOnly=true)
    public Order findOrderById(Long orderId, Long userId) {
        
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Order> cq = cb.createQuery(Order.class);
        Root<Order> o = cq.from(Order.class);
        cq.select(o);
        
        Predicate oP = cb.equal(o.get("id"), orderId);        
        if (userId != null) {
            Predicate uP = cb.equal(o.get("user").get("id"), userId);
            cq.where(cb.and(oP, uP));
        } else 
            cq.where(oP);
        
        TypedQuery<Order> q = em.createQuery(cq);
        List<Order> result = q.getResultList();
        return (result == null || result.size() == 0) ? null : result.get(0);
       
    }
    
    @Override
    @Transactional(readOnly=true)
    public Long getOrderCount() {
    	TypedQuery<Long> query = em.createNamedQuery("Order.getCount", Long.class);
    	return query.getSingleResult();
    }
    
    @Override
    @Transactional(readOnly=true)
    public Long getOrderCount(String readableId, String requestorName, Date startDate, Date endDate, OrderStatus status, Long userId) {
        log.debug("Now is in getOrderCount(readableId, requestorName, startDate, endDate, status, userId). Parameters are:");
        log.debug("    readableId: {}, requestorName: {}, startDate: {}, endDate: {}, status: {}, userId: {}", new Object[] {readableId, status, userId});
        
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
        Root<Order> o = cq.from(Order.class);
        cq.select(cb.count(o));
        
        List<Predicate> criteria = new ArrayList<Predicate>();
        if (readableId != null) {
            ParameterExpression<String> p = cb.parameter(String.class, "rId");
//            criteria.add(cb.like(o.get("readableId"), p));
        }
        
        if (status != null && status != OrderStatus.NULL) {
            ParameterExpression<OrderStatus> p = cb.parameter(OrderStatus.class, "status");
            criteria.add(cb.equal(o.get("orderStatus"), p));
        }
        
        if (userId != null) {
            ParameterExpression<Long> p = cb.parameter(Long.class, "uId");
            criteria.add(cb.equal(o.get("user").get("id"), p));
        }
        
        if (criteria.size() == 1) {
            cq.where(criteria.get(0));
        } else {
            cq.where(cb.and(criteria.toArray(new Predicate[0])));
        }
        
        TypedQuery<Long> q = em.createQuery(cq);
        if (readableId != null) q.setParameter("rId", readableId);
        if (status != null && status != OrderStatus.NULL) q.setParameter("status", status);
        if (userId != null) q.setParameter("uId", userId);
        
        return q.getSingleResult();
    }
    
    @Override
    @Transactional(readOnly=true)
    public Long getOrderCountByUserId(Long userId) {
        TypedQuery<Long> query = em.createNamedQuery("Order.getCountByUserId", Long.class);
        return query.setParameter("uid", userId).getSingleResult();
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<Interaction> findIncompletedInteractionsForOrder(Long orderId, Long userId) {
        TypedQuery<Interaction> query = em.createNamedQuery("Interaction.findByOrderId", Interaction.class);
        query.setParameter("oid", orderId);
        query.setParameter("uid", userId);
        return query.getResultList();
    }
    
    @Override
    @Transactional(readOnly=true)
    public Payment findPaymentByOrderIdAndPaymentId(Long orderId, Long userId, Long paymentId) {
        TypedQuery<Payment> query = em.createNamedQuery("Payment.findByOrderIdAndPaymentId", Payment.class);
        query.setParameter("oid", orderId);
        query.setParameter("uid", userId);
        query.setParameter("pid", paymentId);
        
        List<Payment> result = query.getResultList();
        return (result == null || result.size() == 0) ? null : result.get(0);
    }
    
    @Override
    @Transactional(readOnly=true)
    public List<Payment> findPaymentsByOrderIdAndPaymentIds(Long orderId, List<Long> paymentIds) {
        TypedQuery<Payment> query = em.createNamedQuery("Payment.findPaymentsByOrderIdAndPaymentIds", Payment.class);
        query.setParameter("oid", orderId);
        query.setParameter("pids", paymentIds);
        
        return query.getResultList();
    }

    @Override
    public Order save(Order order) {
        if (order.getId() == null) {
            log.debug("Inserting new order...");
            em.persist(order);
            //Need to format readableId and set
            order.setReadableId(generateReadableId(order.getId(), "DA"));
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

    @Override
    @Transactional(readOnly=true)
    public Order findById(Long id) {
        List<Order> orders = em.createNamedQuery("Order.findById", Order.class).setParameter("oid", id).getResultList();
        if (orders != null && !orders.isEmpty()) {
            return orders.get(0);
        }
        return null;
    }
    
    @Override
    public Payment save(Payment payment) {
        if (payment.getId() == null) {
            log.debug("Inserting new payment...");
            em.persist(payment);
        } else {
            log.debug("Updating an payment...");
            em.merge(payment);
        }
        
        log.debug("Payment saved with id: " + payment.getId());
        return payment;
    }

}
