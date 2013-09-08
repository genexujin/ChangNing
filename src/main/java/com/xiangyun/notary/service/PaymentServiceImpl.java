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
import com.xiangyun.notary.domain.Payment;

@Service("jpaPaymentService")
@Transactional
public class PaymentServiceImpl implements PaymentService {

	private static Logger log = LoggerFactory.getLogger(OrderServiceImpl.class);
	@PersistenceContext
	private EntityManager em;

	@Override
	@Transactional(readOnly = true)
	public List<Payment> findPaymentByOrderNo(String orderTxnNo) {
		log.debug("Now is in findPaymentByOrderNo()");
		TypedQuery<Payment> query = em.createNamedQuery(
				"Payment.findByOutTradeNo", Payment.class);
		query.setParameter("outTradeNo", orderTxnNo);
		List<Payment> payments = query.getResultList();
		return payments;
	}

}
