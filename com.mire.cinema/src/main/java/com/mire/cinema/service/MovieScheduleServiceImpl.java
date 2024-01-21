package com.mire.cinema.service;

import java.time.LocalDateTime;
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

	//예매를 위한 맵
	@Override
	public Map<String, Object> movieScheduleMap(long movieNo, long cinemaNo, LocalDateTime scheduleDate) {
	    // MovieSchedule 객체를 생성하고 필요한 파라미터 설정
	    MovieSchedule movieSchedule = new MovieSchedule();
	    movieSchedule.setMovieNo(movieNo);
	    movieSchedule.setScreenNo(cinemaNo);
	    movieSchedule.setScheduleDate(scheduleDate);

	    // MyBatis의 매퍼를 호출하여 결과를 받아옴
	    MovieSchedule resultSchedule = Mapper.selectMovieSchedule(movieSchedule);

	    // 받아온 결과를 Map으로 변환 (이 부분은 결과 객체의 필드에 따라 조정해야 할 수 있음)
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("movieNo", resultSchedule.getMovieNo());
	    resultMap.put("ScreenNo", resultSchedule.getScreenNo());
	    resultMap.put("scheduleDate", resultSchedule.getScheduleDate());

	    return resultMap;
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

}
