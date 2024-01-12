package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.cinema.Cinema;





public interface CinemaService {

	public Cinema read(Long cinemaNo) throws Exception;

	public void modify(Cinema cinema) throws Exception;


	public List<Cinema> list() throws Exception;
}