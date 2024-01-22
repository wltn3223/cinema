package com.mire.cinema.service;

import java.util.Map;
import java.util.List;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;

public interface MovieScheduleService {
	// 등록
	public List<MovieSchedule> scheduleList();// 비교를 위한 리스트 가져옴.

	public void saveMovieSchedule(MovieSchedule schedule);

	// 리스트 출력
	public MovieSchedule findSchedule(long scheduleNo);

	public int getTotalSchedule();

	public int getTotalSchedule(long no);

	public Map<String, Object> getScheduleMap(Integer pageNum, long scheduleNo);

	// 수정
	public void modifyMovieSchedule(MovieScheduleDTO.Update dto);

	// 삭제
	public void removeMovieSchedule(long movieNo);

	// 예매를 위한 리스트
	public List<MovieScheduleDTO.schedule> movieScheduleMap(long movieNo, long screenNo, LocalDate scheduleDate);

	public LocalDate getDateTime(String date);

}
