package com.xiangyun.notary.service;

import java.util.List;

import com.xiangyun.notary.common.OrderStatus;
import com.xiangyun.notary.domain.Order;

public interface OrderService {
    List<Order> findAll();
    
    List<Order> findOrdersByUserId(Long userId);
    
    List<Order> findOrdersByUserIdAndPage(Long userId, int pageNum);
    
    List<Order> findOrders(String readableId, OrderStatus status, Long userId, int pageNum);
    
    Order findOrderById(Long orderId, Long userId);

    Order save(Order order);

    void delete(Order order);
    
    Order findById(Long id);
    
    List<Order> findOrdersByPage(int pageNum);
    
    Long getOrderCount();
    
    Long getOrderCount(String readableId, OrderStatus status, Long userId);
    
    Long getOrderCountByUserId(Long userId);
}
