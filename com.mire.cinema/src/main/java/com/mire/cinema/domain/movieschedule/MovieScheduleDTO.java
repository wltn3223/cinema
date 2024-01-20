package com.mire.cinema.domain.movieschedule;

import java.time.LocalDateTime;
import java.util.Date;

import com.mire.cinema.service.MovieService;

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
		private LocalDateTime scheduleStartTime;
		private LocalDateTime scheduleFinishTime;
		private Integer screenTotalSeat;
		private Integer screenRestSeat;
		private Date scheduleDate;
		private long movieNo;
		private long screenNo;
	}
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	public static class Update {
		private long scheduleNo;
		private LocalDateTime scheduleStartTime;
		private LocalDateTime scheduleFinishTime;
		private Integer screenTotalSeat;
		private Integer screenRestSeat;
		private Date scheduleDate;
		private long movieNo;
		private long screenNo;
	}
}
