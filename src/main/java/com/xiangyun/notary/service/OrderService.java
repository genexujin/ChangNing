package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Order;

public interface OrderService {
    public List<Order> findAll();
    
    public List<Order> findOrdersByUserId(Long userId);

    public Order save(Order order);

    public void delete(Order order);
    
    public Order findById(Long id);
}
