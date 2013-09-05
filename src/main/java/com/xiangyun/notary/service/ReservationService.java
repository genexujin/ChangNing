package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Reservation;

public interface ReservationService {
    
    Reservation save(Reservation resv);
    
    void delete(Reservation resv);
    
    public Reservation  findByReadableId(String readableId);
    
    public List<Reservation> findByRIdOrRStatus(String readableId,String reservationStatus,int pageNo);

}
