package com.mire.cinema.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO.Search;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO.schedule;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.MovieScheduleMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class MovieScheduleServiceImpl implements MovieScheduleService {

	private final MovieScheduleMapper Mapper;

	// 예매를 위한 맵
	@Override
	public List<MovieScheduleDTO.schedule> movieScheduleMap(long movieNo, long cinemaNo, LocalDate scheduleDate) {
		MovieScheduleDTO.schedule schedule = new schedule();
		schedule.setMovieNo(movieNo);
		schedule.setCinemaNo(cinemaNo);
		schedule.setTime(scheduleDate.toString());
		System.out.println(schedule);

		// MyBatis의 매퍼를 호출하여 결과를 받아옴
		List<MovieScheduleDTO.schedule> movieSchedules = Mapper.selectMovieSchedule(schedule);

		// 받아온 결과를 Map으로 변환 (이 부분은 결과 객체의 필드에 따라 조정해야 할 수 있음)

		return movieSchedules;
	}

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

	@Override
	public LocalDate getDateTime(String dateStr) {

		// DateTimeFormatter을 이용하여 문자열을 LocalDate로 변환
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-d");
		LocalDate localDate = LocalDate.parse(dateStr, formatter);

		System.out.println(localDate);

		// LocalDateTime을 원하는 형식으로 출력

		return localDate;
	}

	@Override
	public void updateSeat(int no, int scheduleNo) {
		Mapper.updateSeat(no, scheduleNo);
		// TODO Auto-generated method stub
		
	}



}
