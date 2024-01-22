package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.notice.Notice;

public interface CinemaService {
	// 영화관 리스트 출력
	public List<Cinema> seeCinema();

	// 공지사항 내용 출력
	public Cinema findCinema(long cinemaNo);

	// 영화관 내용 수정
	public void modifyCinema(CinemaDTO.CinemaUpdate cinema);

}
