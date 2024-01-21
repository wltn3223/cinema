package com.mire.cinema.domain.movieschedule;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MovieSchedule {
	private long scheduleNo;
	private LocalDateTime scheduleStartTime;
	private LocalDateTime scheduleFinishTime;
	private Integer screenTotalSeat;
	private Integer screenRestSeat;
	private LocalDateTime scheduleDate;
	private long movieNo;
	private long screenNo;
}
