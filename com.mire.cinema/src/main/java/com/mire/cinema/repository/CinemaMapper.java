package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.cinema.Cinema;

@Repository
@Mapper
public interface CinemaMapper {


	public void update(Cinema cinema) throws Exception;

	public List<Cinema> list() throws Exception;
}