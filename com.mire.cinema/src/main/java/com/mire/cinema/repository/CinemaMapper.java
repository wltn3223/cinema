package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.cinema.CinemaDTO;
import com.mire.cinema.domain.notice.Notice;

@Repository
@Mapper
@MapperScan
public interface CinemaMapper {

	// 영화관 리스트 출력하기
	List<Cinema> selectCinema();
	

	// 영화관 리스트 수정하기
	void updateCinema(CinemaDTO.CinemaUpdate cinema);
	

}
