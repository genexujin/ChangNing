package com.xiangyun.notary.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xiangyun.notary.domain.Payment;
import com.xiangyun.notary.domain.Sequence;

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
	
	@Override
	@Transactional(readOnly = true)
	public List<Payment> findPaymentByAliOrderNo(String aliTxnNo) {
		log.debug("Now is in findPaymentByAliOrderNo()");
		TypedQuery<Payment> query = em.createNamedQuery(
				"Payment.findByAliTradeNo", Payment.class);
		query.setParameter("aliTradeNo", aliTxnNo);
		List<Payment> payments = query.getResultList();
		return payments;
	}

	@Override
	public String generateRefundBatchNo() {

		String batchNo = null;

		// 构建当前日期字符串
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date now = new Date();
		String segment1 = sdf.format(now);

		// 获取当前的序列值
		TypedQuery<Sequence> query = em.createNamedQuery(
				"Sequence.findByCategoryAndSeg1", Sequence.class);
		query.setParameter("category", Sequence.REFUND_BATCHNO);
		query.setParameter("segment1", segment1);
		List<Sequence> sequences = query.getResultList();

		if (sequences.isEmpty()) {
			Sequence newSeq = new Sequence();
			newSeq.setCategory(Sequence.REFUND_BATCHNO);
			newSeq.setSegment1(segment1);
			newSeq.setSegment2(new Long(1));
			batchNo = segment1 + String.format("%1$03d", new Long(1));
			em.merge(newSeq);
		} else {
			Sequence oldSeq = sequences.get(0);
			long seq = oldSeq.getSegment2().longValue();
			seq++;
			oldSeq.setSegment2(seq);
			batchNo = segment1 + String.format("%1$03d", new Long(seq));
		}

		System.err.println("Current Batch No: " + batchNo);
		
		return batchNo;

	}

}
