package com.mire.cinema.domain.movieschedule;

import java.time.LocalDateTime;
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
	// MovieScheduleDTO.java
	public static class Update {
		private String scheduleNo;
		private LocalDateTime scheduleStartTime;
		private LocalDateTime scheduleFinishTime;
		private long screenNo;
		private long movieNo;
		private String screenTotalSeat;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	@Builder
	public static class Info {
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
	public static class Search {
		private long scheduleNo;
		private int startNum;
		private int endNum;
	}

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class schedule {
		private long cinemaNo;
		private String time;
		private long scheduleNo;
		private LocalDateTime scheduleStartTime;
		private LocalDateTime scheduleFinishTime;
		private Integer screenTotalSeat;
		private Integer screenRestSeat;
		private long movieNo;
		private long screenNo;
		private String screenFloor;
		private String screenHall;
	}
}
