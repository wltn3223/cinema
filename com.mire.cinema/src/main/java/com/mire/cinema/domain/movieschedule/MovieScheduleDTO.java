package com.mire.cinema.domain.movieschedule;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class MovieScheduleDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	public static class Insert {
		private long scheduleNo;
		private Date scheduleStartTime;
		private Date scheduleFinishTime;
		private Integer screenTotalSeat;
		private Integer screenRestSeat;
		private Date scheduleDate;
		private long movieNo;
		private long screenNo;
		private int moviePlayTime; 
	}
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	public static class Update {
		private long scheduleNo;
		private Date scheduleStartTime;
		private Date scheduleFinishTime;
		private Integer screenTotalSeat;
		private Integer screenRestSeat;
		private Date scheduleDate;
		private long movieNo;
		private long screenNo;
	}
}
