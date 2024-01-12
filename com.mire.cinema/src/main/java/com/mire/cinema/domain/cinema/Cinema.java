package com.mire.cinema.domain.cinema;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Cinema {
	private Long cinemaNo;
	private String cinemaName;
    private String cinemaIntro;
	private String cinemaTotalScreen;
	private String cinemaPhone;
	private String cinemaLocation;
	private String cinemaLocawdation;
}