package com.mire.cinema.domain.movieschedule;

import java.util.Date;

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
	private Date scheduleStartTime;
	private Date scheduleFinishTime;
	private Integer screenTotalSeat;
	private Integer screenRestSeat;
	private Date scheduleDate;
	private long movieNo;
	private long screenNo;
}
