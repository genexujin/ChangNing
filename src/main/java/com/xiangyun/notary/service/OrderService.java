package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.domain.Order;

public interface OrderService {
    public List<Order> findAll();
    
    public List<Order> findOrdersByUserId(Long userId);
    
    public List<Order> findOrdersByUserIdAndPage(Long userId, int pageNum);

    public Order save(Order order);

    public void delete(Order order);
    
    public Order findById(Long id);
    
    public List<Order> findOrdersByPage(int pageNum);
    
    public Long getOrderCount();
    
    public Long getOrderCountByUserId(Long userId);
}
