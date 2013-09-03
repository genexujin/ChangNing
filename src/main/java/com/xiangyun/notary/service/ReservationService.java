package com.xiangyun.notary.service;

import com.xiangyun.notary.domain.Reservation;

public interface ReservationService {
    
    Reservation save(Reservation resv);
    
    void delete(Reservation resv);

}
