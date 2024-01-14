package com.mire.cinema.domain.screen;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class ScreenDTO {
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Update {
		private Long screenNo;
		@NotBlank(message = "몇층 인지 입력해주세요")
		private String screenFloor;
		@NotBlank(message = "몇관 인지 입력해주세요")
		private String screenHall;
		@NotBlank(message = "상영관 총 좌석을 입력해주세요")
		private Integer screenTotalSeat;
	}
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class insert {
		private long screenNo;
		private String screenFloor;
		private String screenHall;
		private Integer screenTotalSeat;
		private long cinemaNo;
	}
}
