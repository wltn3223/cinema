package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.movieschedule.MovieSchedule;

@Repository
@Mapper
@MapperScan
public interface MovieScheduleMapper {
	// 스케줄 목록
	List<MovieSchedule> scheduleSelect();

	// 스케줄 등록
	void scheduleInsert(MovieSchedule schedule);

	// 스케줄 수정
	void scheduleUpdate(MovieSchedule schedule);

	// 스케줄 삭제
	void scheduleDelete(long scheduleNo);

}
