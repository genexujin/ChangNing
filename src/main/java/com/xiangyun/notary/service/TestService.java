package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Test;

public interface TestService {
    
    public List<Test> findAll();
    
    public Test save(Test test);
    
    public void delete(Test test);

}
