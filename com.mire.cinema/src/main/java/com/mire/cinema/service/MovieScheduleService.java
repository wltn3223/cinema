package com.mire.cinema.service;

import java.util.List;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;

public interface MovieScheduleService {
	// 등록
	public void saveMovieSchedule(MovieSchedule schedule);

	// 리스트 출력
	public List<MovieSchedule> ScheduleList();

	// 수정
	public void modifyMovieSchedule(MovieScheduleDTO.Update update);

	// 삭제
	public void removeMovieSchedule(long movieNo);

}
