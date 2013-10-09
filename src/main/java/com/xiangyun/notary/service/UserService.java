package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.User;

public interface UserService {
    
    public List<User> findAll();
    
    public User save(User user);
    
    public void delete(User user);
    
    public User findByMobile(String mobile);
    
    public void refresh(User user);	

	List<User> findUsers(String mobile, String name, int pageNum);

	Long getUserCount(String mobile, String name);

	void setUserAsNormal(String mobile);

	void setUserAsStaff(String mobile);
	
	void setUserAsAdmin(String mobile);


}
