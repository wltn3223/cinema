package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.domain.reserve.ReserveDTO;
import com.mire.cinema.domain.reserve.ReserveDTO.Count;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.ReserveMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Service
@Slf4j
@RequiredArgsConstructor
public class ReserveServiceImpl implements ReserveService {
	
	private final ReserveMapper reserveMapper;


	
	@Override
	public List<Integer> getSeats(long scheduleNo) {
		return reserveMapper.getTotalSeat(scheduleNo);
	}
	@Override
	public Map<String,Object> getReserveMap(Integer pageNum, String memberId) {
		Map<String, Object> map = new HashMap<>();
		if(pageNum == null) {
			throw new IllegalArgumentException(ErrorMsg.BADTYPE);
		}
		PageCreate pc = new PageCreate();
		
		
		if(memberId == null || "".equals(memberId.trim())) {
			pc = pc.getPage(pageNum, reserveMapper.getTotal());
			map.put("list",reserveMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		}
		
		
		
		else {
			pc = pc.getPage(pageNum, reserveMapper.getMyTotal(memberId));
			ReserveDTO.Count dto = new Count();
			dto.setMemberId(memberId);
			dto.setStart(pc.getPaging().getStartNum());
			dto.setEnd(pc.getPaging().getEndNum());
			map.put("list",reserveMapper.getPartMyList(dto));
			
		}	
		
		map.put("page", pc);
		return map;
	}
	@Override
	public int checkReserve(String orderId) {
		// TODO Auto-generated method stub
		return reserveMapper.countReserve(orderId);
	}
	@Override
	public void delete(String orderId) {
		log.info("주문정보:"  + orderId);
		reserveMapper.deleteReserve(orderId);		
	}
		

}
