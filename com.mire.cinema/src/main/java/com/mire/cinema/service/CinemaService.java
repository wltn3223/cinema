package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.cinema.Cinema;





public interface CinemaService {


	public void modify(Cinema cinema) throws Exception;


	public List<Cinema> list() throws Exception;
}