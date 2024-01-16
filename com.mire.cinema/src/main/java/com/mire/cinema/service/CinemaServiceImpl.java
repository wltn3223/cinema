package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.notice.Notice;
import com.mire.cinema.repository.CinemaMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class CinemaServiceImpl implements CinemaService {
	private final CinemaMapper cinemaMapper;


	// 영화관 리스트 출력하기
	@Override
	public List<Cinema> seeCinema() {
		return cinemaMapper.selectCinema();
	}


	// 영화관 내용 업데이트
	@Override
	public void modifyCinema(CinemaDTO.CinemaUpdate cinema) {
		cinemaMapper.updateCinema(cinema);
	}



}
