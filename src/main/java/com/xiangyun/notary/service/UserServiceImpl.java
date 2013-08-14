package com.xiangyun.notary.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.User;

@Service("jpaUserService")
@Transactional
public class UserServiceImpl implements UserService {
    
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

	@Override
	public User findByMobile(String mobile) {
		
    	log.info("Now is find by the mobile number...");
    	String hql = "from User where mobile = " + mobile;
    	List<User> users =  em.createQuery(hql).getResultList();
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

}
