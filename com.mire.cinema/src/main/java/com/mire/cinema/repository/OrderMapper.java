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
    Order selectOrderByNo(int orderNo);
    Order selectOrderById(String orderId);
    
    void updateStatus(String orderId, String status);

    List<Member> getOrderList();
    void deleteMember(int OrderNo);

    void updateOrder(MemberDTO.Update dto);
    
    int countOrder();
    int countOrder(String memberId);
    
    int countsearchMember(String memberId);
    
    List<OrderDTO.MemberInfo> getPartList(OrderDTO.PageMember page);
    
    List<Member> searchPartList(MemberDTO.search dto);

}
