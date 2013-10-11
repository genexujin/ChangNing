package com.xiangyun.notary.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.domain.Role;
import com.xiangyun.notary.domain.User;

@Service("jpaUserService")
@Transactional
public class UserServiceImpl extends AbstractService implements UserService {
    
    private static Logger log = LoggerFactory.getLogger(UserServiceImpl.class);
    
    @PersistenceContext
    private EntityManager em;

    @Override
    @Transactional(readOnly=true)
    public List<User> findAll() {
        log.info("Now is in findAll()");
        List<User> users = em.createNamedQuery("User.findAll", User.class).getResultList();
        return users;
    }

    @Override
    public User save(User user) {
        if (user.getId() == null) {
            log.info("Inserting new record...");
            em.persist(user);
        } else {
            log.info("Updating new record...");
            em.merge(user);
        }
        
        log.info("Record saved with id: " + user.getId());
        return user;
    }

    @Override
    public void delete(User user) {
        User mergedUser = em.merge(user);
        em.remove(mergedUser);
        log.info("Record with id: " + user.getId() + " deleted successfully");
        
    }

	@SuppressWarnings("unchecked")
	@Override
	public User findByMobile(String mobile) {
		
    	log.info("Now is find by the mobile number...");
    	String hql = "from User where mobile =:mobile";
    	Query query = em.createQuery(hql);
    	query.setParameter("mobile", mobile);
    	List<User> users =  query.getResultList();
    	if(users.size() == 0){
    		return null;
    	}else{
    		return users.get(0);
    	}
	}
	
	@Override
    @Transactional(readOnly=true)
    public void refresh(User user) {
        log.info("Now is in refresh()");
        em.refresh(user);
    }
	
	@Override
	@Transactional(readOnly = true)
	public List<User> findUsers(String mobile, String name,int pageNum){
		
		log.debug("Now is in findReservations(). Parameters are:");
		log.debug("    mobile: {}, name: {}",
				new Object[] { mobile, name});
		
		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<User> cq = cb.createQuery(User.class);
		Root<User> o = cq.from(User.class);
		cq.select(o);
		
		List<Predicate> criteria = new ArrayList<Predicate>();
		
		if (mobile != null){
			criteria.add(cb.like(o.get("mobile").as(String.class),"%"+ mobile +"%"));
		}
		
		if (name != null){
			criteria.add(cb.like(o.get("name").as(String.class),"%"+ name +"%"));
		}
		
		if (criteria.size() == 1) {
			cq.where(criteria.get(0));
		} else {
			cq.where(cb.and(criteria.toArray(new Predicate[0])));
		}
		
		TypedQuery<User> q = em.createQuery(cq);
		q.setFirstResult((pageNum - 1) * Constants.QUERY_PAGE_SIZE);
		q.setMaxResults(Constants.QUERY_PAGE_SIZE);	
		
		return q.getResultList();
	}
	
	@Override	
	public void setUserAsNormal(String mobile){
		setUserRole(mobile,"user");
	}
	
	@Override	
	public void setUserAsStaff(String mobile){
		setUserRole(mobile,"staff");
	}
	
	@Override	
	public void setUserAsAdmin(String mobile){
		setUserRole(mobile,"admin");
	}

	private void setUserRole(String mobile,String roleName) {
		User user = this.findByMobile(mobile);
		log.debug("role name: " + roleName);
		String hql = "from Role where roleName =:roleName";
    	Query query = em.createQuery(hql);
    	query.setParameter("roleName", roleName);
    	List<Role> roles =  query.getResultList();
    	if(roles.size() != 0){
    		log.debug("start to add role to the user!");
    		Role normalUserRole = roles.get(0);

    		for(Role r: user.getRoles()){
    			user.getRoles().remove(r);
    		}
    		user.getRoles().add(normalUserRole);
    		em.merge(user);
    	}
	}
	
	
	@Override
	@Transactional(readOnly = true)
	public Long getUserCount(String mobile, String name) {
		log.debug("Now is in getUserCount(String mobile, String name). Parameters are:");
		log.debug("mobile: {},name:{}", new Object[] {
				mobile, name});

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<User> o = cq.from(User.class);
		cq.select(cb.count(o));

		List<Predicate> criteria = new ArrayList<Predicate>();
		if (mobile != null){
			criteria.add(cb.like(o.get("mobile").as(String.class),"%"+ mobile +"%"));
		}
		
		if (name != null){
			criteria.add(cb.like(o.get("name").as(String.class),"%"+ name +"%"));
		}

		if (criteria.size() == 1) {
			cq.where(criteria.get(0));
		} else {
			cq.where(cb.and(criteria.toArray(new Predicate[0])));
		}

		TypedQuery<Long> q = em.createQuery(cq);
		

		return q.getSingleResult();
	}

}
