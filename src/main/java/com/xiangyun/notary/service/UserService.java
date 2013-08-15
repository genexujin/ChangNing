package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.User;

public interface UserService {
    
    public List<User> findAll();
    
    public User save(User user);
    
    public void delete(User user);
    
    public User findByMobile(String mobile);
    
    public void refresh(User user);


}
