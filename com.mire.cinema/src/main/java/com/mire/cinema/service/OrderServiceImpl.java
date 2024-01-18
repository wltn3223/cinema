package com.mire.cinema.service;

import org.springframework.stereotype.Service;

import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.order.Order;
import com.mire.cinema.domain.order.OrderDTO;
import com.mire.cinema.domain.order.OrderStatus;
import com.mire.cinema.repository.ItemGiftCardMapper;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.repository.OrderMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {
	private final MemberMapper memberMapper;
	private final ItemGiftCardMapper itemGiftCardMapper;
	private final OrderMapper orderMapper;
	
	
	
	@Override
	public void createOrder(OrderDTO.Info orderinfo) {
		Order order = Order.builder()
				.orderId(orderinfo.getOrderId())
				.orderQuantity(orderinfo.getNumber())
				.orderPrice(orderinfo.getTotalPrice())
				.discountPrice(orderinfo.getDiscountPrice())
				.orderStatus(OrderStatus.PROCESS)
				.itemNo(orderinfo.getItemNo())
				.memberId(orderinfo.getMemberId())
				.build();
		
		log.info(order.toString());
		orderMapper.insertOrder(order);
	}
	
	@Override
	public OrderDTO.Info getBuyerInfo(String memberId, long itemNo, int number) {
		Member member = memberMapper.selectMember(memberId);
		ItemGiftCard giftCard = itemGiftCardMapper.selectItemGiftCard(itemNo);
		
		OrderDTO.Info dto = OrderDTO.Info.builder()
				.memberId(member.getMemberId())
				.memberGrade(member.getMemberGrade().getGrade())
				.itemNo(giftCard.getItemNo())
				.itemName(giftCard.getItemName())
				.itemUuid(giftCard.getImageUuid())
				.price(giftCard.getItemPrice())
				.number(number)
				.build();
		
		dto.calTotalPrice();
		dto.calDistcountPrice(member.getMemberGrade().getDiscountRate());
			
		
		createOrder(dto);
		
		
		
		
		return dto;
	}

	@Override
	public void modifyStatus(int orderNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void modifyOrderInfo(Order order) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Order selectOrder(int orderNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteOrder(int orderNo) {
		// TODO Auto-generated method stub
		
	}

}
