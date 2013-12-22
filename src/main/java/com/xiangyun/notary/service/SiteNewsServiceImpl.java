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
import com.xiangyun.notary.domain.SiteNews;
import com.xiangyun.notary.domain.User;

@Service("jpaSiteNewsService")
@Transactional
public class SiteNewsServiceImpl extends AbstractService implements
		SiteNewsService {

	private static Logger log = LoggerFactory
			.getLogger(SiteNewsServiceImpl.class);

	@PersistenceContext
	private EntityManager em;

	@Override
	@Transactional(readOnly = true)
	public List<SiteNews> findAll() {
		log.debug("Now is in SiteNews findAll()");
		List<SiteNews> news = em.createNamedQuery("SiteNews.findAllValid",
				SiteNews.class).getResultList();
		return news;
	}

	@Override
	public SiteNews save(SiteNews news) {
		em.merge(news);
		return news;
	}

}
