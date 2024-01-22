package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO.Search;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.MovieScheduleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MovieScheduleServiceImpl implements MovieScheduleService {

	private final MovieScheduleMapper Mapper;

	@Override
	public List<MovieSchedule> scheduleList() {
		return Mapper.scheduleSelect();
	}

	@Override
	public void saveMovieSchedule(MovieSchedule schedule) {
		Mapper.scheduleInsert(schedule);
	}
	
	@Override
	@Transactional
	public void modifyMovieSchedule(MovieScheduleDTO.Update dto) {
		Mapper.scheduleUpdate(dto);
	}

	@Override
	public void removeMovieSchedule(long movieNo) {
		Mapper.scheduleDelete(movieNo);
	}

	@Override
	public MovieSchedule findSchedule(long scheduleNo) {
		MovieSchedule schedule = Mapper.selectSchedule(scheduleNo);
		return schedule;
	}

	@Override
	public int getTotalSchedule() {
		int num = Mapper.countSchedule();
		if (num == 0) {
			throw new NullPointerException(ErrorMsg.DataNOTFOUND);
		}
		return num;
	}

	@Override
	public int getTotalSchedule(long no) {
		return Mapper.countSearchSchedule(no);
	}

	@Override
	public Map<String, Object> getScheduleMap(Integer pageNum, long scheduleNo) {
		Map<String, Object> map = new HashMap<>();
		if (pageNum == null) {
			throw new IllegalArgumentException(ErrorMsg.BADTYPE);
		}
		PageCreate pc = new PageCreate();

		if (scheduleNo == 0 || "".equals(null)) {
			pc = pc.getPage(pageNum, getTotalSchedule());
			map.put("list", Mapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
		} else {
			pc = pc.getPage(pageNum, getTotalSchedule(scheduleNo));
			MovieScheduleDTO.Search dto = new Search();
			dto.setScheduleNo(scheduleNo);
			dto.setStartNum(pc.getPaging().getStartNum());
			dto.setEndNum(pc.getPaging().getEndNum());
			map.put("keyword", scheduleNo);
			map.put("searchList", Mapper.searchPartList(dto));
		}

		map.put("page", pc);
		return map;
	}

}
