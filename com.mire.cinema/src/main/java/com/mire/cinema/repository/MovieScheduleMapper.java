package com.mire.cinema.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.stereotype.Repository;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;

@Repository
@Mapper
@MapperScan
public interface MovieScheduleMapper {
	List<MovieSchedule> scheduleSelect();
	//페이징처리 or 
	MovieSchedule selectSchedule(long scheduleNo);
	int countSchedule();
    int countScheduleNo(long scheduleNo);
    int countSearchSchedule(long scheduleNo);
    List<MovieSchedule> getPartList(int start,int end);
    List<MovieSchedule> searchPartList(MovieScheduleDTO.Search dto);
    
	// 스케줄 등록
	void scheduleInsert(MovieSchedule schedule);

	// 스케줄 수정
	void scheduleUpdate(MovieScheduleDTO.Update scheduleDto);

	// 스케줄 삭제
	void scheduleDelete(long scheduleNo);
	
	// 예매에 필요한 리스트
	 MovieSchedule selectMovieSchedule(MovieSchedule movieSchedule);
}
