package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.order.Order;
import com.mire.cinema.domain.order.OrderDTO;




@Repository
@Mapper
public interface OrderMapper {
   
	void insertOrder(Order order);
	int countOrderById(String orderId);
	void updateStatus(String orderId, String status);
	
    Order selectOrderByNo(int orderNo);
    Order selectOrderById(String orderId);
    List<OrderDTO.MemberInfo> getPartList(OrderDTO.PageMember page);
    int countOrderbyOrderId();
    int countOrder(String memberId);
    
    List<OrderDTO.MemberInfo> getOrderList(OrderDTO.PageMember page);
    int getTotal();

    void updateOrder(MemberDTO.Update dto);
    
    
    
    int countsearchMember(String memberId);
    
    List<Member> searchPartList(MemberDTO.search dto);

}
