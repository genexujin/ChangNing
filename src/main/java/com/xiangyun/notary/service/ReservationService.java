package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.User;

public interface ReservationService {
    
    Reservation save(Reservation resv);
    
    void delete(Reservation resv);
    
    public Reservation  findByReadableId(String readableId);
    
    public Long getReservationCount(String readableId, ReservationStatus status, Long userId) ;

    public List<Reservation> findReservations(String readableId, ReservationStatus status, Long userId, int pageNum);

	boolean checkCompliance(User user);
}
