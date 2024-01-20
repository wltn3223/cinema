package com.mire.cinema.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO.Update;
import com.mire.cinema.repository.MovieScheduleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MovieScheduleServiceImpl implements MovieScheduleService {

	private final MovieScheduleMapper Mapper;
	private final MovieService movieService;
	
	@Override
	public void saveMovieSchedule(MovieSchedule schedule) {
		Mapper.scheduleInsert(schedule);
	}

	@Override
	public List<MovieSchedule> ScheduleList() {
		return Mapper.scheduleSelect();
	}

	@Override
	public void modifyMovieSchedule(Update update) {
		int moviePlayTime = movieService.findMovie(update.getMovieNo()).getMoviePlayTime();
		MovieSchedule schedule = MovieSchedule.builder().scheduleNo(update.getScheduleNo())
				.scheduleDate(update.getScheduleDate()).scheduleStartTime(update.getScheduleStartTime())
				.scheduleFinishTime(update.getScheduleFinishTime().plusMinutes(moviePlayTime)).build();
		Mapper.scheduleUpdate(schedule);
	}

	@Override
	public void removeMovieSchedule(long movieNo) {
		Mapper.scheduleDelete(movieNo);
	}

}
