package com.mire.cinema.repository;

import java.util.List;

import com.mire.cinema.domain.movieschedule.MovieSchedule;

public interface MovieScheduleMapper {
	//스케줄 목록
	List<MovieSchedule> scheduleSelect();
	//스케줄 등록
	void scheduleInsert(MovieSchedule schedule);
	//스케줄 수정
	void scheduleUpdate(MovieSchedule schedule);
	//스케줄 삭제
	void scheduleDelete(long scheduleNo);
}
