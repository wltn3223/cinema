package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.repository.CinemaMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class CinemaServiceImpl implements CinemaService {
	
	private final CinemaMapper cinemaMapper;


	@Override
	public Cinema read(Long cinemaNo) throws Exception {
		return cinemaMapper.read(cinemaNo);
	}

	@Override
	public void modify(Cinema cinema) throws Exception {
		cinemaMapper.update(cinema);
	}


	@Override
	public List<Cinema> list() throws Exception {
		return cinemaMapper.list();
	}
}
