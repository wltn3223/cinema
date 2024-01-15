package com.mire.cinema.domain.cinema;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class CinemaDTO {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class CinemaUpdate {
		private Long cinemaNo;
		@NotBlank(message = "영화관 이름을 입력하세요")
		private String cinemaName;
		@NotBlank(message = "영화관 소개를 입력하세요")
		private String cinemaIntro;
		@NotBlank	(message = "영화관 총상영관 수를 입력하세요")
		private String cinemaTotalScreen;
		@NotBlank(message = "영화관 전화번호를 입력하세요")
		private String cinemaPhone;
		@NotBlank(message = "영화관 위치를 입력하세요")
		private String cinemaLocation;
	}
	
	

}
