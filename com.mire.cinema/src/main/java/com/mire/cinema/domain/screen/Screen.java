package com.mire.cinema.domain.screen;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Screen {
	private long screenNo;
	private String screenFloor;
	private String screenHall;
	private Integer screenTotalSeat;
	private String cinemaName;
}
