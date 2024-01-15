package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.cinema.CinemaDTO.CinemaUpdate;





public interface CinemaService {


	public void modifyCinema(Cinema cinema)throws Exception;


	public List<Cinema> list() throws Exception;


}