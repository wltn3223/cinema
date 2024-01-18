package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.order.Order;




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
    int countOrdertype(String memberId);
    
    int countsearchMember(String memberId);
    
    List<Member> getPartList(int start,int end);
    
    List<Member> searchPartList(MemberDTO.search dto);

}
