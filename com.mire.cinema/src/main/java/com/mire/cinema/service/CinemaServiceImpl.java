package com.mire.cinema.service;

import java.util.List;

import org.springframework.http.HttpStatusCode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.cinema.CinemaDTO.CinemaUpdate;
import com.mire.cinema.repository.CinemaMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class CinemaServiceImpl implements CinemaService {
	
	private final CinemaMapper cinemaMapper;



	


	@Override
	public List<Cinema> list() throws Exception {
		return cinemaMapper.list();
	}


	@Override
	public void modifyCinema(Cinema cinema) throws Exception {
		return;
		
	}
}
