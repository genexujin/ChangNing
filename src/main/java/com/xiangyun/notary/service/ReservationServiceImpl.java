package com.xiangyun.notary.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
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
import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.domain.ReservSlot;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.User;

@Service("jpaReserveService")
@Transactional
public class ReservationServiceImpl extends AbstractService implements
		ReservationService {

	private static Logger log = LoggerFactory
			.getLogger(ReservationServiceImpl.class);

	@PersistenceContext
	private EntityManager em;

	@Override
	public Reservation save(Reservation resv) {
		if (resv.getId() == null) {
			log.debug("Inserting new reservation...");
			em.persist(resv);
			// Need to format readableId and set
			resv.setReadableId(generateReadableId(resv.getId(), "Y"));
			em.merge(resv);
		} else {
			log.debug("Updating an reservation...");
			em.merge(resv);
		}

		log.debug("Reservation saved with id: " + resv.getId());
		return resv;
	}

	@Override
	public void delete(Reservation resv) {
		Reservation mergedReservation = em.merge(resv);
		em.remove(mergedReservation);
		log.debug("Reservation with id: " + resv.getId()
				+ " deleted successfully");

	}

	@Override
	public Reservation findByReadableId(String readableId) {
		String hql = "from Reservation where readableId =:readableId";
		Query query = em.createQuery(hql);
		query.setParameter("readableId", readableId);
		Reservation reservation = (Reservation) query.getSingleResult();
		return reservation;
	}

	/**
	 * 一天只能成功预约一次，一周只能成功预约三次
	 * 
	 * @param readableId
	 * @return
	 */
	@Override
	public boolean checkCompliance(User user) {
		boolean result = true;

		String hql = "from Reservation where user =:user and reservationStatus=:status and  date_format(creationDate, '%Y%m%d') = date_format(current_date(),'%Y%m%d')";
		Query query = em.createQuery(hql);
		query.setParameter("user", user);
		query.setParameter("status", ReservationStatus.SUBMITTED);
		List reservation = query.getResultList();
		log.debug("reservation made on today: " + reservation.size());
		if (reservation != null && reservation.size() > 0)
			result = false;

		Calendar now = Calendar.getInstance();
		now.setTime(new Date());
		log.debug("today is : " + now.getTime());

		Calendar aWeekAgo = Calendar.getInstance();
		aWeekAgo.setTime(new Date());
		aWeekAgo.add(Calendar.DAY_OF_YEAR, -7);
		log.debug("a week ago is: " + aWeekAgo.getTime());

		hql = "from Reservation where user =:user and creationDate <=:today and creationDate>=:aWeekAgo";
		query = em.createQuery(hql);
		query.setParameter("user", user);
		query.setParameter("today", now.getTime());
		query.setParameter("aWeekAgo", aWeekAgo.getTime());
		reservation = query.getResultList();
		log.debug("reservation made within a week: " + reservation.size());
		if (reservation != null && reservation.size() >= 3)
			result = false;

		return result;
	}

	@Override
	@Transactional(readOnly = true)
	public List<Reservation> findReservations(String readableId,
			String requestorName, Date startDate, Date endDate,
			ReservationStatus status, Long userId, int pageNum) {
		log.debug("Now is in findReservations(). Parameters are:");
		log.debug("    readableId: {}, status: {}, userId: {}, pageNum: {}",
				new Object[] { readableId, requestorName, status, userId,
						pageNum });

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Reservation> cq = cb.createQuery(Reservation.class);
		Root<Reservation> o = cq.from(Reservation.class);
		cq.select(o);

		List<Predicate> criteria = new ArrayList<Predicate>();
		if (readableId != null) {
			// ParameterExpression<String> p = cb.parameter(String.class,
			// "readable_id");
			// criteria.add(cb.equal(o.get("readableId"), p));
			criteria.add(cb.like(o.get("readableId").as(String.class), "%"
					+ readableId + "%"));
		}

		if (requestorName != null) {
			// ParameterExpression<String> p =
			// cb.parameter(String.class,"requestor_name");
			criteria.add(cb.like(o.get("requestorName").as(String.class), "%"
					+ requestorName + "%"));
		}

		if (null != startDate) {
			// ParameterExpression<Date> p =
			// cb.parameter(Date.class,"reserve_date");
			criteria.add(cb.greaterThanOrEqualTo(
					o.get("reservationDate").as(Date.class), startDate));
		}

		if (null != endDate) {
			// ParameterExpression<Date> p =
			// cb.parameter(Date.class,"reserve_date");
			criteria.add(cb.lessThanOrEqualTo(
					o.get("reservationDate").as(Date.class), endDate));
		}

		if (status != null) {
			ParameterExpression<ReservationStatus> p = cb.parameter(
					ReservationStatus.class, "status");
			criteria.add(cb.equal(o.get("reservationStatus"), p));
		}

		if (userId != null) {
			Join<Reservation, User> u = o.join("user", JoinType.INNER);
			ParameterExpression<Long> p = cb.parameter(Long.class, "uId");
			criteria.add(cb.equal(u.get("id"), p));
		}

		if (criteria.size() == 1) {
			cq.where(criteria.get(0));
		} else {
			cq.where(cb.and(criteria.toArray(new Predicate[0])));
		}

		cq.orderBy(cb.desc(o.get("id")));

		TypedQuery<Reservation> q = em.createQuery(cq);
		// if (readableId != null)
		// q.setParameter("readable_id", readableId);
		// if (requestorName != null)
		// q.setParameter("requestor_name", requestorName);
		if (status != null)
			q.setParameter("status", status);
		if (userId != null)
			q.setParameter("uId", userId);

		q.setFirstResult((pageNum - 1) * Constants.QUERY_PAGE_SIZE);
		q.setMaxResults(Constants.QUERY_PAGE_SIZE);

		return q.getResultList();
	}

	@Override
	@Transactional(readOnly = true)
	public Long getReservationCount(String readableId, String requestorName,
			Date startDate, Date endDate, ReservationStatus status, Long userId) {
		log.debug("Now is in getReservationCount(readableId,requestorName, status, userId). Parameters are:");
		log.debug(
				"    readableId: {},requestorName:{}, status: {}, userId: {}",
				new Object[] { readableId, requestorName, status, userId });

		CriteriaBuilder cb = em.getCriteriaBuilder();
		CriteriaQuery<Long> cq = cb.createQuery(Long.class);
		Root<Reservation> o = cq.from(Reservation.class);
		cq.select(cb.count(o));

		List<Predicate> criteria = new ArrayList<Predicate>();
		if (readableId != null) {
			// ParameterExpression<String> p = cb.parameter(String.class,
			// "readable_id");
			// criteria.add(cb.equal(o.get("readableId"), p));
			criteria.add(cb.like(o.get("readableId").as(String.class), "%"
					+ readableId + "%"));
		}

		if (requestorName != null) {
			// ParameterExpression<String> p =
			// cb.parameter(String.class,"requestor_name");
			criteria.add(cb.like(o.get("requestorName").as(String.class), "%"
					+ requestorName + "%"));
		}

		if (null != startDate) {
			// ParameterExpression<Date> p = cb.parameter(Date.class,startDate);
			criteria.add(cb.greaterThanOrEqualTo(
					o.get("reservationDate").as(Date.class), startDate));
		}

		if (null != endDate) {
			// ParameterExpression<Date> p =
			// cb.parameter(Date.class,"reserve_date");
			criteria.add(cb.lessThanOrEqualTo(
					o.get("reservationDate").as(Date.class), endDate));
		}

		if (status != null) {
			ParameterExpression<ReservationStatus> p = cb.parameter(
					ReservationStatus.class, "status");
			criteria.add(cb.equal(o.get("reservationStatus"), p));
		}

		if (userId != null) {
			ParameterExpression<Long> p = cb.parameter(Long.class, "uId");
			criteria.add(cb.equal(o.get("user").get("id"), p));
		}

		if (criteria.size() == 1) {
			cq.where(criteria.get(0));
		} else {
			cq.where(cb.and(criteria.toArray(new Predicate[0])));
		}

		TypedQuery<Long> q = em.createQuery(cq);
		// if (readableId != null)
		// q.setParameter("readable_id", readableId);
		// if (requestorName != null)
		// q.setParameter("requestor_name", requestorName);
		if (status != null)
			q.setParameter("status", status);
		if (userId != null)
			q.setParameter("uId", userId);

		return q.getSingleResult();
	}

	public List<ReservSlot> findAllSlots() {

		List<ReservSlot> slots = em.createNamedQuery("ReservSlot.findAll",
				ReservSlot.class).getResultList();

		return slots;
	}
	
	public ReservSlot saveSlot(ReservSlot slot){
		em.persist(slot);
		return slot;
	}
	
	public void deleteAllSlots(){		
		Query deleteQuery = em.createNativeQuery("DELETE FROM reservation_slots");
		deleteQuery.executeUpdate();		
	}
}
