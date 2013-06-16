package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Order;

public interface OrderService {
    public List<Order> findAll();

    public Order save(Order user);

    public void delete(Order user);
}
