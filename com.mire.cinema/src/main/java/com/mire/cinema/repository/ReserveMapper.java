package com.mire.cinema.repository;

import java.util.List;		

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.reserve.Reserve;
import com.mire.cinema.domain.reserve.ReserveDTO;

@Mapper
@Repository
public interface ReserveMapper {
	public List<Integer> getTotalSeat(long scheduleNo);
	public void insertReserve(Reserve reserve);
	
	public List<ReserveDTO.Info> getPartList(int start, int end);
	
	public List<ReserveDTO.Info> getPartMyList(ReserveDTO.Count dto);
	public int getMyTotal(String memberId);
	public int getTotal();
	public int countReserve(String orderId);
	public void deleteReserve(String orderId);
	public Reserve getReserve(String orderId);
}
