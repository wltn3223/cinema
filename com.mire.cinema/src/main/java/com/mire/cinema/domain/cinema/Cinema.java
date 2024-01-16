package com.mire.cinema.domain.cinema;

import java.time.LocalDate;

import com.mire.cinema.domain.notice.Notice;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@Builder
public class Cinema {
	private Long cinemaNo;
	private String cinemaName;
    private String cinemaIntro;
	private String cinemaTotalScreen;
	private String cinemaPhone;
	private String cinemaLocation;
}