package com.mire.cinema.service;

import java.util.List;
import java.util.Map;

public interface ReserveService {
	public List<Integer> getSeats(long scheduleNo);
	public Map<String,Object> getReserveMap(Integer pageNum, String memberId);
	public int checkReserve(String orderId);
	public void delete(String orderId);
	

}
