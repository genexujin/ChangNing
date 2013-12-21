package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.SiteNews;

public interface SiteNewsService {
	
    List<SiteNews> findAll();       

    SiteNews save(SiteNews news);
    
    
}
