package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Payment;



public interface PaymentService {

	 List<Payment> findPaymentByOrderNo(String orderTxnNo);
	 String generateRefundBatchNo();
	List<Payment> findPaymentByAliOrderNo(String aliTxnNo);
}
