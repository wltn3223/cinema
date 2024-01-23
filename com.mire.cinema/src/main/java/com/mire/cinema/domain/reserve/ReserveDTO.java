package com.mire.cinema.domain.reserve;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

public class ReserveDTO {
	
	@Builder
	@Data
	public static class Info{
		private long reserveNo;
		private int seatNo;
		private String orderId;
		private String memberId;
		private String movieTitle;
		private String scheduleStartTime;
		private String scheduleFinishTime;
		private String screenFloor;
		private String screenHall;
		
	}
	
	
	
	@Data
	public static class Count{
		private String memberId;
		private int start;
		private int end;
	}
	
}
